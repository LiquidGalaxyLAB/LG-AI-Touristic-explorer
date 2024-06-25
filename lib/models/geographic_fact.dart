class GeographicalFact {
  final String fact;

  GeographicalFact({required this.fact});

  factory GeographicalFact.fromJson(Map<String, dynamic> json) {
    return GeographicalFact(
      fact: json['fact'],
    );
  }
}