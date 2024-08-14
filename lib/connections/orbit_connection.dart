import 'dart:convert';
import 'package:geocoding/geocoding.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:lg_ai_touristic_explorer/connections/gemini_service.dart';
import 'package:lg_ai_touristic_explorer/constants/constants.dart';
import 'package:lg_ai_touristic_explorer/constants/images.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

Future<String> getPlaceIdFromName(String placeName) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
   final apiKey =
      prefs.getString('mapsAPI') ?? "";
  final uri = Uri.parse(
      'https://maps.googleapis.com/maps/api/geocode/json?address=$placeName&key=$apiKey');
  final response = await http.get(uri);

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    if (data['status'] == 'OK') {
      final results = data['results'] as List;
      if (results.isNotEmpty) {
        final firstResult = results[0];
        final placeId = firstResult['place_id'] as String;
        var result = await fetchPhotoReferences(placeId);
        return result.toString();
      }
    }
  }
  return mainLogoAWS;
}

fetchPhotoReferences(String placeId) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
   final apiKey =
      prefs.getString('mapsAPI') ?? "";  final url = Uri.parse(
      'https://maps.googleapis.com/maps/api/place/details/json?placeid=$placeId&key=$apiKey');
  final response = await http.get(url);

  if (response.statusCode == 200) {
    print("here");
    final Map<String, dynamic> data =
        json.decode(response.body) as Map<String, dynamic>;
    final photos = extractPhotos(data);
    // for (var photo in photos) {
    //   print('Photo reference: ${photo['photo_reference']}');
    //   print(fetchPhoto(photo['photo_reference'], apiKey));
    // }
    var result = await fetchPhoto(photos[1]['photo_reference'],
        photos[1]['height'], photos[1]['width'], apiKey);
    return result;
  } else {
    //TODO Error handling
    throw Exception('Failed to fetch place details: ${response.statusCode}');
  }
}

List<Map<String, dynamic>> extractPhotos(Map<String, dynamic> data) {
  if (data['result'] != null && data['result']['photos'] != null) {
    return List<Map<String, dynamic>>.from(data['result']['photos']);
  } else {
    return [];
  }
}

fetchPhoto(String photoReference, int height, int width, String apiKey) async {
  final url = Uri.parse(
      'https://maps.googleapis.com/maps/api/place/photo?maxwidth=$width&photo_reference=$photoReference&key=$apiKey&maxheight=$height');

  final response = await http.post(url);
  if (response.statusCode == 302) {
    return url;
  } else {
    print("error");
    // throw Exception('Failed to fetch photo: ${response.statusCode}');
  }
}

generatePOI(String city, LatLng coordinates, String locale) async {
  print('Debug: Starting generatePOI function');

  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final apiKey = prefs.getString('geminiAPI') ?? "";
  final model = GenerativeModel(model: 'gemini-pro', apiKey: apiKey);
  String language = getLanguageName(locale);
  print('Debug: Detected language: $language');

  final prompt = """
Create a JSON object that includes detailed information about the 4-5 most famous points of interest in the city $city. The JSON object should be structured as follows: {"points_of_interest": [{"name": "Name of the point of interest", "details": "Detailed information about the point of interest"}, {"name": "Name of the point of interest", "details": "Detailed information about the point of interest"}, ...]} and The JSON KEYS AND NAME OF THE POINT OF INTEREST ("name") SHOULD BE IN ENGLISH ONLY EVEN IF THE LANGUAGE OF THE FACTS IS DIFFERENT. The response should strictly adhere to the specified JSON format, with no additional symbols, newline characters, or extraneous information. IN $language. Do not use quotation marks ("") in any facts or text strings to prevent issues with the JSON format.
""";
  print('Debug: Generated prompt: $prompt');

  try {
    final content = [Content.text(prompt)];
    final response = await model.generateContent(content,
        generationConfig: GenerationConfig(maxOutputTokens: 8192));
    String responseText = response.text!;
    print('Debug: Received response: $responseText');

    String cleanedString = removeMarkdown(responseText);
    print('Debug: Cleaned response: $cleanedString');

    final Map<String, dynamic> object = jsonDecode(cleanedString);
    print('Debug: Decoded JSON object: $object');

    for (var point in object['points_of_interest']) {
      print('Debug: Processing point of interest: ${point['name']}');
      var coords = await _getCoordinates(point['name'], coordinates);
      point['coordinates'] = coords;
      print('Debug: Retrieved coordinates: $coords');

      // var imageUrl = mainLogoAWS;
      var imageUrl = await getPlaceIdFromName(point['name']);
      point['imageUrl'] = imageUrl;
      print('Debug: Retrieved image URL: $imageUrl');
    }

    final List<dynamic> pointsOfInterest = object["points_of_interest"];
    final List<Place> places =
        pointsOfInterest.map((poi) => Place.fromJson(poi)).toList();

    for (var place in places) {
      print('Name: ${place.name}');
      print('Details: ${place.details}');
      print('Latitude: ${place.latitude}');
      print('Longitude: ${place.longitude}');
      print('Image URL: ${place.imageUrl}');
    }

    print('Debug: Completed processing all points of interest');
    return places;
  } catch (e) {
    print('Error: $e');
    throw Exception('Failed to fetch data: $e');
  }
}
