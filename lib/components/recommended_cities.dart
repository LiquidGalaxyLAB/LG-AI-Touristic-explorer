import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:lg_ai_touristic_explorer/components/city_card.dart';
import 'package:lg_ai_touristic_explorer/constants/images.dart';
import 'package:lg_ai_touristic_explorer/utils/cityKMLData.dart';

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
            CityCard(
              cityName: "London",
              countryName: "England",
              imageName: londonImage,
              city: london,
              cityPOI: londonPOI,
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
            CityCard(
              cityName: "New York",
              countryName: "America",
              imageName: newYorkImage,
              city: newYork,
              cityPOI: newYorkPOI,
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
            CityCard(
              cityName: "Paris",
              countryName: "France",
              imageName: parisImage,
              city: paris,
              cityPOI: parisPOI,
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
