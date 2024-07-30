import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:lg_ai_touristic_explorer/components/carousel_card.dart';
import 'package:lg_ai_touristic_explorer/components/download_option.dart';
import 'package:lg_ai_touristic_explorer/components/drawer.dart';
import 'package:lg_ai_touristic_explorer/components/upper_bar.dart';
import 'package:lg_ai_touristic_explorer/connections/ai_model.dart';
import 'package:lg_ai_touristic_explorer/connections/lg_connection.dart';
import 'package:lg_ai_touristic_explorer/connections/orbit_connection.dart';
import 'package:lg_ai_touristic_explorer/models/city.dart';
import 'package:lg_ai_touristic_explorer/models/flyto.dart';
import 'package:lg_ai_touristic_explorer/models/orbit.dart';
import 'package:lg_ai_touristic_explorer/models/place.dart';
import 'package:lg_ai_touristic_explorer/utils/cityKMLData.dart';
import 'package:lg_ai_touristic_explorer/utils/common.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../components/connection_flag.dart';
import '../constants/constants.dart';
import '../constants/images.dart';
import '../constants/text_styles.dart';
import 'package:http/http.dart' as http;

class CityInformationScreen extends StatefulWidget {
  final City? cityGiven;
  final List<Place>? cityPOI;
  final String cityName;
  final String countryName;
  final LatLng coordinates;
  const CityInformationScreen(
      {required this.cityName,
      required this.countryName,
      required this.coordinates,
      this.cityGiven,
      this.cityPOI});

  @override
  State<CityInformationScreen> createState() => _CityInformationScreenState();
}

class _CityInformationScreenState extends State<CityInformationScreen> {
  bool lgStatus = false;
  bool aiStatus = false;
  late LGConnection lg;

  List<Widget> historyCarouselCards = [
    const CarouselCard(
      factTitle: "Geographical Fact",
      factDesc:
          "factfactfactfactfactfactfactfactfactfactfactfactfactfactfactfactfactfactfactfactfactfactfactfactfactfactfactfactfactfactfactfactfactfactfactfactfactfactfactfactfactfactfactfactfactfactfactfactfactfactfactfactfactfactfactfactfactfactfactfact",
    )
  ];
  List<Widget> cultureCarouselCards = [
    const CarouselCard(
      factTitle: "Geographical Fact",
      factDesc:
          "factfactfactfactfactfactfactfactfactfactfactfactfactfactfactfactfactfactfactfactfactfactfactfactfactfactfactfactfactfactfactfactfactfactfactfactfactfactfactfactfactfactfactfactfactfactfactfactfactfactfactfactfactfactfactfactfactfactfactfact",
    )
  ];
  List<Widget> geographyCarouselCards = [
    const CarouselCard(
      factTitle: "Geographical Fact",
      factDesc:
          "factfactfactfactfactfactfactfactfactfactfactfactfactfactfactfactfactfactfactfactfactfactfactfactfactfactfactfactfactfactfactfactfactfactfactfactfactfactfactfactfactfactfactfactfactfactfactfactfactfactfactfactfactfactfactfactfactfactfactfact",
    )
  ];
  List<Widget> poiCarouselCards = [
    const CarouselCard(
      factTitle: "cityName",
      factDesc:
          "factfactfactfactfactfactfactfactfactfactfactfactfactfactfactfactfactfactfactfactfactfactfactfactfactfactfactfactfactfactfactfactfactfactfactfactfactfactfactfactfactfactfactfactfactfactfactfactfactfactfactfactfactfactfactfactfactfactfactfact",
    )
  ];
  CarouselController carouselController = CarouselController();
  late City city;
  bool isLoading = true;
  Future<void> _connectToLG() async {
    bool? result = await lg.connectToLG();
    setState(() {
      lgStatus = result!;
    });
    double longitude = widget.coordinates.longitude;
    double latitude = widget.coordinates.latitude;
    double range = 5000;
    double tilt = 0;
    double heading = 0;
    FlyToView city = FlyToView(
        longitude: longitude,
        latitude: latitude,
        range: range,
        tilt: tilt,
        heading: heading);
    await lg.flyTo(city.getCommand());
  }

