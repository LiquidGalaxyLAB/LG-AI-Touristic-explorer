import 'dart:convert';
import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:lg_ai_touristic_explorer/components/carousel_card.dart';
import 'package:lg_ai_touristic_explorer/components/download_option.dart';
import 'package:lg_ai_touristic_explorer/components/drawer.dart';
import 'package:lg_ai_touristic_explorer/components/upper_bar.dart';

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
import 'package:toasty_box/toast_enums.dart';
import 'package:toasty_box/toast_service.dart';
import '../components/connection_flag.dart';
import '../constants/constants.dart';
import '../constants/images.dart';
import '../constants/text_styles.dart';
import 'package:http/http.dart' as http;
import 'package:lg_ai_touristic_explorer/connections/gemini_service.dart';

class CityInformationScreen extends StatefulWidget {
  final City? cityGiven;
  final List<Place>? cityPOI;
  final String cityName;
  final String countryName;
  final LatLng coordinates;
  const CityInformationScreen({
    required this.cityName,
    required this.countryName,
    required this.coordinates,
    this.cityGiven,
    this.cityPOI,
  });

  @override
  State<CityInformationScreen> createState() => _CityInformationScreenState();
}

class _CityInformationScreenState extends State<CityInformationScreen> {
  bool lgStatus = false;
  late LGConnection lg;

  List<Widget> historyCarouselCards = [
    const CarouselCard(
      isOrbitable: false,
      cityname: "city",
      factTitle: "Geographical Fact",
      factDesc:
          "factfactfactfactfactfactfactfactfactfactfactfactfactfactfactfactfactfactfactfactfactfactfactfactfactfactfactfactfactfactfactfactfactfactfactfactfactfactfactfactfactfactfactfactfactfactfactfactfactfactfactfactfactfactfactfactfactfactfactfact",
      coordinates: LatLng(1, 1),
      imageURL: "",
    )
  ];
  List<Widget> cultureCarouselCards = [
    const CarouselCard(
      isOrbitable: false,
      cityname: "city",
      factTitle: "Geographical Fact",
      factDesc:
          "factfactfactfactfactfactfactfactfactfactfactfactfactfactfactfactfactfactfactfactfactfactfactfactfactfactfactfactfactfactfactfactfactfactfactfactfactfactfactfactfactfactfactfactfactfactfactfactfactfactfactfactfactfactfactfactfactfactfactfact",
      coordinates: LatLng(1, 1),
      imageURL: "",
    )
  ];
  List<Widget> geographyCarouselCards = [
    const CarouselCard(
      isOrbitable: false,
      cityname: "city",
      factTitle: "Geographical Fact",
      factDesc:
          "factfactfactfactfactfactfactfactfactfactfactfactfactfactfactfactfactfactfactfactfactfactfactfactfactfactfactfactfactfactfactfactfactfactfactfactfactfactfactfactfactfactfactfactfactfactfactfactfactfactfactfactfactfactfactfactfactfactfactfact",
      coordinates: LatLng(1, 1),
      imageURL: "",
    ),
  ];
  List<Widget> poiCarouselCards = [
    const CarouselCard(
      isOrbitable: true,
      cityname: "city",
      factTitle: "cityName",
      factDesc:
          "factfactfactfactfactfactfactfactfactfactfactfactfactfactfactfactfactfactfactfactfactfactfactfactfactfactfactfactfactfactfactfactfactfactfactfactfactfactfactfactfactfactfactfactfactfactfactfactfactfactfactfactfactfactfactfactfactfactfactfact",
      coordinates: LatLng(1, 1),
      imageURL: "",
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
      cultureCarouselCards.add(
        CarouselCard(
          isOrbitable: !false,
          cityname: widget.cityName,
          factTitle: translate('city.factC'),
          factDesc: culturalFact.fact,
          coordinates: widget.coordinates,
          imageURL: "",
        ),
      );
    }

    for (var geographicalFact in city.geographicalFacts) {
      geographyCarouselCards.add(CarouselCard(
          isOrbitable: !false,
          cityname: widget.cityName,
          factTitle: translate('city.factG'),
          factDesc: geographicalFact.fact,
          coordinates: widget.coordinates,
          imageURL: ""));
    }

    for (var historicalFact in city.historicalFacts) {
      historyCarouselCards.add(CarouselCard(
          isOrbitable: !false,
          cityname: widget.cityName,
          factTitle: translate('city.factH'),
          factDesc: historicalFact.fact,
          coordinates: widget.coordinates,
          imageURL: ""));
    }
    for (Place places in pois) {
      poiCarouselCards.add(CarouselCard(
          isOrbitable: !true,
          cityname: widget.cityName,
          factTitle: places.name,
          factDesc: places.details,
          coordinates: LatLng(places.latitude, places.longitude),
          imageURL: places.imageUrl));
    }
  }

