import 'package:covoiturage2/domain/entities/user.dart';

class UserModel extends User {
  UserModel({
    super.id,
    required super.firstName,
    required super.lastName,
    super.imageUrl,
    required super.email,
    super.phone,
    required super.password,
    required super.governorate,
    super.birthDate,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['_id'],
      firstName: json['firstName'] ?? 'N/A',
      lastName: json['lastName'] ?? 'N/A',
      imageUrl: json['imageUrl'] ?? '',
      email: json['email'] ?? 'unknown@example.com',
      governorate: json['governorate'] ?? '',
      phone: json['phone'] ?? '',
      password: json['password'] ?? '',

      birthDate: json['birthDate'] != null
          ? DateTime.parse(json['birthDate'])
          : DateTime.parse(
              "2020-07-17T03:18:31.177769-04:00"), // Handle null date
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'firstName': firstName.isEmpty ? 'N/A' : firstName,
      'lastName': lastName.isEmpty ? 'N/A' : lastName,
      'imageUrl': imageUrl,
      'email': email.isEmpty ? 'unknown@example.com' : email,
      'governorate': governorate,
      'phone': phone,
      'password': password,
      'birthDate': birthDate?.toIso8601String(),
    };
  }
}
