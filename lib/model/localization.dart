class Localization {
  final String street;
  final String city;
  final String CEP;
  final int number;

  Localization({required this.street, required this.city, required this.CEP, required this.number});

  factory Localization.fromJson(Map<String, dynamic> json) {
    return Localization(
      street: json['street'] as String,
      city: json['city'] as String,
      CEP: json['CEP'] as String,
      number: json['number'] as int,
    );
  }

  @override
  String toString() {
    return 'Localization{street: $street, city: $city, CEP: $CEP, number: $number}';
  }
}