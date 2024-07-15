import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:lg_ai_touristic_explorer/components/carousel_card.dart';
import 'package:lg_ai_touristic_explorer/components/drawer.dart';
import 'package:lg_ai_touristic_explorer/connections/ai_model.dart';
import 'package:lg_ai_touristic_explorer/connections/lg_connection.dart';
import 'package:lg_ai_touristic_explorer/connections/orbit_connection.dart';
import 'package:lg_ai_touristic_explorer/models/city.dart';
import 'package:lg_ai_touristic_explorer/models/flyto.dart';
import 'package:lg_ai_touristic_explorer/models/orbit.dart';
import 'package:lg_ai_touristic_explorer/models/place.dart';
import 'package:lg_ai_touristic_explorer/utils/common.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../components/connection_flag.dart';
import '../constants/constants.dart';
import '../constants/images.dart';
import '../constants/text_styles.dart';
import 'package:http/http.dart' as http;

class CityInformationScreen extends StatefulWidget {
  final String cityName;
  final String countryName;
  final LatLng coordinates;
  const CityInformationScreen(
      {super.key,
      required this.cityName,
      required this.countryName,
      required this.coordinates});

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

  void initCards(City city) {
    historyCarouselCards.clear();
    cultureCarouselCards.clear();
    geographyCarouselCards.clear();

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
  }