  bool isURL = false;
  String img = "";
  bool retry = false;

  retryCityData() async {
    try {
      print("retryCityData");
      String cityName = widget.cityName;
      LatLng coordinates = widget.coordinates;
      String locale = LocalizedApp.of(context)
          .delegate
          .currentLocale
          .toString()
          .toLowerCase();
      city = await getCityInformation(
          "${cityName}, ${widget.countryName}", coordinates, locale);

      print("retryCityData");
      initCityCards(city);
      setState(() {
        isLoading = false;
      });
      ToastService.showSuccessToast(
        context,
        length: ToastLength.medium,
        expandedHeight: 100,
        child: Text(
          translate('city.citySuccess'),
          style: googleTextStyle(32.sp, FontWeight.w500, white),
        ),
      );
    } catch (e) {
      setState(() {
        isLoading = true;
        retry = true;
      });
      ToastService.showErrorToast(
        context,
        length: ToastLength.medium,
        expandedHeight: 100,
        child: Text(
          translate('city.factError'),
          style: googleTextStyle(32.sp, FontWeight.w500, white),
        ),
      );
    }
  }

  retryPlacesData() async {
    try {
      List<Place> data = await generatePlaces();
      setState(() {
        isPlaceGenerated = true;
      });
      initPlaceCards(data);
      ToastService.showSuccessToast(
        context,
        length: ToastLength.medium,
        expandedHeight: 100,
        child: Text(
          translate('city.poiSuccess'),
          style: googleTextStyle(32.sp, FontWeight.w500, white),
        ),
      );
    } catch (e) {
      setState(() {
        isPlaceGenerated = false;
        retry = true;
      });
      ToastService.showErrorToast(
        context,
        length: ToastLength.medium,
        expandedHeight: 100,
        child: Text(
          translate('city.poiError'),
          style: googleTextStyle(32.sp, FontWeight.w500, white),
        ),
      );
    }
  }

  void initCityCards(City city) {
    print("GOT IT CITY CARDS");
    historyCarouselCards.clear();
    cultureCarouselCards.clear();
    geographyCarouselCards.clear();

    for (var culturalFact in city.culturalFacts) {
      cultureCarouselCards.add(
        CarouselCard(
          isOrbitable: !false,
          cityname: widget.cityName,
          factTitle: translate('city.factC'),
          factDesc: culturalFact.fact,
          coordinates: widget.coordinates,
          imageURL: "",
        ),
      );
    }

    for (var geographicalFact in city.geographicalFacts) {
      geographyCarouselCards.add(CarouselCard(
          isOrbitable: !false,
          cityname: widget.cityName,
          factTitle: translate('city.factG'),
          factDesc: geographicalFact.fact,
          coordinates: widget.coordinates,
          imageURL: ""));
    }

    for (var historicalFact in city.historicalFacts) {
      historyCarouselCards.add(CarouselCard(
          isOrbitable: !false,
          cityname: widget.cityName,
          factTitle: translate('city.factH'),
          factDesc: historicalFact.fact,
          coordinates: widget.coordinates,
          imageURL: ""));
    }
    if (isPlaceGenerated == true) {
      setState(() {
        retry = false;
      });
    }
  }

