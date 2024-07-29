import 'package:lg_ai_touristic_explorer/constants/images.dart';

class Place {
  final String name;
  final String details;
  final double latitude;
  final double longitude;
  final String imageUrl; // New field

  Place({
    required this.name,
    required this.details,
    required this.latitude,
    required this.longitude,
    required this.imageUrl, // New field
  });

  factory Place.fromJson(Map<String, dynamic> json) {
    return Place(
      name: json['name'],
      details: json['details'],
      latitude: json['coordinates']['latitude'],
      longitude: json['coordinates']['longitude'],
      imageUrl: json['imageUrl'] ?? mainLogoAWS, // New field
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'details': details,
      'coordinates': {
        'latitude': latitude,
        'longitude': longitude,
      },
      'imageUrl': imageUrl, // New field
    };
  }
}
