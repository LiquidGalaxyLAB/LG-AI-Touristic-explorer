
class CulturalFact {
  final String fact;

  CulturalFact({required this.fact});

  factory CulturalFact.fromJson(Map<String, dynamic> json) {
    return CulturalFact(
      fact: json['fact'],
    );
  }

  @override
  String toString() => 'CulturalFact(fact: $fact)';
}
