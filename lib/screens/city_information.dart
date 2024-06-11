import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:lg_ai_touristic_explorer/components/carousel_card.dart';
import 'package:lg_ai_touristic_explorer/components/drawer.dart';
import 'package:lg_ai_touristic_explorer/connections/lg_connection.dart';
import 'package:lg_ai_touristic_explorer/utils/common.dart';
import '../components/connection_flag.dart';
import '../constants/constants.dart';
import '../constants/images.dart';
import '../constants/text_styles.dart';

class CityInformationScreen extends StatefulWidget {
  final String cityName;
  final String countryName;
  const CityInformationScreen(
      {super.key, required this.cityName, required this.countryName});

  @override
  State<CityInformationScreen> createState() => _CityInformationScreenState();
}

class _CityInformationScreenState extends State<CityInformationScreen> {
  bool connectionStatus = false;
  late LGConnection lg;
  List<Widget> carouselCards = [];
  CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(19, 72),
    zoom: 11,
  );

  Future<void> _connectToLG() async {
    bool? result = await lg.connectToLG();
    setState(() {
      connectionStatus = result!;
    });
  }

  void initCards() {
    for (int i = 0; i < 5; i++) {
      carouselCards.add(CarouselCard(
        factTitle: "Fact Title",
        factDesc:
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque tempor quam a justo elementum, eu luctus nunc accumsan. Aliquam commodo urna mauris. Praesent id fermentum eros, vitae egestas tortor. Vestibulum egestas vitae est at bibendum. ",
      ));
    }
  }

  @override
  void initState() {
    super.initState();
    lg = LGConnection();
    _connectToLG();
    initCards();
  }

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
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
                    child: Column(
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
                                onTap: () {},
                                child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      color: darkSecondaryColor,
                                    ),
                                    alignment: Alignment.center,
                                    width: size.width * 0.12,
                                    height: 55,
                                    child: Text(
                                      "History",
                                      style: googleTextStyle(
                                          33.sp, FontWeight.w500, white),
                                    ))),
                            30.pw,
                            GestureDetector(
                                onTap: () {},
                                child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      color: darkSecondaryColor,
                                    ),
                                    alignment: Alignment.center,
                                    width: size.width * 0.12,
                                    height: 55,
                                    child: Text(
                                      "Geography",
                                      style: googleTextStyle(
                                          33.sp, FontWeight.w500, white),
                                    ))),
                            30.pw,
                            GestureDetector(
                                onTap: () {},
                                child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      color: darkSecondaryColor,
                                    ),
                                    alignment: Alignment.center,
                                    width: size.width * 0.12,
                                    height: 55,
                                    child: Text(
                                      "Culture",
                                      style: googleTextStyle(
                                          33.sp, FontWeight.w500, white),
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
                              Container(
                                height: size.height * 0.45,
                                width: size.width * 0.38,
                                child: CarouselSlider(
                                    items: carouselCards,
                                    options: CarouselOptions(
                                      enlargeCenterPage: true,
                                      height: 700,
                                      initialPage: 0,
                                      scrollDirection: Axis.horizontal,
                                      autoPlayInterval:
                                          const Duration(milliseconds: 5000),
                                      autoPlay: false,
                                    )),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
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
                          Container(
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
