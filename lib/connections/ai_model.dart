import 'dart:convert';
import 'package:http/http.dart' as http;

Future<String> getGeographicalFacts(String city) async {
  const url = 'http://127.0.0.1:5000/generateGeographical';

  final response = await http.post(
    Uri.parse(url),
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode({'text': city}),
  );

  if (response.statusCode == 200) {
    String responseText = response.body;

    String cleanedString = responseText.replaceAll('\n', '');
    cleanedString = cleanedString.replaceAll('\\n', '');
    cleanedString = cleanedString.replaceAll('json', '');
    cleanedString = cleanedString.replaceAll('```', '');
    cleanedString = cleanedString.replaceAll('``', '');

    const JsonDecoder decoder = JsonDecoder();
    final Map<String, dynamic> object = decoder.convert(cleanedString);

    print(cleanedString);
    return cleanedString;
  } else {
    throw Exception(
        'Failed to fetch data. Status code: ${response.statusCode}');
  }
}
