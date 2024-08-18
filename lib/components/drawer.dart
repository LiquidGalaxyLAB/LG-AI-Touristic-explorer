import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:lg_ai_touristic_explorer/constants/constants.dart';
import 'package:lg_ai_touristic_explorer/constants/images.dart';
import 'package:lg_ai_touristic_explorer/screens/about_screen.dart';
import 'package:lg_ai_touristic_explorer/screens/connection_manager.dart';
import 'package:lg_ai_touristic_explorer/screens/home_screen.dart';
import 'package:lg_ai_touristic_explorer/screens/lg_tasks_screen.dart';
import 'package:lg_ai_touristic_explorer/utils/common.dart';
import 'package:lg_ai_touristic_explorer/utils/theme_changer.dart';
import 'package:provider/provider.dart';
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
  GlobalKey apiKeysKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    final themeChanger = Provider.of<ThemeChanger>(context);
    return Drawer(
      width: widget.size.width * .35,
      backgroundColor: Theme.of(context).secondaryHeaderColor,
      child: ListView(
        children: [
          SizedBox(
            height: 80.h,
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
            height: 50.h,
          ),
          ListTile(
            title: Container(
              padding: const EdgeInsets.only(left: 80),
              child: Row(
                children: [
                  Image.asset(homeIcon, color: Theme.of(context).hintColor),
                  SizedBox(
                    width: 20.w,
                  ),
                  Text(
                    translate('drawer.home'),
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
                  Image.asset(tasksIcon, color: Theme.of(context).hintColor),
                  SizedBox(
                    width: 20.w,
                  ),
                  Text(
                    translate('drawer.tasks'),
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
                  Image.asset(connectionIcon,
                      color: Theme.of(context).hintColor),
                  SizedBox(
                    width: 20.w,
                  ),
                  Text(
                    translate('drawer.manager'),
                    style:
                        googleTextStyle(30.sp, FontWeight.w500, Colors.white),
                  ),
                ],
              ),
            ),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => ConnectionManager(
                  discovery: false,
                  apiKeysKey: apiKeysKey,
                ),
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
                    translate('drawer.selected'),
                    style:
                        googleTextStyle(30.sp, FontWeight.w500, Colors.white),
                  ),
                  15.pw,
                  Container(
                      width: 120.w,
                      child: DropdownButtonFormField(
                        value: LocalizedApp.of(context)
                            .delegate
                            .currentLocale
                            .toString()
                            .toUpperCase(),
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
                            value: "ES",
                            child: Text(
                              "🇪🇸 ES",
                              style: googleTextStyle(
                                  25.sp, FontWeight.w500, white),
                            ),
                          ),
                          DropdownMenuItem(
                            value: "HI",
                            child: Text(
                              "🇮🇳 HI",
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
                            value: "IT",
                            child: Text(
                              "🇮🇹 IT",
                              style: googleTextStyle(
                                  25.sp, FontWeight.w500, white),
                            ),
                          ),
                          DropdownMenuItem(
                            value: "JA",
                            child: Text(
                              "🇯🇵 JP",
                              style: googleTextStyle(
                                  25.sp, FontWeight.w500, white),
                            ),
                          ),
                          DropdownMenuItem(
                            value: "ZH",
                            child: Text(
                              "🇨🇳 ZH",
                              style: googleTextStyle(
                                  25.sp, FontWeight.w500, white),
                            ),
                          ),
                        ],
                        onChanged: (locale) {
                          String newLocale = locale!.toLowerCase();
                          print(newLocale);

                          changeLocale(context, newLocale);
                        },
                        dropdownColor: Theme.of(context).primaryColor,
                      )),
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
                  Text(
                    translate('drawer.theme') + ": ",
                    style:
                        googleTextStyle(30.sp, FontWeight.w500, Colors.white),
                  ),
                  15.pw,
                  Container(
                      width: 100.w,
                      child: DropdownButtonFormField(
                        value: themeChanger.getCurrentThemeProfile(),
                        items: [
                          DropdownMenuItem(
                              value: "primary",
                              child: Container(
                                alignment: Alignment.center,
                                child: Container(
                                    width: 35,
                                    height: 35,
                                    // borderradius
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      // borderthickness
                                      border: Border.all(
                                          color: Colors.black, width: 2),
                                      color: Colors.blue,
                                    )),
                              )),
                          DropdownMenuItem(
                              value: "profile1",
                              child: Container(
                                alignment: Alignment.center,
                                child: Container(
                                    width: 35,
                                    height: 35,
                                    // borderradius
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      // borderthickness
                                      border: Border.all(
                                          color: Colors.black, width: 2),
                                      color: Colors.purple,
                                    )),
                              )),
                          DropdownMenuItem(
                              value: "profile3",
                              child: Container(
                                alignment: Alignment.center,
                                child: Container(
                                    width: 35,
                                    height: 35,
                                    // borderradius
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      // borderthickness
                                      border: Border.all(
                                          color: Colors.black, width: 2),
                                      color: Colors.green,
                                    )),
                              )),
                          DropdownMenuItem(
                              value: "profile4",
                              child: Container(
                                alignment: Alignment.center,
                                child: Container(
                                    width: 35,
                                    height: 35,
                                    // borderradius
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      // borderthickness
                                      border: Border.all(
                                          color: Colors.black, width: 2),
                                      color: Colors.pink,
                                    )),
                              )),
                          DropdownMenuItem(
                              value: "profile5",
                              child: Container(
                                alignment: Alignment.center,
                                child: Container(
                                    width: 35,
                                    height: 35,
                                    // borderradius
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      // borderthickness
                                      border: Border.all(
                                          color: Colors.black, width: 2),
                                      color: Colors.teal,
                                    )),
                              )),
                          DropdownMenuItem(
                              value: "profile2",
                              child: Container(
                                alignment: Alignment.center,
                                child: Container(
                                    width: 35,
                                    height: 35,
                                    // borderradius
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      // borderthickness
                                      border: Border.all(
                                          color: Colors.black, width: 2),
                                      color: Colors.grey,
                                    )),
                              )),
                        ],
                        onChanged: (themeString) {
                          ThemeData selectedTheme;
                          switch (themeString) {
                            case 'primary':
                              selectedTheme =
                                  primary; // Assuming `primary` is defined in your constants
                              break;
                            case 'profile1':
                              selectedTheme =
                                  profile1; // Assuming `profile1` is defined in your constants
                              break;
                            case 'profile2':
                              selectedTheme =
                                  profile2; // Add `profile2` to your constants
                              break;
                            case 'profile3':
                              selectedTheme =
                                  profile3; // Add `profile2` to your constants
                              break;
                            case 'profile4':
                              selectedTheme =
                                  profile4; // Add `profile2` to your constants
                              break;
                            case 'profile5':
                              selectedTheme =
                                  profile5; // Add `profile2` to your constants
                              break;
                            default:
                              selectedTheme = primary; // Default fallback
                              break;
                          }

                          // Update the theme using ThemeChanger
                          themeChanger.toggleTheme(selectedTheme);
                        },
                        dropdownColor: Theme.of(context).primaryColor,
                      )),
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
                  Image.asset(aboutIcon, color: Theme.of(context).hintColor),
                  SizedBox(
                    width: 20.w,
                  ),
                  Text(
                    translate('drawer.about'),
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
