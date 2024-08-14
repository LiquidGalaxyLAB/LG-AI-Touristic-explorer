import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:lg_ai_touristic_explorer/constants/constants.dart';
import 'package:lg_ai_touristic_explorer/models/city.dart';
import 'package:shared_preferences/shared_preferences.dart';

String removeMarkdown(String responseText) {
  final pattern = RegExp(
      r'(\n|\\n|```|``|json|</start_of_turn>|<end_of_turn>|<eos>|<start_of_turn>)|</end_of_turn>|\u003C/start_of_turn\u003E|\u003E|\u003C|/start_of_turn|JSON');
  return responseText.replaceAll(pattern, '');
}

Future<String> generateStory(String cityName, String locale) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final apiKey = prefs.getString('geminiAPI') ?? "";
  final model = GenerativeModel(model: 'gemini-pro', apiKey: apiKey);
  String language = getLanguageName(locale);

  final prompt = """
Write a captivating and vivid story about $cityName. Describe the city's landmarks, history, and unique aspects in an engaging and imaginative way. Include interesting characters or events that make the city come to life. The story should transport the reader to $cityName and give them a sense of its charm and atmosphere. 100 words. 
""";
  final content = [Content.text(prompt)];
  final response = await model.generateContent(content,
      generationConfig: GenerationConfig(maxOutputTokens: 8192));
  print(response.text!);
  return response.text!;
}

//

// You’re a seasoned data analyst with extensive experience in gathering and organizing detailed information about cities around the globe. Your specialty lies in compiling factual and structured data with a rich depth of insight.Your task is to generate a JSON object that encapsulates comprehensive $factType information about a specific city, referred to as $cityName.
// The JSON object should adhere to the following structure: {\"${factType}_facts\": [{{\"fact\":\"detailed information about fact\"}}, {{\"fact\":\"detailed information about fact\"}}, ...]}}. It is critical that all JSON keys remain in English and follow the specified format, maintaining consistency even when the facts themselves are presented in another language.
// Ensure that the output conforms strictly to the defined JSON format, avoiding the inclusion of any additional symbols, newline characters, or unnecessary information. Keep in mind to exclude any sensitive data. The response should be formatted in $language. DO NOT use \" \" (quotation) in any fact information it messes the formatter
generateFacts(String factType, String cityName, String locale) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final apiKey = prefs.getString('geminiAPI') ?? "";
  final model = GenerativeModel(model: 'gemini-pro', apiKey: apiKey);
  String language = getLanguageName(locale);

  final prompt = '''
You’re an experienced data analyst responsible for compiling 4-5 very detailed $factType information (more than 25 words) about various cities worldwide. Your task here is to create a JSON object that includes detailed $factType information about $cityName. Task: Create a JSON object that includes detailed $factType information about the $cityName. The JSON object should be structured as follows: {"${factType}_facts": [{{"fact":"detailed information about fact"}}, {{"fact":"detailed information about fact"}}, ...]}} and The JSON KEYS SHOULD BE IN ENGLISH ONLY AND SHOULD BE OF THE SAME FORMAT AS GIVEN, EVEN IF THE LANGUAGE OF THE FACTS IS DIFFERENT (ENSURE THIS). The response should strictly adhere to the specified JSON format, with no additional symbols, newline characters, or extraneous information. Ensure that no sensitive data is included. IN $language. The JSON KEYS SHOULD BE IN ENGLISH ONLY.
''';
  print(prompt);
  try {
    final content = [Content.text(prompt)];
    final response = await model.generateContent(content,
        generationConfig: GenerationConfig(maxOutputTokens: 8192));
    final responseData = response.text!;
    final cleanedString = removeMarkdown(responseData);
    // final parsedData = jsonDecode(cleanedString);
    // print(parsedData);
    return cleanedString;
  } catch (e) {
    print("An error occurred: $e");
    return {'error': 'An error occurred during generation'};
  }
}

Future<City> getCityInformation(
    String cityName, LatLng coordinates, String locale) async {
  final historicalFacts = await generateFacts("historical", cityName, locale);
  print("this is historical");
  print(historicalFacts);
  final culturalFacts = await generateFacts("cultural", cityName, locale);
  print("This is cultural");
  print(culturalFacts);
  final geographicalFacts =
      await generateFacts("geographical", cityName, locale);
  print("This is geographical");
  print(geographicalFacts);

  var result = {
    "historical_facts": historicalFacts,
    "cultural_facts": culturalFacts,
    "geographical_facts": geographicalFacts
  };
  print("tis is result");
  print(result);
  return City.fromJson(result, coordinates);
}
