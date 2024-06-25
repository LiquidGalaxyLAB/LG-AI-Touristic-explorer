class HistoricalFact {
  final String fact;

  HistoricalFact({required this.fact});

  factory HistoricalFact.fromJson(Map<String, dynamic> json) {
    return HistoricalFact(
      fact: json['fact'],
    );
  }
}