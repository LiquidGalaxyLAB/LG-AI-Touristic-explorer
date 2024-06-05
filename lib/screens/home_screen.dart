import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_places_flutter/google_places_flutter.dart';
import 'package:google_places_flutter/model/prediction.dart';
import 'package:lg_ai_touristic_explorer/components/connection_flag.dart';
import 'package:lg_ai_touristic_explorer/connections/lg_connection.dart';
import 'package:lg_ai_touristic_explorer/constants/constants.dart';
import 'package:lg_ai_touristic_explorer/constants/images.dart';
import 'package:lg_ai_touristic_explorer/constants/text_styles.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  bool connectionStatus = false;
  // late LGConnection lg;
  TextEditingController _textEditingController = TextEditingController();
  bool isCity = false;
  // Future<void> _connectToLG() async {
  //   bool? result = await lg.connectToLG();
  //   setState(() {
  //     connectionStatus = result!;
  //   });
  // }

  @override
  void initState() {
    super.initState();
    // lg = LGConnection();
    // _connectToLG();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
        key: _scaffoldKey,
        backgroundColor: darkBackgroundColor,
        endDrawer: Container(),
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
                          left: 30.h,
                          bottom: 45.h,
                        ),
                        child: Image.asset(
                          logo,
                          scale: 9,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 50.w, top: 45.h),
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
        body: SingleChildScrollView(
            child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              SizedBox(
                height: 70.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: size.width * .82,
                    height: 75,
                    padding: EdgeInsets.fromLTRB(0, 0, 125.w, 0),
                    decoration: BoxDecoration(
                      color: darkSecondaryColor,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: Colors.white,
                      ),
                      padding: const EdgeInsets.all(8.0),
                      child: GooglePlaceAutoCompleteTextField(
                        textEditingController: _textEditingController,
                        googleAPIKey: "AIzaSyBZbtg1kE7d_yKHoOPfDzWoaeY9gKymz3Y",
                        boxDecoration:
                            BoxDecoration(border: Border.all(width: 0)),
                        textStyle: GoogleFonts.raleway(
                          textStyle: TextStyle(
                              foreground: Paint()
                                ..shader = const LinearGradient(
                                  colors: <Color>[
                                    Color.fromARGB(255, 66, 160, 237),
                                    Color.fromARGB(255, 106, 225, 110)
                                  ],
                                ).createShader(
                                    const Rect.fromLTWH(0.0, 0.0, 400.0, 70.0)),
                              fontSize: 32.sp,
                              fontWeight: FontWeight.w600),
                        ),
                        inputDecoration: InputDecoration(
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          hintStyle: GoogleFonts.raleway(
                            textStyle: TextStyle(
                              foreground: Paint()
                                ..shader = const LinearGradient(
                                  colors: <Color>[
                                    Color.fromARGB(255, 66, 160, 237),
                                    Color.fromARGB(255, 106, 225, 110)
                                  ],
                                ).createShader(
                                    const Rect.fromLTWH(0.0, 0.0, 800.0, 70.0)),
                              fontSize: 32.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          hintText: "Search for a city",
                          prefixIcon: GestureDetector(
                            onTap: () {
                              print("Mic");
                            },
                            child: Container(
                                margin:
                                    EdgeInsets.fromLTRB(26.w, 12.h, 26.w, 12.h),
                                child: const Icon(
                                  Icons.mic_rounded,
                                  size: 30,
                                  color: darkBackgroundColor,
                                )),
                          ),
                          isDense: true,
                          contentPadding: EdgeInsets.only(
                              top: 15.h, right: 30.w, bottom: 15.h),
                        ),
                        debounceTime: 800,
                        isLatLngRequired: true,
                        seperatedBuilder: const Divider(),
                        isCrossBtnShown: true,
                        itemClick: (Prediction prediction) async {
                          print(prediction.types);
                          for (var type in prediction.types!) {
                            if (type == "locality" ||
                                type == "administrative_area_level_3") {
                              isCity = true;
                              break;
                            }
                          }
                          if (isCity) {
                            await Future.delayed(Duration(seconds: 1));
                            print("It is a city");
                            print("placeDetails 2nd ${prediction.description}");
                            List<String> components =
                                prediction.description!.split(',');
                            String cityName = components[0].trim();
                            String secondName = components.length > 1
                                ? components[1].trim()
                                : "";

                            print("City Name: $cityName");
                            print("Country Name: $secondName");
                            print("City Name: $cityName");
                            double cityLat = double.parse(prediction.lat!);
                            double cityLong = double.parse(prediction.lng!);
                          } else {
                            // ToastService.showErrorToast(
                            //   context,
                            //   length: ToastLength.medium,
                            //   expandedHeight: 100,
                            //   message: "It is not a city, try again!",
                            // );
                            print("It is not a city, try again later");
                          }
                          setState(() {
                            isCity = false;
                          });
                        },
                        itemBuilder: (context, index, Prediction prediction) {
                          return Container(
                            padding: const EdgeInsets.all(10),
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.location_on,
                                  color: darkBackgroundColor,
                                ),
                                const SizedBox(
                                  width: 15,
                                ),
                                Expanded(
                                    child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      prediction
                                              .structuredFormatting!.mainText ??
                                          "",
                                      style: googleTextStyle(25.sp,
                                          FontWeight.w600, darkSecondaryColor),
                                    ),
                                    SizedBox(height: 2.h),
                                    Text(
                                        prediction.structuredFormatting!
                                                .secondaryText ??
                                            "",
                                        style: googleTextStyle(20.sp,
                                            FontWeight.w500, Colors.black)),
                                  ],
                                ))
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 55.h,
              ),
              Container(
                alignment: Alignment.bottomLeft,
                width: size.width * .82,
                child: Text(
                  "Recommended Locations",
                  style: googleTextStyle(48.sp, FontWeight.w600, white),
                ),
              )
            ],
          ),
        )));
  }
}