  late List<Place> places;
  bool isPlaceGenerated = false;
  bool isHistory = true;
  bool isCulture = false;
  bool isGeography = false;
  bool isExtra = false;
  bool isPresent = false;
  bool isPOI = false;
  bool isRunning = false;
  void initCards(City city, List<Place> pois) {
    print("GOT IT");
    historyCarouselCards.clear();
    cultureCarouselCards.clear();
    geographyCarouselCards.clear();
    poiCarouselCards.clear();

    for (var culturalFact in city.culturalFacts) {
      cultureCarouselCards.add(CarouselCard(
        factTitle: "Cultural Fact",
        factDesc: culturalFact.fact,
      ));
    }

    for (var geographicalFact in city.geographicalFacts) {
      geographyCarouselCards.add(CarouselCard(
        factTitle: "Geographical Fact",
        factDesc: geographicalFact.fact,
      ));
    }

    for (var historicalFact in city.historicalFacts) {
      historyCarouselCards.add(CarouselCard(
        factTitle: "Historical Fact",
        factDesc: historicalFact.fact,
      ));
    }
    for (Place places in pois) {
      poiCarouselCards.add(CarouselCard(
        factTitle: places.name,
        factDesc: places.details,
      ));
    }
  }

  bool isURL = false;
  String img = "";
  getCityData() async {
    String cityName = widget.cityName;
    LatLng coordinates = widget.coordinates;
    city = await getCityInformation(
        "${cityName}, ${widget.countryName}", coordinates);

    List<Place> data = await generatePlaces();
    setState(() {
      isLoading = false;
      isPlaceGenerated = true;
    });
    initCards(city, data);
  }

  var visualisationOptions = [];
  checkForExtra() {
    bool present = checkIsExtra(widget.cityName);
    setState(() {
      isPresent = present;
    });
    if (isPresent) {
      setState(() {
        visualisationOptions = getVisualisationOptions(widget.cityName);
      });
    }
  }

