import 'dart:convert';
import 'package:geocoding/geocoding.dart';
import 'package:http/http.dart' as http;
import 'package:lg_ai_touristic_explorer/connections/ai_model.dart';

Future<Map<String, double>> _getCoordinates(String landmark) async {
  try {
    List<Location> locations = await locationFromAddress(landmark);
    return {
      'latitude': locations.first.latitude,
      'longitude': locations.first.longitude,
    };
  } catch (e) {
    print('Error: $e');
    return {
      'latitude': 0.0,
      'longitude': 0.0,
    };
  }
}

Future<String> generatePOI(String city) async {
  const url = 'http://127.0.0.1:5000/generatePOI';

  final response = await http.post(
    Uri.parse(url),
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode({'text': city}),
  );

  if (response.statusCode == 200) {
    String responseText = response.body;

    String cleanedString = removeMarkdown(responseText);

    const JsonDecoder decoder = JsonDecoder();
    final Map<String, dynamic> object = decoder.convert(cleanedString);

    if (object.containsKey('response')) {
      final dynamic responseObject = object['response'];
      if (responseObject is String) {
        final Map<String, dynamic> pointsOfInterest =
            decoder.convert(responseObject);

        for (var point in pointsOfInterest['points_of_interest']) {
          var coordinates = await _getCoordinates(point['name']);
          point['coordinates'] = coordinates;
        }
        print(pointsOfInterest);
        return pointsOfInterest.toString();
      } else {
        return ('Error: "response" is not a string');
      }
    } else {
      return ('Error: "response" key not found');
    }
  } else {
    throw Exception(
        'Failed to fetch data. Status code: ${response.statusCode}');
  }
}
