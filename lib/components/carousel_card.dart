import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lg_ai_touristic_explorer/constants/constants.dart';
import 'package:lg_ai_touristic_explorer/constants/text_styles.dart';
import 'package:lg_ai_touristic_explorer/utils/common.dart';

class CarouselCard extends StatelessWidget {
  final String factTitle;
  final String factDesc;
  const CarouselCard({
    super.key,
    required this.factTitle,
    required this.factDesc,
  });

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
          color: greenShade,
          borderRadius: BorderRadiusDirectional.circular(25)),
      child: Container(
        width: size.width * 0.35,
        padding: EdgeInsets.all(30),
        child: Column(
          children: [
            Text(
              factTitle,
              style: googleTextStyle(40.sp, FontWeight.w700, fontGreen),
            ),
            20.ph,
            Container(
              width: size.width * 0.35,
              child: Text(
                factDesc,
                style: googleTextStyle(28.sp, FontWeight.w500, Colors.black),
                overflow: TextOverflow.clip,
                textAlign: TextAlign.justify,
              ),
            ),
            2.ph
          ],
        ),
      ),
    );
  }
}