  void initPlaceCards(List<Place> pois) async {
    print("THIS IS PLACES DATA");
    poiCarouselCards.clear();
    for (Place places in pois) {
      poiCarouselCards.add(CarouselCard(
          isOrbitable: !true,
          cityname: widget.cityName,
          factTitle: places.name,
          factDesc: places.details,
          coordinates: LatLng(places.latitude, places.longitude),
          imageURL: places.imageUrl));
    }
    if (isLoading == false) {
      setState(() {
        retry = false;
      });
    }
    try {
      await lg.buildKML(Orbit().buildPlacemarks(places));
    } catch (e) {
      print("Not connected to the LG Rig");
    }
  }

  Future<void> narrateStoryFunc() async {
    try {
      setState(() {
        isStoryButtonTapped = true;
      });
      String locale = LocalizedApp.of(context)
          .delegate
          .currentLocale
          .toString()
          .toLowerCase();
      String content = await generateStory(widget.cityName, locale);
      print(content);
      await textToVoice(content);
      setState(() {
        isStoryGenerated = true;
        isPlaying = true;
      });
    } catch (e) {
      print(e);
      setState(() {
        isStoryButtonTapped = false;
      });
      ToastService.showErrorToast(
        context,
        length: ToastLength.medium,
        expandedHeight: 100,
        child: Text(
          translate('city.storyError'),
          style: googleTextStyle(32.sp, FontWeight.w500, white),
        ),
      );
    }
  }

  bool isStoryButtonTapped = false;
  bool isStoryGenerated = false;
  bool isPlaying = false;
  final player = AudioPlayer();
  late final dir;
  late final file;
  met() async {
    dir = await getApplicationDocumentsDirectory();
    file = File('${dir.path}/textToSpeech.wav');
  }

  _stop() {
    player.stop();
  }

  _start() {
    player.play(DeviceFileSource(file.path));
  }

  textToVoice(String content) async {
    await met();
    final url =
        Uri.parse("https://api.deepgram.com/v1/speak?model=aura-zeus-en");
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final apiKey = prefs.getString('deepgramAPI') ?? "";
    String voiceApiKey = apiKey;
    final response = await http.post(url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Token $voiceApiKey"
        },
        body: jsonEncode({"text": content}));
    if (response.statusCode == 200) {
      final bytes = response.bodyBytes;
      print(bytes);
      await file.writeAsBytes(bytes);

      await player.play(DeviceFileSource(file.path));
    }
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

  bool isStatic = false;

  sendCityBalloon() async {
    try {
      bool present = checkIsExtra(widget.cityName);
      if (present) {
        var cityname = widget.cityName.replaceAll(" ", "").toLowerCase();
        var description = data[cityname]?[0]['description'] ?? "";
        print(description);
        var imageUrl = mainLogoAWS;
        if (placeImage.containsKey(cityname)) {
          imageUrl = placeImage[cityname] ?? mainLogoAWS;
        }
        print(imageUrl);
        await lg.sendStaticBalloon(
            "orbitballoon", "", widget.cityName, 500, description, imageUrl);
      } else {
        // var imageUrl = mainLogoAWS;
        var imageUrl = await getPlaceIdFromName(widget.cityName);
        String locale = LocalizedApp.of(context)
            .delegate
            .currentLocale
            .toString()
            .toLowerCase();
        String description =
            await generateCityDescription(widget.cityName, locale);
        print(description);
        print(imageUrl);
        await lg.sendStaticBalloon(
            "orbitballoon", "", widget.cityName, 500, description, imageUrl);
      }
    } catch (e) {
      print("An error occurred: $e");
    }
  }

  _checkGiven() async {
    await sendCityBalloon();
    if (widget.cityGiven != null && widget.cityPOI != null) {
      setState(() {
        isStatic = true;
      });
      city = widget.cityGiven!;
      await changeImageURL(widget.cityPOI!);
      places = widget.cityPOI!;
      checkForExtra();
      initCards(city, places);
      setState(() {
        isLoading = false;
        isPlaceGenerated = true;
      });
    } else {
      checkForExtra();
      // getCityData();
      await retryCityData();
      await retryPlacesData();
    }
  }

