import 'package:covoiturage2/domain/entities/token.dart';

class TokenModel extends Token {
  TokenModel(
      {required super.token, required super.expiryDate, required super.userId});

  factory TokenModel.fromJson(Map<String, dynamic> json) => TokenModel(
      token: json['token'],
      expiryDate: DateTime.parse(json['tokenExpiration'].toString()),
      userId: json['Uid']);

  Map<String, dynamic> toJson() =>
      {'token': token, 'Uid': userId, 'tokenExpiration': expiryDate.toString()};
}
