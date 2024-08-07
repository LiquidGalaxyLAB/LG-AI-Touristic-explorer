import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:lg_ai_touristic_explorer/components/city_card.dart';
import 'package:lg_ai_touristic_explorer/constants/images.dart';
import 'package:lg_ai_touristic_explorer/utils/cityKMLData.dart';

class OutlineCities extends StatelessWidget {
  const OutlineCities({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 100.0),
      height: 200.0,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          CityCard(
            cityName: "Amsterdam",
            countryName: "Netherlands",
            imageName: amsterdamImage,
            city: amsterdam,
            cityPOI: amsterdamPOI,
          ),
          SizedBox(
            width: 40.0,
          ),
          CityCard(
            cityName: "Barcelona",
            countryName: "Spain",
            imageName: barcelonaImage,
            city: barcelona,
            cityPOI: barcelonaPOI,
          ),
          SizedBox(
            width: 40.0,
          ),
          CityCard(
            cityName: "Berlin",
            countryName: "Germany",
            imageName: berlinImage,
            city: berlin,
            cityPOI: berlinPOI,
          ),
          SizedBox(
            width: 40.0,
          ),
          CityCard(
            cityName: "London",
            countryName: "England",
            imageName: londonImage,
            city: london,
            cityPOI: londonPOI,
          ),
          SizedBox(
            width: 40.0,
          ),
          CityCard(
            cityName: "Los Angeles",
            countryName: "USA",
            imageName: losangelesImage,
            city: losAngeles,
            cityPOI: losAngelesPOI,
          ),
          SizedBox(
            width: 40.0,
          ),
          CityCard(
            cityName: "New York",
            countryName: "USA",
            imageName: newYorkImage,
            city: newYork,
            cityPOI: newYorkPOI,
          ),
          SizedBox(
            width: 40.0,
          ),
          CityCard(
            cityName: "Paris",
            countryName: "France",
            imageName: parisImage,
            city: paris,
            cityPOI: parisPOI,
          ),
          SizedBox(
            width: 40.0,
          ),
          CityCard(
            cityName: "San Francisco",
            countryName: "USA",
            imageName: sanfranciscoImage,
            city: sanFrancisco,
            cityPOI: sanFranciscoPOI,
          ),
          SizedBox(
            width: 40.0,
          ),
          CityCard(
            cityName: "Sydney",
            countryName: "Australia",
            imageName: sydneyImage,
            city: sydney,
            cityPOI: sydneyPOI,
          ),
          SizedBox(
            width: 40.0,
          ),
          CityCard(
            cityName: "Toronto",
            countryName: "Canada",
            imageName: torontoImage,
            city: toronto,
            cityPOI: torontoPOI,
          ),
          SizedBox(
            width: 40.0,
          ),
        ],
      ),
    );

    // Row(
    //   mainAxisAlignment: MainAxisAlignment.center,
    //   children: [
    //     Column(
    //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //       children: [
    //         CityCard(
    //           cityName: "London",
    //           countryName: "England",
    //           imageName: londonImage,
    //           city: london,
    //           cityPOI: londonPOI,
    //         ),
    //         SizedBox(
    //           height: 40.h,
    //         ),
    //         // const CityCard(
    //         //   cityName: "Tokyo",
    //         //   countryName: "Japan",
    //         //   imageName: image,
    //         // ),
    //       ],
    //     ),
    //     SizedBox(
    //       width: 40.w,
    //     ),
    //     Column(
    //       children: [
    //         CityCard(
    //           cityName: "New York",
    //           countryName: "America",
    //           imageName: newYorkImage,
    //           city: newYork,
    //           cityPOI: newYorkPOI,
    //         ),
    //         SizedBox(
    //           height: 40.h,
    //         ),
    //         // const CityCard(
    //         //   cityName: "San Francisco",
    //         //   countryName: "America",
    //         //   imageName: image,
    //         // ),
    //       ],
    //     ),
    //     SizedBox(
    //       width: 40.w,
    //     ),
    //     CityCard(
    //       cityName: "Paris",
    //       countryName: "France",
    //       imageName: parisImage,
    //       city: paris,
    //       cityPOI: parisPOI,
    //     ),
    //   ],
    // );
  }
}