  Future<List<Place>> generatePlaces() async {
    String locale = LocalizedApp.of(context)
        .delegate
        .currentLocale
        .toString()
        .toLowerCase();
    places = await generatePOI(widget.cityName, widget.coordinates, locale);
    print(places.toString());
    return places;
  }

  @override
  void initState() {
    super.initState();
    lg = LGConnection();
    _connectToLG();
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

  changeImageURL(List<Place> places) async {
    for (var place in places) {
      var imageUrl = await getPlaceIdFromName(place.name);
      place.imageUrl = imageUrl;
      print(' Name: ${place.name}' ' Image URL: ${place.imageUrl}');
    }
  }

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
          child: UpperBar(lgStatus: lgStatus, scaffoldKey: _scaffoldKey)),
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
                                      width: size.width * 0.285,
                                      child: Text(
                                        "${widget.cityName}, ${widget.countryName}",
                                        style: googleTextStyle(
                                            45.sp, FontWeight.w700, white),
                                        overflow: TextOverflow.clip,
                                      ),
                                    ),
                                    retry
                                        ? IconButton(
                                            onPressed: () async {
                                              bool isCityNull = false;
                                              bool isPlacesNull = false;
                                              try {
                                                if (city == null) ;
                                              } catch (e) {
                                                isCityNull = true;
                                              }
                                              try {
                                                if (places == null) ;
                                              } catch (e) {
                                                isPlacesNull = true;
                                              }
                                              if (isCityNull && isPlacesNull) {
                                                await retryCityData();
                                                await retryPlacesData();
                                                print(
                                                    "Both city and places are null");
                                              } else if (isCityNull) {
                                                await retryCityData();
                                                print("City is null");
                                              } else if (isPlacesNull) {
                                                await retryPlacesData();
                                                print("Places is null");
                                              } else {
                                                setState(() {
                                                  retry = false;
                                                  isLoading = false;
                                                  isPlaceGenerated = true;
                                                });
                                                print(
                                                    "Both city and places are initialized");
                                              }
                                            },
                                            icon: Container(
                                                decoration: BoxDecoration(
                                                  color: greenShade,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          100),
                                                ),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.fromLTRB(
                                                          8, 8, 12, 8),
                                                  child: Row(
                                                    children: [
                                                      Icon(
                                                        Icons.restart_alt,
                                                        size: 40,
                                                      ),
                                                      4.pw,
                                                      Text(
                                                        'Retry',
                                                        style: googleTextStyle(
                                                            35.sp,
                                                            FontWeight.w600,
                                                            darkBackgroundColor),
                                                      ),
                                                    ],
                                                  ),
                                                )))
                                        : Container()
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
                                              translate('city.history'),
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
                                              translate('city.geography'),
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
                                              translate('city.culture'),
                                              style: googleTextStyle(33.sp,
                                                  FontWeight.w500, white),
                                            ))),
                                  ],
                                ),
                                55.ph,
                                // Carousel
                                isPOI
                                    ? Padding(
                                        padding: EdgeInsets.only(
                                            left: size.width * 0.036),
                                        child: AnimatedSwitcher(
                                          duration: Duration(seconds: 2),
                                          child: Skeletonizer(
                                            enabled: !isPlaceGenerated,
                                            child: Container(
                                              height: size.height * 0.45,
                                              width: size.width * 0.38,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Container(
                                                    height: size.height * 0.45,
                                                    width: size.width * 0.38,
                                                    child: CarouselSlider(
                                                        carouselController:
                                                            carouselController,
                                                        items: poiCarouselCards,
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
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      )
                                    : AnimatedSwitcher(
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
                                                          duration: Duration(
                                                              seconds: 1),
                                                          child: Container(
                                                            height:
                                                                size.height *
                                                                    0.45,
                                                            width: size.width *
                                                                0.38,
                                                            child:
                                                                CarouselSlider(
                                                                    items:
                                                                        historyCarouselCards,
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
                                                                    height: size
                                                                            .height *
                                                                        0.45,
                                                                    width: size
                                                                            .width *
                                                                        0.38,
                                                                    child: CarouselSlider(
                                                                        items: geographyCarouselCards,
                                                                        options: CarouselOptions(
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
                                            translate('city.extraVisual'),
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
                                translate('city.poi'),
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
                                      translate('city.extra'),
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
                                    if (lgStatus) {
                                      if (!isPlaceGenerated) {
                                        ToastService.showErrorToast(
                                          context,
                                          length: ToastLength.medium,
                                          expandedHeight: 100,
                                          child: Text(
                                            translate('city.poiNotGen'),
                                            style: googleTextStyle(
                                                32.sp, FontWeight.w500, white),
                                          ),
                                        );
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
                                        for (int i = 0;
                                            i < places.length;
                                            i++) {
                                          print(i);
                                          carouselController.nextPage();
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
                                    } else {
                                      ToastService.showErrorToast(
                                        context,
                                        length: ToastLength.medium,
                                        expandedHeight: 100,
                                        child: Text(
                                          translate('city.errorNotLG'),
                                          style: googleTextStyle(
                                              32.sp, FontWeight.w500, white),
                                        ),
                                      );
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
                                      translate('city.startOrbit'),
                                      style: googleTextStyle(
                                          37.sp, FontWeight.w500, white),
                                    ),
                                  ),
                                )
                              : GestureDetector(
                                  onTap: () async {
                                    if (lgStatus) {
                                      await lg.stopOrbit();
                                      setState(() {
                                        isRunning = false;
                                      });
                                      await lg.cleanRightBalloon();
                                      double longitude =
                                          widget.coordinates.longitude;
                                      double latitude =
                                          widget.coordinates.latitude;
                                      double range = 5000;
                                      double tilt = 0;
                                      double heading = 0;
                                      FlyToView city = FlyToView(
                                          longitude: longitude,
                                          latitude: latitude,
                                          range: range,
                                          tilt: tilt,
                                          heading: heading);
                                      await lg.cleanVisualization();
                                      await lg.flyTo(city.getCommand());
                                    }
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
                                      translate('city.stopOrbit'),
                                      style: googleTextStyle(
                                          37.sp, FontWeight.w600, Colors.black),
                                    ),
                                  ),
                                ),
                          20.pw,
                          !isStoryGenerated
                              ? GestureDetector(
                                  onTap: () async {
                                    await narrateStoryFunc();
                                  },
                                  child: Container(
                                    alignment: Alignment.center,
                                    height: size.height * .15,
                                    width: size.width * 0.24,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: darkSecondaryColor,
                                    ),
                                    child: isStoryButtonTapped
                                        ? Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                translate(
                                                    'city.storyGenerating'),
                                                style: googleTextStyle(37.sp,
                                                    FontWeight.w500, white),
                                                textAlign: TextAlign.center,
                                                overflow: TextOverflow.clip,
                                              ),
                                              10.pw,
                                              CircularProgressIndicator(
                                                color: Colors.white,
                                              )
                                            ],
                                          )
                                        : Text(
                                            translate('city.narrate'),
                                            style: googleTextStyle(
                                                37.sp, FontWeight.w500, white),
                                            textAlign: TextAlign.center,
                                          ),
                                  ),
                                )
                              : GestureDetector(
                                  onTap: () async {
                                    if (isPlaying) {
                                      _stop();
                                      setState(() {
                                        isPlaying = false;
                                      });
                                    } else {
                                      _start();
                                      setState(() {
                                        isPlaying = true;
                                      });
                                    }
                                  },
                                  child: Container(
                                    alignment: Alignment.center,
                                    height: size.height * .15,
                                    width: size.width * 0.24,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color:
                                          isPlaying ? Colors.red : Colors.green,
                                    ),
                                    child: Text(
                                      isPlaying
                                          ? translate('city.stopNarration')
                                          : translate('city.startNarration'),
                                      style: googleTextStyle(
                                          37.sp, FontWeight.w500, white),
                                    ),
                                  ),
                                )
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
