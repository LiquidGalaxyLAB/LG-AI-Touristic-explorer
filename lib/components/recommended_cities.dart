import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lg_ai_touristic_explorer/components/city_card.dart';
import 'package:lg_ai_touristic_explorer/constants/images.dart';

class RecomendCities extends StatelessWidget {
  const RecomendCities({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const CityCard(
              cityName: "London",
              countryName: "England",
              imageName: londonImage,
            ),
            SizedBox(
              height: 40.h,
            ),
            // const CityCard(
            //   cityName: "Tokyo",
            //   countryName: "Japan",
            //   imageName: image,
            // ),
          ],
        ),
        SizedBox(
          width: 40.w,
        ),
        Column(
          children: [
            const CityCard(
              cityName: "New York",
              countryName: "America",
              imageName: newYorkImage,
            ),
            SizedBox(
              height: 40.h,
            ),
            // const CityCard(
            //   cityName: "San Francisco",
            //   countryName: "America",
            //   imageName: image,
            // ),
          ],
        ),
        SizedBox(
          width: 40.w,
        ),
        Column(
          children: [
            const CityCard(
              cityName: "Paris",
              countryName: "France",
              imageName: parisImage,
            ),
            SizedBox(
              height: 40.h,
            ),
            // const CityCard(
            //   cityName: "Delhi",
            //   countryName: "India",
            //   imageName: image,
            // ),
          ],
        )
      ],
    );
  }
}
