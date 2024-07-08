import 'dart:convert';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:lg_ai_touristic_explorer/connections/ai_model.dart';

import '../models/place.dart';

Future<Map<String, double>> _getCoordinates(
    String landmark, LatLng coordinates) async {
  try {
    List<Location> locations = await locationFromAddress(landmark);
    return {
      'latitude': locations.first.latitude,
      'longitude': locations.first.longitude,
    };
  } catch (e) {
    print('Error: $e');
    return {
      'latitude': coordinates.latitude,
      'longitude': coordinates.longitude,
    };
  }
}

Future<List<Place>> generatePOI(String city, LatLng coordinates) async {
  const url = 'http://127.0.0.1:5000/generatePOI';

  final response = await http.post(
    Uri.parse(url),
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode({'text': city}),
  );

  if (response.statusCode == 200) {
    String responseText = response.body;
    String cleanedString = removeMarkdown(responseText);
    final Map<String, dynamic> object = jsonDecode(cleanedString);
    print(cleanedString);

    if (object.containsKey('response')) {
      final dynamic responseObject = object['response'];
      if (responseObject is String) {
        final Map<String, dynamic> jsonObject = jsonDecode(responseObject);

        for (var point in jsonObject['points_of_interest']) {
          var coords = await _getCoordinates(point['name'], coordinates);
          point['coordinates'] = coords;
        }

        final List<dynamic> pointsOfInterest = jsonObject['points_of_interest'];
        final List<Place> places =
            pointsOfInterest.map((poi) => Place.fromJson(poi)).toList();

        for (var place in places) {
          print('Name: ${place.name}');
          print('Details: ${place.details}');
          print('Latitude: ${place.latitude}');
          print('Longitude: ${place.longitude}');
        }
        return places;
      } else {
        throw Exception('Error: "response" is not a string');
      }
    } else {
      throw Exception('Error: "response" key not found');
    }
  } else {
    throw Exception(
        'Failed to fetch data. Status code: ${response.statusCode}');
  }
}
