import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lg_ai_touristic_explorer/constants/constants.dart';
import 'package:lg_ai_touristic_explorer/constants/text_styles.dart';

class CityCard extends StatelessWidget {
  final String cityName;
  final String imageName;
  final String countryName;

  const CityCard({
    super.key,
    required this.cityName,
    required this.countryName,
    required this.imageName,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Stack(children: [
        Container(
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                spreadRadius: 4,
                blurRadius: 5,
                offset: const Offset(0, 0), // changes position of shadow
              ),
            ],
          ),
          width: 475.w,
          height: 300.h,
          child: Image.asset(imageName, fit: BoxFit.cover),
        ),
        Container(
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: const LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              colors: [Colors.black, Colors.transparent],
            ),
          ),
          width: 475.w,
          height: 300.h,
        ),
        Positioned(
          bottom: 25,
          right: 18,
          child: Container(
              decoration: BoxDecoration(
                  color: darkSecondaryColor,
                  borderRadius: BorderRadius.circular(12)),
              width: 35,
              height: 35,
              child: const Icon(
                Icons.arrow_forward_ios_rounded,
                color: white,
                size: 18,
              )),
        ),
        Positioned(
          bottom: 25,
          left: 20,
          child: Column(
            children: [
              Text(
                cityName,
                style: googleTextStyle(27.sp, FontWeight.w600, Colors.white),
              ),
              SizedBox(
                height: 5.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Icon(
                    Icons.location_pin,
                    color: Colors.red,
                  ),
                  SizedBox(
                    width: 5.h,
                  ),
                  Text(
                    countryName,
                    style:
                        googleTextStyle(20.sp, FontWeight.w400, Colors.white),
                  )
                ],
              )
            ],
          ),
        )
      ]),
    );
  }
}
