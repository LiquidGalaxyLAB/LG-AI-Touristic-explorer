class Place {
  final String name;
  final String details;
  final double latitude;
  final double longitude;

  Place({
    required this.name,
    required this.details,
    required this.latitude,
    required this.longitude,
  });

  factory Place.fromJson(Map<String, dynamic> json) {
    return Place(
      name: json['name'],
      details: json['details'],
      latitude: json['coordinates']['latitude'],
      longitude: json['coordinates']['longitude'],
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
    };
  }
}
