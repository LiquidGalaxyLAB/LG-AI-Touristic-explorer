import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lg_ai_touristic_explorer/components/connection_flag.dart';
import 'package:lg_ai_touristic_explorer/components/upper_bar.dart';
import 'package:lg_ai_touristic_explorer/connections/lg_connection.dart';
import 'package:lg_ai_touristic_explorer/constants/constants.dart';
import 'package:lg_ai_touristic_explorer/constants/images.dart';
import 'package:lg_ai_touristic_explorer/constants/text_styles.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../components/drawer.dart';

class LGTasks extends StatefulWidget {
  const LGTasks({super.key});

  @override
  State<LGTasks> createState() => _LGTasksState();
}

class _LGTasksState extends State<LGTasks> {
  @override
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  bool lgStatus = false;
  bool aiStatus = false;
  late LGConnection lg;
  Future<void> _connectToLG() async {
    bool? result = await lg.connectToLG();
    setState(() {
      lgStatus = result!;
    });
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
    _connectToAIServer();
  }

  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: darkBackgroundColor,
      endDrawer: AppDrawer(
        size: size,
      ),
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(140.0),
          child: UpperBar(
              lgStatus: lgStatus,
              aiStatus: aiStatus,
              scaffoldKey: _scaffoldKey)),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(40, 40, 40, 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: size.width * 0.88,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                          onTap: () async {
                            await lg.relaunchLG();
                          },
                          child: Container(
                            alignment: Alignment.center,
                            width: size.width * 0.39,
                            height: size.width * 0.145,
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.2),
                                  spreadRadius: 5,
                                  blurRadius: 15,
                                  offset: const Offset(0, 0),
                                ),
                              ],
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(60),
                            ),
                            child: Text(
                              "Relaunch Rig",
                              textAlign: TextAlign.center,
                              style: googleTextStyle(
                                  45.sp, FontWeight.w700, darkBackgroundColor),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () async {
                            await lg.shutdownLG();
                          },
                          child: Container(
                            alignment: Alignment.center,
                            width: size.width * 0.39,
                            height: size.width * 0.145,
                            decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.2),
                                    spreadRadius: 5,
                                    blurRadius: 15,
                                    offset: const Offset(0, 0),
                                  ),
                                ],
                                color: Colors.yellow,
                                borderRadius: BorderRadius.circular(60)),
                            child: Text(
                              "Shutdown Rig",
                              textAlign: TextAlign.center,
                              style: googleTextStyle(
                                  45.sp, FontWeight.w700, darkBackgroundColor),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 30.h,
                  ),
                  Container(
                    width: size.width * 0.88,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                          onTap: () async {
                            await lg.cleanVisualization();
                          },
                          child: Container(
                            alignment: Alignment.center,
                            width: size.width * 0.39,
                            height: size.width * 0.145,
                            decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.2),
                                    spreadRadius: 5,
                                    blurRadius: 15,
                                    offset: const Offset(0, 0),
                                  ),
                                ],
                                color: const Color.fromARGB(255, 103, 244, 108),
                                borderRadius: BorderRadius.circular(60)),
                            child: Text(
                              "Clean KML",
                              textAlign: TextAlign.center,
                              style: googleTextStyle(
                                  45.sp, FontWeight.w700, darkBackgroundColor),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () async {
                            await lg.rebootLG();
                          },
                          child: Container(
                            alignment: Alignment.center,
                            width: size.width * 0.39,
                            height: size.width * 0.145,
                            decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.2),
                                    spreadRadius: 5,
                                    blurRadius: 15,
                                    offset: const Offset(0, 0),
                                  ),
                                ],
                                color: const Color.fromARGB(255, 76, 232, 240),
                                borderRadius: BorderRadius.circular(60)),
                            child: Text(
                              "Reboot Rig",
                              textAlign: TextAlign.center,
                              style: googleTextStyle(
                                  45.sp, FontWeight.w700, darkBackgroundColor),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 30.h,
                  ),
                  Container(
                    width: size.width * 0.88,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                          onTap: () async {
                            await lg.cleanBalloon();
                          },
                          child: Container(
                            alignment: Alignment.center,
                            width: size.width * 0.39,
                            height: size.width * 0.145,
                            decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.2),
                                    spreadRadius: 5,
                                    blurRadius: 15,
                                    offset: const Offset(0, 0),
                                  ),
                                ],
                                color: Colors.purple,
                                borderRadius: BorderRadius.circular(60)),
                            child: Text(
                              "Clean Logos",
                              textAlign: TextAlign.center,
                              style: googleTextStyle(
                                  45.sp, FontWeight.w700, darkBackgroundColor),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () async {
                            await lg.setRefresh();
                          },
                          child: Container(
                            alignment: Alignment.center,
                            width: size.width * 0.39,
                            height: size.width * 0.145,
                            decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.2),
                                    spreadRadius: 5,
                                    blurRadius: 15,
                                    offset: const Offset(0, 0),
                                  ),
                                ],
                                color: const Color.fromARGB(255, 255, 145, 0),
                                borderRadius: BorderRadius.circular(60)),
                            child: Text(
                              "Set Refresh",
                              textAlign: TextAlign.center,
                              style: googleTextStyle(
                                  45.sp, FontWeight.w700, darkBackgroundColor),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
