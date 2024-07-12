import 'dart:convert';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:lg_ai_touristic_explorer/models/city.dart';
import 'package:shared_preferences/shared_preferences.dart';

String removeMarkdown(String responseText) {
  final pattern = RegExp(
      r'(\n|\\n|```|``|json|</start_of_turn>|<end_of_turn>|<eos>|<start_of_turn>)|</end_of_turn>');
  return responseText.replaceAll(pattern, '');
}

Future<City> getCityInformation(String city, LatLng coordinates) async {
  const url = 'http://127.0.0.1:8107/getCityInformation';

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

Future<bool> checkAIServerConnection() async {
  try {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String ipAIServer = prefs.getString("ipAIServer") ?? "127.0.0.1";
    String portAIServer = prefs.getString("portAIServer") ?? "8107";
    String apiURL = "http://$ipAIServer:$portAIServer/hello";
    http.Response response = await http.get(Uri.parse(apiURL));
    return response.statusCode == 200;
  } catch (e) {
    print('Error checking AI server connection: $e');
    return false;
  }
}
