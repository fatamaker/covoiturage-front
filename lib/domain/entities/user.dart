class User {
  final String? id;
  final String firstName;
  final String lastName;
  final String? imageUrl;
  final String email;
  final String? phone;
  final String password;

  final String? governorate;
  final DateTime? birthDate;

  User({
    this.id,
    required this.firstName,
    required this.lastName,
    this.imageUrl,
    required this.email,
    this.phone,
    required this.password,
    this.governorate,
    this.birthDate,
  });
}
