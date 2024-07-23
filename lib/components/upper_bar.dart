import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lg_ai_touristic_explorer/components/connection_flag.dart';
import 'package:lg_ai_touristic_explorer/constants/constants.dart';
import 'package:lg_ai_touristic_explorer/constants/images.dart';
import 'package:lg_ai_touristic_explorer/constants/text_styles.dart';

class UpperBar extends StatelessWidget {
  const UpperBar({
    super.key,
    required this.lgStatus,
    required this.aiStatus,
    required GlobalKey<ScaffoldState> scaffoldKey,
  }) : _scaffoldKey = scaffoldKey;

  final bool lgStatus;
  final bool aiStatus;
  final GlobalKey<ScaffoldState> _scaffoldKey;

  @override
  Widget build(BuildContext context) {
    return Container(
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
                  ConnectionFlag(
                    lgStatus: lgStatus,
                    aiStatus: aiStatus,
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
                    style: googleTextStyle(28.sp, FontWeight.w600, white),
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
                  child: Image.asset(drawerLogo)))
        ],
      ),
    );
  }
}
