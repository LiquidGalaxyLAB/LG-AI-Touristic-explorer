import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_translate/flutter_translate.dart';
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
  late LGConnection lg;
  Future<void> _connectToLG() async {
    bool? result = await lg.connectToLG();
    setState(() {
      lgStatus = result!;
    });
  }

  @override
  void initState() {
    super.initState();
    lg = LGConnection();
    _connectToLG();
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
          child: UpperBar(lgStatus: lgStatus, scaffoldKey: _scaffoldKey)),
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
                            bool? confirmed = await showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                        translate('tasks.confirmationRelaunch'),
                                        style: googleTextStyle(
                                            50.sp,
                                            FontWeight.w700,
                                            Colors.blueAccent)),
                                  ),
                                  content: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 8.0, right: 8),
                                    child: Text(
                                        translate(
                                            'tasks.relaunchConfirmationMessage'),
                                        style: googleTextStyle(28.sp,
                                            FontWeight.w400, Colors.black)),
                                  ),
                                  actions: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        SizedBox(
                                          width: 25.w,
                                        ),
                                        Expanded(
                                          child: ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: Colors.white60,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                              ),
                                            ),
                                            onPressed: () {
                                              Navigator.of(context).pop(
                                                  false); // User cancelled the action
                                            },
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                  translate('tasks.cancel'),
                                                  style: googleTextStyle(
                                                      32.sp,
                                                      FontWeight.w500,
                                                      Colors.blueAccent)),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 25.w,
                                        ),
                                        Expanded(
                                          child: ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor:
                                                  Colors.blueAccent,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                              ),
                                            ),
                                            onPressed: () {
                                              Navigator.of(context).pop(
                                                  true); // User confirmed the action
                                            },
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                  translate('tasks.confirm'),
                                                  style: googleTextStyle(
                                                      32.sp,
                                                      FontWeight.w500,
                                                      Colors.white)),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 25.w,
                                        ),
                                      ],
                                    ),
                                  ],
                                );
                              },
                            );

                            if (confirmed == true) {
                              await lg
                                  .relaunchLG(); // Reboot the rig if user confirmed
                            }
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
                              translate('tasks.relaunchRig') + " Rig",
                              textAlign: TextAlign.center,
                              style: googleTextStyle(
                                  45.sp, FontWeight.w700, darkBackgroundColor),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () async {
                            bool? confirmed = await showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                        translate('tasks.confirmationShutdown'),
                                        style: googleTextStyle(
                                            50.sp,
                                            FontWeight.w700,
                                            Colors.blueAccent)),
                                  ),
                                  content: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 8.0, right: 8),
                                    child: Text(
                                        translate(
                                            'tasks.shutdownConfirmationMessage'),
                                        style: googleTextStyle(28.sp,
                                            FontWeight.w400, Colors.black)),
                                  ),
                                  actions: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        SizedBox(
                                          width: 25.w,
                                        ),
                                        Expanded(
                                          child: ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: Colors.white60,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                              ),
                                            ),
                                            onPressed: () {
                                              Navigator.of(context).pop(
                                                  false); // User cancelled the action
                                            },
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                  translate('tasks.cancel'),
                                                  style: googleTextStyle(
                                                      32.sp,
                                                      FontWeight.w500,
                                                      Colors.blueAccent)),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 25.w,
                                        ),
                                        Expanded(
                                          child: ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor:
                                                  Colors.blueAccent,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                              ),
                                            ),
                                            onPressed: () {
                                              Navigator.of(context).pop(
                                                  true); // User confirmed the action
                                            },
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                  translate('tasks.confirm'),
                                                  style: googleTextStyle(
                                                      32.sp,
                                                      FontWeight.w500,
                                                      Colors.white)),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 25.w,
                                        ),
                                      ],
                                    ),
                                  ],
                                );
                              },
                            );

                            if (confirmed == true) {
                              await lg
                                  .shutdownLG(); // Reboot the rig if user confirmed
                            }
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
                              translate('tasks.shutdownRig') + " Rig",
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
                              translate('tasks.cleanKML') + " KML",
                              textAlign: TextAlign.center,
                              style: googleTextStyle(
                                  45.sp, FontWeight.w700, darkBackgroundColor),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () async {
                            bool? confirmed = await showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                        translate('tasks.confirmationReboot'),
                                        style: googleTextStyle(
                                            50.sp,
                                            FontWeight.w700,
                                            Colors.blueAccent)),
                                  ),
                                  content: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 8.0, right: 8),
                                    child: Text(
                                        translate(
                                            'tasks.rebootConfirmationMessage'),
                                        style: googleTextStyle(28.sp,
                                            FontWeight.w400, Colors.black)),
                                  ),
                                  actions: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        SizedBox(
                                          width: 25.w,
                                        ),
                                        Expanded(
                                          child: ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: Colors.white60,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                              ),
                                            ),
                                            onPressed: () {
                                              Navigator.of(context).pop(
                                                  false); // User cancelled the action
                                            },
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                  translate('tasks.cancel'),
                                                  style: googleTextStyle(
                                                      32.sp,
                                                      FontWeight.w500,
                                                      Colors.blueAccent)),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 25.w,
                                        ),
                                        Expanded(
                                          child: ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor:
                                                  Colors.blueAccent,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                              ),
                                            ),
                                            onPressed: () {
                                              Navigator.of(context).pop(
                                                  true); // User confirmed the action
                                            },
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                  translate('tasks.confirm'),
                                                  style: googleTextStyle(
                                                      32.sp,
                                                      FontWeight.w500,
                                                      Colors.white)),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 25.w,
                                        ),
                                      ],
                                    ),
                                  ],
                                );
                              },
                            );

                            if (confirmed == true) {
                              await lg
                                  .rebootLG(); // Reboot the rig if user confirmed
                            }
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
                              translate('tasks.rebootRig') + " Rig",
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
                              translate('tasks.cleanLogos'),
                              textAlign: TextAlign.center,
                              style: googleTextStyle(
                                  45.sp, FontWeight.w700, darkBackgroundColor),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () async {
                            await lg.logosLG(logosLG, factorLogo);
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
                              translate('tasks.showLogos'),
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