  getCityData() async {
    String cityName = widget.cityName;
    LatLng coordinates = widget.coordinates;
    city = await getCityInformation(
        "${cityName}, ${widget.countryName}", coordinates);
    setState(() {
      isLoading = false;
    });
    initCards(city);
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

  @override
  void initState() {
    super.initState();
    lg = LGConnection();
    _connectToLG();
    getCityData();
    _connectToAIServer();
  }

  clean() async {
    await lg.cleanBalloon();
    await lg.cleanVisualization();
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
    var size = MediaQuery.of(context).size;
    return Scaffold(
      key: _scaffoldKey,
      endDrawer: AppDrawer(size: size),
      backgroundColor: darkBackgroundColor,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(140.0),
        child: Container(
          child: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: darkSecondaryColor,
            toolbarHeight: 150,
            elevation: 0,
            title: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 60.h,
                    ),
                    Container(
                      padding: EdgeInsets.only(
                        left: 50.h,
                        bottom: 55.h,
                      ),
                      child: Image.asset(
                        "assets/images/rame_170.png",
                        scale: 3.5,
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: EdgeInsets.only(left: 5.w, top: 45.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        "AI Touristic Explorer",
                        style: googleTextStyle(35, FontWeight.w700, white),
                      ),
                      ConnectionFlag(
                        lgStatus: lgStatus,
                        aiStatus: aiStatus,
                      ),
                    ],
                  ),
                )
              ],
            ),
            actions: [
              IconButton(
                  onPressed: () {
                    _scaffoldKey.currentState!.openEndDrawer();
                  },
                  icon: Container(
                      padding: const EdgeInsets.fromLTRB(0, 0, 45, 0),
                      child: Image.asset(drawerLogo)))
            ],
          ),
        ),
      ),
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
                                            isGeography = false;
                                          });
                                        },
                                        child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              color: isHistory
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
                                            isGeography = true;
                                          });
                                        },
                                        child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              color: isGeography
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
                                          });
                                        },
                                        child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              color: isCulture
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
                                            isHistory
                                                ? AnimatedSwitcher(
                                                    duration:
                                                        Duration(seconds: 1),
                                                    child: Container(
                                                      height:
                                                          size.height * 0.45,
                                                      width: size.width * 0.38,
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
                                                    duration:
                                                        Duration(seconds: 1),
                                                    child: isCulture
                                                        ? Container(
                                                            height:
                                                                size.height *
                                                                    0.45,
                                                            width: size.width *
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
                                                                          const Duration(
                                                                              milliseconds: 5000),
                                                                      autoPlay:
                                                                          false,
                                                                    )),
                                                          )
                                                        : AnimatedSwitcher(
                                                            duration: Duration(
                                                                seconds: 1),
                                                            child: Container(
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
                                          GestureDetector(
                                            onTap: () {},
                                            child: Row(
                                              children: [
                                                Image.asset(downloadIcon),
                                                20.pw,
                                                Text(
                                                  "Historical Fact",
                                                  style: googleTextStyle(40.sp,
                                                      FontWeight.w600, white),
                                                ),
                                              ],
                                            ),
                                          ),
                                          20.ph,
                                          Container(
                                            height: 1,
                                            width: size.width * 0.33,
                                            color: white.withOpacity(0.4),
                                          ),
                                          20.ph,
                                          GestureDetector(
                                            onTap: () {},
                                            child: Row(
                                              children: [
                                                Image.asset(downloadIcon),
                                                20.pw,
                                                Text(
                                                  "3D Contour Terrain",
                                                  style: googleTextStyle(40.sp,
                                                      FontWeight.w600, white),
                                                ),
                                              ],
                                            ),
                                          ),
                                          20.ph,
                                          Container(
                                            height: 1,
                                            width: size.width * 0.33,
                                            color: white.withOpacity(0.4),
                                          ),
                                          20.ph,
                                          GestureDetector(
                                            onTap: () {},
                                            child: Row(
                                              children: [
                                                Image.asset(downloadIcon),
                                                20.pw,
                                                Text(
                                                  "Outline",
                                                  style: googleTextStyle(40.sp,
                                                      FontWeight.w600, white),
                                                ),
                                              ],
                                            ),
                                          ),
                                          20.ph,
                                          Container(
                                            height: 1,
                                            width: size.width * 0.33,
                                            color: white.withOpacity(0.4),
                                          ),
                                          20.ph,
                                          GestureDetector(
                                            onTap: () {},
                                            child: Row(
                                              children: [
                                                Image.asset(downloadIcon),
                                                20.pw,
                                                Text(
                                                  "Climate Heatmap",
                                                  style: googleTextStyle(40.sp,
                                                      FontWeight.w600, white),
                                                ),
                                              ],
                                            ),
                                          ),
                                          20.ph,
                                          Container(
                                            height: 1,
                                            width: size.width * 0.33,
                                            color: white.withOpacity(0.4),
                                          ),
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
                          Text(
                            "Some Commands:",
                            style:
                                googleTextStyle(40.sp, FontWeight.w600, white),
                          ),
                          220.pw,
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                isExtra = !isExtra;
                              });
                            },
                            child: Container(
                              alignment: Alignment.center,
                              height: size.height * .055,
                              width: size.width * 0.1,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: greenShade,
                              ),
                              child: Text(
                                "Extra",
                                style: googleTextStyle(
                                    33.sp, FontWeight.w500, Colors.black),
                              ),
                            ),
                          ),
                          30.pw
                        ],
                      ),
                      15.ph,
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () async {
                              if (!isPlaceGenerated) {
                                print("not generated");
                                places = await generatePOI(
                                    widget.cityName, widget.coordinates);
                                print(places.toString());
                                isPlaceGenerated = true;
                              } else {
                                print("generated");

                                for (var i = 0; i < 2; i++) {
                                  String placesdata =
                                      Orbit().generateOrbit(places);
                                  String content =
                                      Orbit().buildOrbit(placesdata);
                                  print(content);
                                  await lg.buildOrbit(content);
                                  await Future.delayed(Duration(seconds: 1));
                                }

                                for (int i = 0; i < places.length; i++) {
                                  await lg.openBalloon(
                                      "orbitballoon",
                                      places[i].name,
                                      widget.cityName,
                                      500,
                                      places[i].details,
                                      places[i].latitude,
                                      places[i].longitude);
                                  await Future.delayed(Duration(seconds: 20));
                                  //  Future.delayed(Duration(seconds: 4));
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
