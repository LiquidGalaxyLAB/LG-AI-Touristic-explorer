import 'dart:convert';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:lg_ai_touristic_explorer/models/city.dart';

String removeMarkdown(String responseText) {
  final pattern =
      RegExp(r'(\n|\\n|```|``|json|</start_of_turn>|<end_of_turn>|<eos>|<start_of_turn>)|</end_of_turn>');
  return responseText.replaceAll(pattern, '');
}

Future<City> getCityInformation(String city, LatLng coordinates) async {
  const url = 'http://127.0.0.1:5000/getCityInformation';

  final response = await http.post(
    Uri.parse(url),
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode({'text': city}),
  );

  if (response.statusCode == 200) {
    String responseText = response.body;
    String cleanedString = removeMarkdown(responseText);
    final JsonDecoder decoder = JsonDecoder();
    final Map<String, dynamic> object = decoder.convert(cleanedString);

    return City.fromJson(object, coordinates);
  } else {
    throw Exception(
        'Failed to fetch data. Status code: ${response.statusCode}');
  }
}
