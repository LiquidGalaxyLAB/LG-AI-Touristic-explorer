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
            city: losAngeles,
            cityPOI: losAngelesPOI,
          ),
          SizedBox(
            width: 40.0,
          ),
          CityCard(
            cityName: "Miami",
            countryName: "USA",
            imageName: miamiImage,
            city: miami,
            cityPOI: miamiPOI,
          ),
          SizedBox(
            width: 40.0,
          ),
          CityCard(
            cityName: "Mumbai",
            countryName: "India",
            imageName: mumbaiImage,
            city: mumbai,
            cityPOI: mumbaiPOI,
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
            cityName: "Seattle",
            countryName: "USA",
            imageName: seattleImage,
            city: seattle,
            cityPOI: seattlePOI,
          ),
          SizedBox(
            width: 40.0,
          ),
          CityCard(
            cityName: "Chicago",
            countryName: "USA",
            imageName: chicagoImage,
            city: chicago,
            cityPOI: chicagoPOI,
          ),
          SizedBox(
            width: 40.0,
          ),
          CityCard(
            cityName: "Washington DC",
            countryName: "USA",
            imageName: washingtondcImage,
            city: washingtonDC,
            cityPOI: washingtonDCPOI,
          ),
          SizedBox(
            width: 40.0,
          ),
          CityCard(
            cityName: "Austin",
            countryName: "USA",
            imageName: austinImage,
            city: austin,
            cityPOI: austinPOI,
          ),
          SizedBox(
            width: 40.0,
          ),
        ],
      ),
    );
  }
}
