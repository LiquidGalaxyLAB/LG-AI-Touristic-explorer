import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lg_ai_touristic_explorer/constants/constants.dart';
import 'package:lg_ai_touristic_explorer/constants/images.dart';
import 'package:lg_ai_touristic_explorer/screens/about_screen.dart';
import 'package:lg_ai_touristic_explorer/screens/connection_manager.dart';
import 'package:lg_ai_touristic_explorer/screens/home_screen.dart';
import 'package:lg_ai_touristic_explorer/screens/lg_tasks_screen.dart';
import 'package:lg_ai_touristic_explorer/utils/common.dart';
import '../constants/text_styles.dart';

class AppDrawer extends StatefulWidget {
  const AppDrawer({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  @override
  Widget build(BuildContext context) {
    String? dropDownValue = '';
    return Drawer(
      width: widget.size.width * .35,
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
                    style:
                        googleTextStyle(30.sp, FontWeight.w500, Colors.white),
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
                    style:
                        googleTextStyle(30.sp, FontWeight.w500, Colors.white),
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
                    style:
                        googleTextStyle(30.sp, FontWeight.w500, Colors.white),
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
                    style:
                        googleTextStyle(30.sp, FontWeight.w500, Colors.white),
                  ),
                  15.pw,
                  Container(
                      width: 120.w,
                      child: DropdownButtonFormField(
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
                    style:
                        googleTextStyle(30.sp, FontWeight.w500, Colors.white),
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
    );
  }
}
