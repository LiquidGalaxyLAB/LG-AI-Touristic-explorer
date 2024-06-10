import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lg_ai_touristic_explorer/constants/constants.dart';
import 'package:lg_ai_touristic_explorer/constants/images.dart';
import 'package:lg_ai_touristic_explorer/screens/home_screen.dart';
import '../constants/text_styles.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Drawer(
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
                mainLogo,
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
                  const Icon(Icons.settings, color: Colors.cyan, size: 25),
                  SizedBox(
                    width: 20.w,
                  ),
                  Text(
                    'Set API Keys',
                    style:
                        googleTextStyle(30.sp, FontWeight.w500, Colors.white),
                  ),
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
            onTap: () {},
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
