import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_places_flutter/google_places_flutter.dart';
import 'package:google_places_flutter/model/prediction.dart';
import 'package:lg_ai_touristic_explorer/components/connection_flag.dart';
import 'package:lg_ai_touristic_explorer/components/drawer.dart';
import 'package:lg_ai_touristic_explorer/components/recommended_cities.dart';
import 'package:lg_ai_touristic_explorer/components/upper_bar.dart';
import 'package:lg_ai_touristic_explorer/connections/lg_connection.dart';
import 'package:lg_ai_touristic_explorer/constants/constants.dart';
import 'package:lg_ai_touristic_explorer/constants/images.dart';
import 'package:lg_ai_touristic_explorer/constants/text_styles.dart';
import 'package:lg_ai_touristic_explorer/screens/about_screen.dart';
import 'package:lg_ai_touristic_explorer/screens/city_information_screen.dart';
import 'package:lg_ai_touristic_explorer/screens/connection_manager.dart';
import 'package:lg_ai_touristic_explorer/screens/lg_tasks_screen.dart';
import 'package:lg_ai_touristic_explorer/utils/common.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  bool lgStatus = false;
  bool aiStatus = false;
  late LGConnection lg;
  TextEditingController _textEditingController = TextEditingController();
  bool isCity = false;
  Future<void> _connectToLG() async {
    bool? result = await lg.connectToLG();
    setState(() {
      lgStatus = result!;
    });
    await lg.logosLG(logosLG, factorLogo);
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

  late TutorialCoachMark tutorialCoachMark;

  void showTutorial() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isFirstLoaded = prefs.getBool("keyIsFirstLoaded") ?? false;
    if (isFirstLoaded) {
      tutorialCoachMark.show(context: context);
    }
  }

  void createTutorial() {
    tutorialCoachMark = TutorialCoachMark(
      targets: _createTargets(),
      colorShadow: Colors.black,
      textSkip: "SKIP",
      // paddingFocus: 10,
      opacityShadow: 0.7,
      // imageFilter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
      onFinish: () {
        print("finish");
      },
      onClickTarget: (target) {
        print('onClickTarget: ${target.identify}');
      },
      onClickTargetWithTapPosition: (target, tapDetails) {
        print("target: ${target.identify}");
        // print(
        //     "clicked at position local: ${tapDetails.localPosition} - global: ${tapDetails.globalPosition}");
      },
      onClickOverlay: (target) {
        print('onClickOverlay: ${target.identify}');
        if (target.identify == "connectionAIStatusKey") {
          _scaffoldKey.currentState!.openEndDrawer();
        }
        if (target.identify == "aboutKey") {
          // pop
          Navigator.of(context).pop();
        }
      },
      onSkip: () {
        print("skip");
        return true;
      },
    );
  }

  GlobalKey searchBarKey = GlobalKey();
  GlobalKey micKey = GlobalKey();
  GlobalKey cityCardKey = GlobalKey();
  GlobalKey drawerIconKey = GlobalKey();
  GlobalKey connectionLGStatusKey = GlobalKey();
  GlobalKey connectionAIStatusKey = GlobalKey();
  GlobalKey tasksKey = GlobalKey();
  GlobalKey connectionManagerKey = GlobalKey();
  // GlobalKey apiKeysKey = GlobalKey();
  GlobalKey languageKey = GlobalKey();
  GlobalKey aboutKey = GlobalKey();
  GlobalKey helpKey = GlobalKey();

  List<TargetFocus> _createTargets() {
    List<TargetFocus> targets = [];

    targets.add(
      TargetFocus(
        shape: ShapeLightFocus.RRect,
        identify: "searchBarKey",
        keyTarget: searchBarKey,
        alignSkip: Alignment.topRight,
        color: Colors.black,
        enableOverlayTab: true,
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            builder: (context, controller) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.all(18.0),
                    width: 400.w,
                    decoration: BoxDecoration(
                      color: darkBackgroundColor.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(25.0),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 10.0,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Text(
                      "Search for cities using this search bar",
                      textAlign: TextAlign.center,
                      style:
                          googleTextStyle(40.sp, FontWeight.w600, Colors.white),
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );

    targets.add(
      TargetFocus(
        identify: "micKey",
        keyTarget: micKey,
        alignSkip: Alignment.bottomRight,
        color: Colors.black,
        enableOverlayTab: true,
        contents: [
          TargetContent(
            align: ContentAlign.right,
            builder: (context, controller) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.all(18.0),
                    width: 400.w,
                    decoration: BoxDecoration(
                      color: darkBackgroundColor.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(25.0),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 10.0,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Text(
                      "Use this button to use voice for search.",
                      textAlign: TextAlign.center,
                      style:
                          googleTextStyle(40.sp, FontWeight.w600, Colors.white),
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );

    targets.add(
      TargetFocus(
        shape: ShapeLightFocus.RRect,
        identify: "cityCardKey",
        keyTarget: cityCardKey,
        alignSkip: Alignment.topRight,
        color: Colors.black,
        enableOverlayTab: true,
        contents: [
          TargetContent(
            align: ContentAlign.top,
            builder: (context, controller) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.all(18.0),
                    width: 400.w,
                    decoration: BoxDecoration(
                      color: darkBackgroundColor.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(25.0),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 10.0,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Text(
                      "Here you can see the details of the selected city.",
                      textAlign: TextAlign.center,
                      style:
                          googleTextStyle(40.sp, FontWeight.w600, Colors.white),
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );

    targets.add(
      TargetFocus(
        shape: ShapeLightFocus.Circle,
        identify: "drawerIconKey",
        keyTarget: drawerIconKey,
        alignSkip: Alignment.topLeft,
        color: Colors.black,
        enableOverlayTab: true,
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            builder: (context, controller) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.all(18.0),
                    width: 400.w,
                    decoration: BoxDecoration(
                      color: darkBackgroundColor.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(25.0),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 10.0,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Text(
                      "Open the app drawer from here.",
                      textAlign: TextAlign.center,
                      style:
                          googleTextStyle(40.sp, FontWeight.w600, Colors.white),
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );

    targets.add(
      TargetFocus(
        shape: ShapeLightFocus.RRect,
        identify: "connectionLGStatusKey",
        keyTarget: connectionLGStatusKey,
        alignSkip: Alignment.bottomRight,
        color: Colors.black,
        enableOverlayTab: true,
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            builder: (context, controller) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.all(18.0),
                    width: 400.w,
                    decoration: BoxDecoration(
                      color: darkBackgroundColor.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(25.0),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 10.0,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Text(
                      "This shows the connection status with the Liquid Galaxy Rig.",
                      textAlign: TextAlign.center,
                      style:
                          googleTextStyle(40.sp, FontWeight.w600, Colors.white),
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );

    targets.add(
      TargetFocus(
        shape: ShapeLightFocus.RRect,
        identify: "connectionAIStatusKey",
        keyTarget: connectionAIStatusKey,
        alignSkip: Alignment.bottomRight,
        color: Colors.black,
        enableOverlayTab: true,
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            builder: (context, controller) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.all(18.0),
                    width: 400.w,
                    decoration: BoxDecoration(
                      color: darkBackgroundColor.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(25.0),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 10.0,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Text(
                      "This shows the connection status with the AI server.",
                      textAlign: TextAlign.center,
                      style:
                          googleTextStyle(40.sp, FontWeight.w600, Colors.white),
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );

    targets.add(
      TargetFocus(
        shape: ShapeLightFocus.RRect,
        identify: "tasksKey",
        keyTarget: tasksKey,
        alignSkip: Alignment.bottomRight,
        color: Colors.black,
        enableOverlayTab: true,
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            builder: (context, controller) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.all(18.0),
                    width: 400.w,
                    decoration: BoxDecoration(
                      color: darkBackgroundColor.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(25.0),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 10.0,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Text(
                      "This contains different function to control the Liquid Galaxy Rig.",
                      textAlign: TextAlign.center,
                      style:
                          googleTextStyle(40.sp, FontWeight.w600, Colors.white),
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );

    targets.add(
      TargetFocus(
        shape: ShapeLightFocus.RRect,
        identify: "connectionManagerKey",
        keyTarget: connectionManagerKey,
        alignSkip: Alignment.bottomRight,
        color: Colors.black,
        enableOverlayTab: true,
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            builder: (context, controller) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.all(18.0),
                    width: 400.w,
                    decoration: BoxDecoration(
                      color: darkBackgroundColor.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(25.0),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 10.0,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Text(
                      "Enter the details to connect to the Liquid Galxy Rig and AI Server here.",
                      textAlign: TextAlign.center,
                      style:
                          googleTextStyle(40.sp, FontWeight.w600, Colors.white),
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );

    // targets.add(
    //   TargetFocus(
    //     shape: ShapeLightFocus.RRect,
    //     identify: "apiKeysKey",
    //     keyTarget: apiKeysKey,
    //     alignSkip: Alignment.bottomRight,
    //     color: Colors.black,
    //     enableOverlayTab: true,
    //     contents: [
    //       TargetContent(
    //         align: ContentAlign.bottom,
    //         builder: (context, controller) {
    //           return Column(
    //             crossAxisAlignment: CrossAxisAlignment.center,
    //             children: <Widget>[
    //               Container(
    //                 padding: const EdgeInsets.all(18.0),
    //                 width: 400.w,
    //                 decoration: BoxDecoration(
    //                   color: darkBackgroundColor.withOpacity(0.5),
    //                   borderRadius: BorderRadius.circular(25.0),
    //                   boxShadow: const [
    //                     BoxShadow(
    //                       color: Colors.black26,
    //                       blurRadius: 10.0,
    //                       offset: Offset(0, 4),
    //                     ),
    //                   ],
    //                 ),
    //                 child: Text(
    //                   "Enter the API key of Deepgram.",
    //                   textAlign: TextAlign.center,
    //                   style:
    //                       googleTextStyle(40.sp, FontWeight.w600, Colors.white),
    //                 ),
    //               ),
    //             ],
    //           );
    //         },
    //       ),
    //     ],
    //   ),
    // );

    targets.add(
      TargetFocus(
        shape: ShapeLightFocus.RRect,
        identify: "languageKey",
        keyTarget: languageKey,
        alignSkip: Alignment.bottomRight,
        color: Colors.black,
        enableOverlayTab: true,
        contents: [
          TargetContent(
            align: ContentAlign.top,
            builder: (context, controller) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.all(18.0),
                    width: 400.w,
                    decoration: BoxDecoration(
                      color: darkBackgroundColor.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(25.0),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 10.0,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Text(
                      "You can change the language of the app using this dropdown.",
                      textAlign: TextAlign.center,
                      style:
                          googleTextStyle(40.sp, FontWeight.w600, Colors.white),
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );

    targets.add(
      TargetFocus(
        shape: ShapeLightFocus.RRect,
        identify: "aboutKey",
        keyTarget: aboutKey,
        alignSkip: Alignment.bottomRight,
        color: Colors.black,
        enableOverlayTab: true,
        contents: [
          TargetContent(
            align: ContentAlign.top,
            builder: (context, controller) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.all(18.0),
                    width: 400.w,
                    decoration: BoxDecoration(
                      color: darkBackgroundColor.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(25.0),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 10.0,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Text(
                      "Get to know more about the Application.",
                      textAlign: TextAlign.center,
                      style:
                          googleTextStyle(40.sp, FontWeight.w600, Colors.white),
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );

    targets.add(
      TargetFocus(
        shape: ShapeLightFocus.RRect,
        identify: "helpKey",
        keyTarget: helpKey,
        alignSkip: Alignment.bottomRight,
        color: Colors.black,
        enableOverlayTab: true,
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            builder: (context, controller) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.all(18.0),
                    width: 400.w,
                    decoration: BoxDecoration(
                      color: darkBackgroundColor.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(25.0),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 10.0,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Text(
                      "Get Help regarding running the application.",
                      textAlign: TextAlign.center,
                      style:
                          googleTextStyle(40.sp, FontWeight.w600, Colors.white),
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );

    return targets;
  }

  _showTour() {
    createTutorial();
    Future.delayed(Duration.zero, showTutorial);
  }

  @override
  void initState() {
    super.initState();
    lg = LGConnection();
    _connectToLG();
    _connectToAIServer();
    _showTour();
  }

  showDialogIfFirstLoaded(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? isFirstLoaded = prefs.getBool("keyIsFirstLoaded");
    if (isFirstLoaded == null) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Important Notice",
                style:
                    googleTextStyle(50.sp, FontWeight.w700, Colors.blueAccent)),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text("Be aware of AI hallucinations.",
                      style: googleTextStyle(
                          35.sp, FontWeight.w500, Colors.black)),
                  const SizedBox(height: 10),
                  Text(
                      "The state of the art of most AI tools as of 2024 can sometimes give you incorrect answers, or even the so-called Hallucinations. AI hallucinations are incorrect or misleading results that AI models generate. These errors can be caused by a variety of factors, including insufficient training data, incorrect assumptions made by the model, or biases in the data used to train the model.",
                      style: googleTextStyle(
                          28.sp, FontWeight.w400, Colors.black)),
                  const SizedBox(height: 15),
                  Text(
                      "The Liquid Galaxy project has no control over this, and the contents responsibility is of the owners of the respective Large Language models used.",
                      style: GoogleFonts.raleway(
                        textStyle: TextStyle(
                            color: Colors.black,
                            fontSize: 25.sp,
                            fontWeight: FontWeight.w400,
                            fontStyle: FontStyle.italic),
                      )),
                ],
              ),
            ),
            backgroundColor: Colors.white,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(15.0)),
            ),
            actions: <Widget>[
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                child: Text("Agree",
                    style:
                        googleTextStyle(30.sp, FontWeight.w500, Colors.white)),
                onPressed: () {
                  Navigator.of(context).pop();
                  prefs.setBool("keyIsFirstLoaded", false);
                },
              ),
            ],
          );
        },
      );
    }
  }

  FocusNode textFocus = FocusNode();
  String? dropDownValue = '';
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    Future.delayed(Duration.zero, () => showDialogIfFirstLoaded(context));
    return Scaffold(
        key: _scaffoldKey,
        backgroundColor: darkBackgroundColor,
        endDrawer: Drawer(
          width: size.width * .35,
          backgroundColor: darkSecondaryColor,
          child: ListView(
            children: [
              SizedBox(
                height: 60.h,
              ),
              Column(
                children: [
                  Image.asset(
                    'assets/images/rame_173.png',
                    scale: 2,
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Text(
                    "AI Touristic Explorer",
                    style: googleTextStyle(40.sp, FontWeight.w600, white),
                  )
                ],
              ),
              SizedBox(
                height: 70.h,
              ),
              ListTile(
                title: Container(
                  padding: const EdgeInsets.only(left: 80),
                  child: Row(
                    children: [
                      Image.asset(homeIcon),
                      SizedBox(
                        width: 20.w,
                      ),
                      Text(
                        'Home',
                        style: googleTextStyle(
                            30.sp, FontWeight.w500, Colors.white),
                      ),
                    ],
                  ),
                ),
                onTap: () {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => HomePage(),
                  ));
                },
              ),
              Divider(
                color: Colors.white.withOpacity(0.5),
                indent: 50,
                thickness: 0.5,
                endIndent: 50,
              ),
              ListTile(
                key: tasksKey,
                title: Container(
                  padding: const EdgeInsets.only(left: 80),
                  child: Row(
                    children: [
                      Image.asset(tasksIcon),
                      SizedBox(
                        width: 20.w,
                      ),
                      Text(
                        'Liquid Galaxy Tasks',
                        style: googleTextStyle(
                            30.sp, FontWeight.w500, Colors.white),
                      ),
                    ],
                  ),
                ),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => LGTasks(),
                  ));
                },
              ),
              Divider(
                color: Colors.white.withOpacity(0.5),
                indent: 50,
                thickness: 0.5,
                endIndent: 50,
              ),
              ListTile(
                key: connectionManagerKey,
                title: Container(
                  padding: const EdgeInsets.only(left: 80),
                  child: Row(
                    children: [
                      Image.asset(connectionIcon),
                      SizedBox(
                        width: 20.w,
                      ),
                      Text(
                        'Connection Manager',
                        style: googleTextStyle(
                            30.sp, FontWeight.w500, Colors.white),
                      ),
                    ],
                  ),
                ),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => ConnectionManager(),
                  ));
                },
              ),
              Divider(
                color: Colors.white.withOpacity(0.5),
                indent: 50,
                thickness: 0.5,
                endIndent: 50,
              ),
              ListTile(
                title: Container(
                  padding: const EdgeInsets.only(left: 80),
                  child: Row(
                    children: [
                      Text(
                        'Language Selected :',
                        style: googleTextStyle(
                            30.sp, FontWeight.w500, Colors.white),
                      ),
                      15.pw,
                      Container(
                          width: 120.w,
                          child: DropdownButtonFormField(
                            key: languageKey,
                            items: [
                              DropdownMenuItem(
                                value: "EN",
                                child: Text(
                                  "🇬🇧 EN",
                                  style: googleTextStyle(
                                      25.sp, FontWeight.w500, white),
                                ),
                              ),
                              DropdownMenuItem(
                                value: "FR",
                                child: Text(
                                  "🇫🇷 FR",
                                  style: googleTextStyle(
                                      25.sp, FontWeight.w500, white),
                                ),
                              ),
                              DropdownMenuItem(
                                value: "ES",
                                child: Text(
                                  "🇪🇸 ES",
                                  style: googleTextStyle(
                                      25.sp, FontWeight.w500, white),
                                ),
                              ),
                              DropdownMenuItem(
                                value: "DE",
                                child: Text(
                                  "🇩🇪 DE",
                                  style: googleTextStyle(
                                      25.sp, FontWeight.w500, white),
                                ),
                              ),
                              DropdownMenuItem(
                                value: "IT",
                                child: Text(
                                  "🇮🇹 IT",
                                  style: googleTextStyle(
                                      25.sp, FontWeight.w500, white),
                                ),
                              ),
                              DropdownMenuItem(
                                value: "JP",
                                child: Text(
                                  "🇯🇵 JP",
                                  style: googleTextStyle(
                                      25.sp, FontWeight.w500, white),
                                ),
                              ),
                              DropdownMenuItem(
                                value: "CN",
                                child: Text(
                                  "🇨🇳 CN",
                                  style: googleTextStyle(
                                      25.sp, FontWeight.w500, white),
                                ),
                              ),
                              DropdownMenuItem(
                                value: "RU",
                                child: Text(
                                  "🇷🇺 RU",
                                  style: googleTextStyle(
                                      25.sp, FontWeight.w500, white),
                                ),
                              ),
                              DropdownMenuItem(
                                value: "IN",
                                child: Text(
                                  "🇮🇳 IN",
                                  style: googleTextStyle(
                                      25.sp, FontWeight.w500, white),
                                ),
                              ),
                            ],
                            onChanged: (String) {},
                            dropdownColor: darkBackgroundColor,
                          ))
                    ],
                  ),
                ),
                onTap: () {},
              ),
              Divider(
                color: Colors.white.withOpacity(0.5),
                indent: 50,
                thickness: 0.5,
                endIndent: 50,
              ),
              ListTile(
                key: aboutKey,
                title: Container(
                  padding: const EdgeInsets.only(left: 80),
                  child: Row(
                    children: [
                      Image.asset(aboutIcon),
                      SizedBox(
                        width: 20.w,
                      ),
                      Text(
                        'About',
                        style: googleTextStyle(
                            30.sp, FontWeight.w500, Colors.white),
                      ),
                    ],
                  ),
                ),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => AboutScreen(),
                  ));
                },
              ),
              Divider(
                color: Colors.white.withOpacity(0.5),
                indent: 50,
                thickness: 0.5,
                endIndent: 50,
              ),
            ],
          ),
        ),
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
                            "assets/images/rame_173.png",
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
                          Container(
                            child: Container(
                              padding: EdgeInsets.only(left: 77),
                              height: 50,
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.circle,
                                    color: lgStatus
                                        ? const Color.fromARGB(255, 0, 255, 8)
                                        : Colors.red,
                                    size: 14,
                                  ),
                                  SizedBox(
                                    width: 5.0,
                                  ),
                                  Text(
                                    key: connectionLGStatusKey,
                                    lgStatus
                                        ? 'LG CONNECTED'
                                        : 'LG DISCONNECTED',
                                    style: TextStyle(
                                        color: lgStatus
                                            ? const Color.fromARGB(
                                                255, 0, 255, 8)
                                            : Colors.red,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 19.sp),
                                  ),
                                  SizedBox(
                                    width: 15.0,
                                  ),
                                  Icon(
                                    Icons.circle,
                                    color: aiStatus
                                        ? const Color.fromARGB(255, 0, 255, 8)
                                        : Colors.red,
                                    size: 14,
                                  ),
                                  SizedBox(
                                    width: 5.0,
                                  ),
                                  Text(
                                    key: connectionAIStatusKey,
                                    aiStatus
                                        ? 'AI SERVER CONNECTED'
                                        : 'AI SERVER DISCONNECTED',
                                    style: TextStyle(
                                        color: aiStatus
                                            ? const Color.fromARGB(
                                                255, 0, 255, 8)
                                            : Colors.red,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 19.sp),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 250.w,
                    ),
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.only(top: 55.h),
                          child: Text(
                            "Made with",
                            style:
                                googleTextStyle(28.sp, FontWeight.w600, white),
                          ),
                        ),
                        Image.asset(
                          "assets/images/gemma1.png",
                          scale: 15,
                          // color: Colors.white,
                        )
                      ],
                    ),
                  ],
                ),
                actions: [
                  IconButton(
                      onPressed: () {
                        _scaffoldKey.currentState!.openEndDrawer();
                      },
                      icon: Container(
                          padding: const EdgeInsets.fromLTRB(0, 0, 45, 0),
                          child: Image.asset(
                            drawerLogo,
                            key: drawerIconKey,
                          )))
                ],
              ),
            )

            // UpperBar(
            //     lgStatus: lgStatus,
            //     aiStatus: aiStatus,
            //     scaffoldKey: _scaffoldKey),
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
                    key: searchBarKey,
                    width: size.width * .82,
                    height: 75,
                    padding: EdgeInsets.fromLTRB(0, 0, 125.w, 0),
                    decoration: BoxDecoration(
                      color: darkSecondaryColor,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Container(
                      clipBehavior: Clip.hardEdge,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: Colors.white,
                      ),
                      // padding: const EdgeInsets.all(8.0),
                      child: GooglePlaceAutoCompleteTextField(
                        textEditingController: _textEditingController,
                        focusNode: textFocus,
                        googleAPIKey: "",
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
                                key: micKey,
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
                              textFocus.unfocus();
                              break;
                            }
                          }
                          if (isCity) {
                            await Future.delayed(Duration(seconds: 1));
                            print("It is a city");
                            print(prediction.placeId);
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
                            LatLng coordinates = LatLng(cityLat, cityLong);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => CityInformationScreen(
                                    cityName: cityName,
                                    countryName: secondName,
                                    coordinates: coordinates,
                                  ),
                                ));
                          } else {
                            // ToastService.showErrorToast(
                            //   context,
                            //   length: ToastLength.medium,
                            //   expandedHeight: 100,
                            //   message: "It is not a city, try again!",
                            // );
                            _textEditingController.clear();
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
              ),
              SizedBox(
                height: 55.h,
              ),
              // SizedBox(
              //   // key: searchBarKey,
              //   child: ElevatedButton(
              //       onPressed: () async {
              //         // await downloadKml(
              //         //     "https://drive.google.com/uc?export=download&id=1PloiQN9rAg710XaFnqvDEK300IFxee_p",
              //         //     "amsterdamOutline",
              //         //     "amsterdam");
              //         // var option = data['amsterdam']?[0]['type'];
              //         // if (option == "cityOutline") {
              //         //   var url = data['amsterdam']?[0]['link'] ?? "";
              //         //   await downloadKml(url, "amsterdamOutline", "amsterdam");
              //         // } else if (option == "historicalMap") {}
              //         // String imgURL =
              //         //     await getPlaceIdFromName("bollywood mumbai");
              //         // print("this is : $imgURL");
              //         // setState(() {
              //         //   isURL = true;
              //         //   img = imgURL;
              //         // });
              //       },
              //       child: Text("Hello")),
              // ),
              // isURL ? Image.network(img) : Container(),
              Container(key: cityCardKey, child: RecomendCities())
            ],
          ),
        )));
  }
}