  _connectToAIServer() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String ipAIServer = prefs.getString("ipAIServer") ?? "127.0.0.1";
      String portAIServer = prefs.getString("portAIServer") ?? "8107";
      String apiURL = "http://$ipAIServer:$portAIServer/hello";
      http.Response response = await http.get(Uri.parse(apiURL));
      if (response.statusCode == 200) {
        setState(() {
          aiStatus = true;
        });
      } else {}
    } catch (e) {
      print('Error checking AI server connection: $e');
      return false;
    }
  }

  _checkGiven() {
    if (widget.cityGiven != null && widget.cityPOI != null) {
      city = widget.cityGiven!;
      places = widget.cityPOI!;
      checkForExtra();
      initCards(city, places);
      setState(() {
        isLoading = false;
        isPlaceGenerated = true;
      });
    } else {
      checkForExtra();
      getCityData();
    }
  }

  Future<List<Place>> generatePlaces() async {
    places = await generatePOI(widget.cityName, widget.coordinates);
    print(places.toString());
    return places;
  }

  @override
  void initState() {
    super.initState();
    lg = LGConnection();
    _connectToLG();
    _connectToAIServer();
    _checkGiven();
    // getCityData();
  }

  clean() async {
    await lg.cleanRightBalloon();
    await lg.cleanVisualization();
  }

  Future<void> wait20Seconds() async {
    await Future.delayed(Duration(seconds: 20));
  }

  @override
  void dispose() {
    clean();
    super.dispose();
  }

  final _scaffoldKey = GlobalKey<ScaffoldState>();
  bool anim = true;
  @override
  Widget build(BuildContext context) {
    CameraPosition _kGooglePlex = CameraPosition(
      target: widget.coordinates,
      zoom: 12,
    );
    late CameraPosition changedMapPosition;
    var size = MediaQuery.of(context).size;
    return Scaffold(
      key: _scaffoldKey,
      endDrawer: AppDrawer(size: size),
      backgroundColor: darkBackgroundColor,
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(140.0),
          child: UpperBar(
              lgStatus: lgStatus,
              aiStatus: aiStatus,
              scaffoldKey: _scaffoldKey)),
      body: Container(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Left side of the Application
                SingleChildScrollView(
                  child: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 30, 0, 15),
                      child: !isExtra
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // City Name
                                // ElevatedButton(
                                //     onPressed: () async {
                                //       print(checkIsExtra(widget.cityName));

                                //       // String imgURL = await getPlaceIdFromName(
                                //       //     "bollywood mumbai");
                                //       // print("this is : $imgURL");
                                //       setState(() {
                                //         isURL = false;
                                //         // img = imgURL;
                                //       });
                                //     },
                                //     child: Text("Hello")),
                                // isURL ? Image.network(img) : Container(),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    15.pw,
                                    Icon(
                                      Icons.location_pin,
                                      color: Colors.red,
                                      size: 45.h,
                                    ),
                                    8.pw,
                                    Container(
                                      width: size.width * 0.30,
                                      child: Text(
                                        "${widget.cityName}, ${widget.countryName}",
                                        style: googleTextStyle(
                                            45.sp, FontWeight.w700, white),
                                        overflow: TextOverflow.clip,
                                      ),
                                    ),
                                  ],
                                ),
                                35.ph,
                                //Tabs
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    30.pw,
                                    GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            isHistory = true;
                                            isCulture = false;
                                            isPOI = false;
                                            isGeography = false;
                                          });
                                        },
                                        child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              color: isHistory && !isPOI
                                                  ? darkSecondaryColor
                                                  : darkSecondaryColor
                                                      .withOpacity(0.4),
                                            ),
                                            alignment: Alignment.center,
                                            width: size.width * 0.12,
                                            height: 55,
                                            child: Text(
                                              "History",
                                              style: googleTextStyle(33.sp,
                                                  FontWeight.w500, white),
                                            ))),
                                    30.pw,
                                    GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            isHistory = false;
                                            isCulture = false;
                                            isPOI = false;
                                            isGeography = true;
                                          });
                                        },
                                        child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              color: isGeography && !isPOI
                                                  ? darkSecondaryColor
                                                  : darkSecondaryColor
                                                      .withOpacity(0.4),
                                            ),
                                            alignment: Alignment.center,
                                            width: size.width * 0.12,
                                            height: 55,
                                            child: Text(
                                              "Geography",
                                              style: googleTextStyle(33.sp,
                                                  FontWeight.w500, white),
                                            ))),
                                    30.pw,
                                    GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            isHistory = false;
                                            isCulture = true;
                                            isGeography = false;
                                            isPOI = false;
                                          });
                                        },
                                        child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              color: isCulture && !isPOI
                                                  ? darkSecondaryColor
                                                  : darkSecondaryColor
                                                      .withOpacity(0.4),
                                            ),
                                            alignment: Alignment.center,
                                            width: size.width * 0.12,
                                            height: 55,
                                            child: Text(
                                              "Culture",
                                              style: googleTextStyle(33.sp,
                                                  FontWeight.w500, white),
                                            ))),
                                  ],
                                ),
                                55.ph,
                                // Carousel
                                AnimatedSwitcher(
                                  duration: Duration(seconds: 2),
                                  child: Skeletonizer(
                                      enabled: isLoading,
                                      enableSwitchAnimation: true,
                                      child: Container(
                                        width: size.width * .45,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            isPOI
                                                ? AnimatedSwitcher(
                                                    duration:
                                                        Duration(seconds: 1),
                                                    child: Container(
                                                      height:
                                                          size.height * 0.45,
                                                      width: size.width * 0.38,
                                                      child: CarouselSlider(
                                                          carouselController:
                                                              carouselController,
                                                          items:
                                                              poiCarouselCards,
                                                          options:
                                                              CarouselOptions(
                                                            enlargeCenterPage:
                                                                true,
                                                            height: 700,
                                                            initialPage: 0,
                                                            scrollDirection:
                                                                Axis.horizontal,
                                                            autoPlay: false,
                                                          )),
                                                    ),
                                                  )
                                                : isHistory
                                                    ? AnimatedSwitcher(
                                                        duration: Duration(
                                                            seconds: 1),
                                                        child: Container(
                                                          height: size.height *
                                                              0.45,
                                                          width:
                                                              size.width * 0.38,
                                                          child: CarouselSlider(
                                                              items:
                                                                  historyCarouselCards,
                                                              options:
                                                                  CarouselOptions(
                                                                enlargeCenterPage:
                                                                    true,
                                                                height: 700,
                                                                initialPage: 0,
                                                                scrollDirection:
                                                                    Axis.horizontal,
                                                                autoPlayInterval:
                                                                    const Duration(
                                                                        milliseconds:
                                                                            5000),
                                                                autoPlay: false,
                                                              )),
                                                        ),
                                                      )
                                                    : AnimatedSwitcher(
                                                        duration: Duration(
                                                            seconds: 1),
                                                        child: isCulture
                                                            ? Container(
                                                                height:
                                                                    size.height *
                                                                        0.45,
                                                                width:
                                                                    size.width *
                                                                        0.38,
                                                                child:
                                                                    CarouselSlider(
                                                                        items:
                                                                            cultureCarouselCards,
                                                                        options:
                                                                            CarouselOptions(
                                                                          enlargeCenterPage:
                                                                              true,
                                                                          height:
                                                                              700,
                                                                          initialPage:
                                                                              0,
                                                                          scrollDirection:
                                                                              Axis.horizontal,
                                                                          autoPlayInterval:
                                                                              const Duration(milliseconds: 5000),
                                                                          autoPlay:
                                                                              false,
                                                                        )),
                                                              )
                                                            : AnimatedSwitcher(
                                                                duration:
                                                                    Duration(
                                                                        seconds:
                                                                            1),
                                                                child:
                                                                    Container(
                                                                  height:
                                                                      size.height *
                                                                          0.45,
                                                                  width:
                                                                      size.width *
                                                                          0.38,
                                                                  child:
                                                                      CarouselSlider(
                                                                          items:
                                                                              geographyCarouselCards,
                                                                          options:
                                                                              CarouselOptions(
                                                                            enlargeCenterPage:
                                                                                true,
                                                                            height:
                                                                                700,
                                                                            initialPage:
                                                                                0,
                                                                            scrollDirection:
                                                                                Axis.horizontal,
                                                                            autoPlayInterval:
                                                                                const Duration(milliseconds: 5000),
                                                                            autoPlay:
                                                                                false,
                                                                          )),
                                                                ),
                                                              ),
                                                      ),
                                          ],
                                        ),
                                      )),
                                ),
                              ],
                            )
                          : Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: SingleChildScrollView(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // City Name
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Icon(
                                          Icons.location_pin,
                                          color: Colors.red,
                                          size: 45.h,
                                        ),
                                        8.pw,
                                        Container(
                                          width: size.width * 0.30,
                                          child: Text(
                                            "${widget.cityName}, ${widget.countryName}",
                                            style: googleTextStyle(
                                                48.sp, FontWeight.w700, white),
                                            overflow: TextOverflow.clip,
                                          ),
                                        ),
                                      ],
                                    ),
                                    35.ph,
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          isExtra = !isExtra;
                                        });
                                      },
                                      child: Container(
                                          alignment: Alignment.center,
                                          height: size.height * .055,
                                          width: size.width * 0.046,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            color: greenShade,
                                          ),
                                          child: Icon(
                                              Icons.arrow_back_ios_rounded)),
                                    ),
                                    35.ph,
                                    Container(
                                      padding: const EdgeInsets.only(left: 50),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Extra Visualisations",
                                            style: googleTextStyle(48.sp,
                                                FontWeight.w700, greenShade),
                                            overflow: TextOverflow.clip,
                                          ),
                                          30.ph,
                                          ...visualisationOptions
                                              .map((option) => DownloadWidget(
                                                    option: option,
                                                    size: size,
                                                    cityName: widget.cityName,
                                                    coordinates:
                                                        widget.coordinates,
                                                    country: widget.countryName,
                                                  ))
                                              .toList(),
                                          20.ph,
                                        ],
                                      ),
                                    ),
                                    15.ph,
                                  ],
                                ),
                              ),
                            )),
                ),
                // Right side of the Application

                Container(
                  padding: const EdgeInsets.fromLTRB(0, 15, 15, 0),
                  child: Column(
                    children: [
                      Container(
                        alignment: Alignment.topCenter,
                        clipBehavior: Clip.hardEdge,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(22)),
                        width: size.width * 0.5,
                        height: size.height * 0.53,
                        child: GoogleMap(
                          myLocationEnabled: false,
                          zoomGesturesEnabled: false,
                          mapType: MapType.satellite,
                          myLocationButtonEnabled: false,
                          initialCameraPosition: _kGooglePlex,
                          onCameraMove: (position) =>
                              setState(() => changedMapPosition = position),
                          onCameraIdle: () async {
                            await lg.stopOrbit();
                            FlyToView newPosition = FlyToView(
                                longitude: changedMapPosition.target.longitude,
                                latitude: changedMapPosition.target.latitude,
                                range: changedMapPosition.zoom.zoomLG,
                                tilt: changedMapPosition.tilt,
                                heading: changedMapPosition.bearing);
                            await lg.flyTo(newPosition.getCommand());
                          },
                          onMapCreated: (GoogleMapController controller) {
                            // _controllerGoogleMap.complete(controller);
                            // newGoogleMapController = controller;
                          },
                        ),
                      ),
                      15.ph,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          // Text(
                          //   "Some Commands:",
                          //   style:
                          //       googleTextStyle(40.sp, FontWeight.w600, white),
                          // ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                isPOI = !isPOI;
                                isExtra = false;
                              });
                            },
                            child: Container(
                              alignment: Alignment.center,
                              height: size.height * .07,
                              width: isPresent
                                  ? size.width * 0.24
                                  : size.width * 0.495,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: isPOI ? greenShade : darkSecondaryColor,
                              ),
                              child: Text(
                                "Points of Interest",
                                style: googleTextStyle(33.sp, FontWeight.w500,
                                    isPOI ? fontGreen : white),
                              ),
                            ),
                          ),
                          isPresent ? 20.pw : Container(),
                          isPresent
                              ? GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      isExtra = !isExtra;
                                      isPOI = false;
                                    });
                                  },
                                  child: Container(
                                    alignment: Alignment.center,
                                    height: size.height * .07,
                                    width: size.width * 0.24,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: isExtra
                                          ? greenShade
                                          : darkSecondaryColor,
                                    ),
                                    child: Text(
                                      "Extra",
                                      style: googleTextStyle(
                                          30.sp,
                                          FontWeight.w500,
                                          isExtra ? fontGreen : white),
                                    ),
                                  ),
                                )
                              : Container()
                        ],
                      ),
                      10.ph,
                      Row(
                        children: [
                          !isRunning
                              ? GestureDetector(
                                  onTap: () async {
                                    if (!isPlaceGenerated) {
                                      print("not generated");
                                      // places = await generatePOI(
                                      //     widget.cityName, widget.coordinates);
                                      // print(places.toString());
                                      // isPlaceGenerated = true;
                                      // for (var i = 0; i < 2; i++) {
                                      //   String placesdata =
                                      //       Orbit().generateOrbit(places);
                                      //   String content =
                                      //       Orbit().buildOrbit(placesdata, places);
                                      //   print(content);
                                      //   await lg.buildOrbit(content);
                                      //   await Future.delayed(Duration(seconds: 1));
                                      // }
                                      // for (int i = 0; i < places.length; i++) {
                                      //   await lg.openBalloon(
                                      //       "orbitballoon",
                                      //       places[i].name,
                                      //       widget.cityName,
                                      //       500,
                                      //       places[i].details,
                                      //       places[i].latitude,
                                      //       places[i].longitude);
                                      //   await wait20Seconds();
                                      // }
                                    } else {
                                      setState(() {
                                        isPOI = true;
                                        isRunning = true;
                                      });
                                      print("generated");
                                      await lg.cleanVisualization();
                                      for (var i = 0; i < 2; i++) {
                                        String placesdata =
                                            Orbit().generateOrbit(places);
                                        String content = Orbit()
                                            .buildOrbit(placesdata, places);
                                        print(content);
                                        await lg.buildOrbit(content);
                                        await Future.delayed(
                                            Duration(seconds: 1));
                                      }
                                      for (int i = 0; i < places.length; i++) {
                                        print(i);
                                        carouselController.nextPage();

                                        // Iterable<int>.generate(
                                        //         poiCarouselCards.length)
                                        //     .map(
                                        //   (int pageIndex) => carouselController
                                        //       .animateToPage(pageIndex),
                                        // );
                                        print(isRunning);
                                        if (isRunning) {
                                          await lg.sendStaticBalloon(
                                              "orbitballoon",
                                              places[i].name,
                                              widget.cityName,
                                              500,
                                              places[i].details,
                                              places[i].imageUrl);
                                          await wait20Seconds();
                                        }
                                      }
                                    }
                                  },
                                  child: Container(
                                    alignment: Alignment.center,
                                    height: size.height * .15,
                                    width: size.width * 0.24,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: darkSecondaryColor,
                                    ),
                                    child: Text(
                                      "Start Orbit",
                                      style: googleTextStyle(
                                          37.sp, FontWeight.w500, white),
                                    ),
                                  ),
                                )
                              : GestureDetector(
                                  onTap: () async {
                                    await lg.stopOrbit();
                                    setState(() {
                                      isRunning = false;
                                    });
                                  },
                                  child: Container(
                                    alignment: Alignment.center,
                                    height: size.height * .15,
                                    width: size.width * 0.24,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: Colors.amber,
                                    ),
                                    child: Text(
                                      "Stop Orbit",
                                      style: googleTextStyle(
                                          37.sp, FontWeight.w600, Colors.black),
                                    ),
                                  ),
                                ),
                          20.pw,
                          Container(
                            alignment: Alignment.center,
                            height: size.height * .15,
                            width: size.width * 0.24,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: darkSecondaryColor,
                            ),
                            child: Text(
                              "Narrate as Story!",
                              style: googleTextStyle(
                                  37.sp, FontWeight.w500, white),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
