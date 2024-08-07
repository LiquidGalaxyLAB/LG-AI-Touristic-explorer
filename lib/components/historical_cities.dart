import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:lg_ai_touristic_explorer/components/city_card.dart';
import 'package:lg_ai_touristic_explorer/constants/images.dart';
import 'package:lg_ai_touristic_explorer/utils/cityKMLData.dart';

class HistoricalCities extends StatelessWidget {
  const HistoricalCities({
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
            cityName: "Los Angeles",
            countryName: "USA",
            imageName: losangelesImage,
            city: newYork,
            cityPOI: newYorkPOI,
          ),
          SizedBox(
            width: 40.0,
          ),
          CityCard(
            cityName: "Miami",
            countryName: "USA",
            imageName: miamiImage,
            city: newYork,
            cityPOI: newYorkPOI,
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
            city: newYork,
            cityPOI: parisPOI,
          ),
          SizedBox(
            width: 40.0,
          ),
          CityCard(
            cityName: "San Francisco",
            countryName: "USA",
            imageName: sanfranciscoImage,
            city: newYork,
            cityPOI: newYorkPOI,
          ),
          SizedBox(
            width: 40.0,
          ),
          CityCard(
            cityName: "Seattle",
            countryName: "USA",
            imageName: seattleImage,
            city: newYork,
            cityPOI: newYorkPOI,
          ),
          SizedBox(
            width: 40.0,
          ),
          CityCard(
            cityName: "Chicago",
            countryName: "USA",
            imageName: chicagoImage,
            city: newYork,
            cityPOI: newYorkPOI,
          ),
          SizedBox(
            width: 40.0,
          ),
          CityCard(
            cityName: "Washington DC",
            countryName: "USA",
            imageName: washingtondcImage,
            city: newYork,
            cityPOI: newYorkPOI,
          ),
          SizedBox(
            width: 40.0,
          ),
          CityCard(
            cityName: "Austin",
            countryName: "USA",
            imageName: austinImage,
            city: newYork,
            cityPOI: newYorkPOI,
          ),
          SizedBox(
            width: 40.0,
          ),
          CityCard(
            cityName: "Mumbai",
            countryName: "India",
            imageName: mumbaiImage,
            city: newYork,
            cityPOI: newYorkPOI,
          ),
          SizedBox(
            width: 40.0,
          ),
        ],
      ),
    );
  }
}
