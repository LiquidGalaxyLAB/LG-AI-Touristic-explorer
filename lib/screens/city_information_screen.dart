import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:lg_ai_touristic_explorer/components/carousel_card.dart';
import 'package:lg_ai_touristic_explorer/components/drawer.dart';
import 'package:lg_ai_touristic_explorer/connections/ai_model.dart';
import 'package:lg_ai_touristic_explorer/connections/lg_connection.dart';
import 'package:lg_ai_touristic_explorer/models/city.dart';
import 'package:lg_ai_touristic_explorer/utils/common.dart';
import '../components/connection_flag.dart';
import '../constants/constants.dart';
import '../constants/images.dart';
import '../constants/text_styles.dart';

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
  bool connectionStatus = false;
  late LGConnection lg;
  List<Widget> historyCarouselCards = [];
  List<Widget> cultureCarouselCards = [];
  List<Widget> geographyCarouselCards = [];
  late City city;
  bool isLoading = true;
  Future<void> _connectToLG() async {
    bool? result = await lg.connectToLG();
    setState(() {
      connectionStatus = result!;
    });
  }

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

  @override
  void initState() {
    super.initState();
    lg = LGConnection();
    _connectToLG();
    getCityData();
  }

  final _scaffoldKey = GlobalKey<ScaffoldState>();

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
                        status: connectionStatus,
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
                                Container(
                                  width: size.width * .45,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      isHistory
                                          ? Container(
                                              height: size.height * 0.45,
                                              width: size.width * 0.38,
                                              child: CarouselSlider(
                                                  items: historyCarouselCards,
                                                  options: CarouselOptions(
                                                    enlargeCenterPage: true,
                                                    height: 700,
                                                    initialPage: 0,
                                                    scrollDirection:
                                                        Axis.horizontal,
                                                    autoPlayInterval:
                                                        const Duration(
                                                            milliseconds: 5000),
                                                    autoPlay: false,
                                                  )),
                                            )
                                          : isCulture
                                              ? Container(
                                                  height: size.height * 0.45,
                                                  width: size.width * 0.38,
                                                  child: CarouselSlider(
                                                      items:
                                                          cultureCarouselCards,
                                                      options: CarouselOptions(
                                                        enlargeCenterPage: true,
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
                                                )
                                              : Container(
                                                  height: size.height * 0.45,
                                                  width: size.width * 0.38,
                                                  child: CarouselSlider(
                                                      items:
                                                          geographyCarouselCards,
                                                      options: CarouselOptions(
                                                        enlargeCenterPage: true,
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
                                    ],
                                  ),
                                )
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
                          Container(
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
