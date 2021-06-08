class User {
  final bool isPromoter;
  final String id;
  final String name;
  final String surname;
  final String email;
  final String phone;
  final String gender;
  final DateTime birthDate;
  final String token;

  User({required this.isPromoter,
    required this.id,
    required this.name,
    required this.surname,
    required this.email,
    required this.phone,
    required this.gender,
    required this.birthDate,
    required this.token,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      isPromoter: json['user']['isPromoter'] as bool,
      id: json['user']['_id'] as String,
      name: json['user']['name'] as String,
      surname: json['user']['surname'] as String,
      email: json['user']['email'] as String,
      phone: json['user']['phone'] as String,
      gender: json['user']['gender'] as String,
      birthDate: DateTime.parse(json['user']['birthDate']),
      token: json['user']['birthDate'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
    'user': {
      "isPromoter": isPromoter.toString(),
      "_id": id,
      "name": name,
      "surname": surname,
      "email": email,
      "phone": phone,
      "gender": gender,
      "birthDate": birthDate.toIso8601String(),
    },
    'token': token,
  };

  @override
  String toString() {
    return 'User{isPromoter: $isPromoter, id: $id, name: $name, surname: $surname, email: $email, phone: $phone, gender: $gender, birthDate: $birthDate, token: $token}';
  }
}
