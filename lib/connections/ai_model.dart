import 'dart:convert';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:lg_ai_touristic_explorer/models/city.dart';
import 'package:shared_preferences/shared_preferences.dart';

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