// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:lg_ai_touristic_explorer/models/culture_fact.dart';
import 'package:lg_ai_touristic_explorer/models/geographic_fact.dart';
import 'package:lg_ai_touristic_explorer/models/history_fact.dart';

class City {
  final List<CulturalFact> culturalFacts;
  final List<GeographicalFact> geographicalFacts;
  final List<HistoricalFact> historicalFacts;
  final LatLng coordinates;
  City({
    required this.culturalFacts,
    required this.geographicalFacts,
    required this.historicalFacts,
    required this.coordinates,
  });

  factory City.fromJson(Map<String, dynamic> json, LatLng coordinates) {
    List<CulturalFact> culturalFacts =
        _parseCulturalFacts(json['cultural_facts']);
    List<GeographicalFact> geographicalFacts =
        _parseGeographicalFacts(json['geographical_facts']);
    List<HistoricalFact> historicalFacts =
        _parseHistoricalFacts(json['historical_facts']);

    return City(
      coordinates: coordinates,
      culturalFacts: culturalFacts,
      geographicalFacts: geographicalFacts,
      historicalFacts: historicalFacts,
    );
  }

  static List<CulturalFact> _parseCulturalFacts(String jsonString) {
    final Map<String, dynamic> json = JsonDecoder().convert(jsonString);
    List<dynamic> facts = json['cultural_facts'];
    return facts.map((fact) => CulturalFact.fromJson(fact)).toList();
  }

  static List<GeographicalFact> _parseGeographicalFacts(String jsonString) {
    final Map<String, dynamic> json = JsonDecoder().convert(jsonString);
    List<dynamic> facts = json['geographical_facts'];
    return facts.map((fact) => GeographicalFact.fromJson(fact)).toList();
  }

  static List<HistoricalFact> _parseHistoricalFacts(String jsonString) {
    final Map<String, dynamic> json = JsonDecoder().convert(jsonString);
    List<dynamic> facts = json['historical_facts'];
    return facts.map((fact) => HistoricalFact.fromJson(fact)).toList();
  }
}



