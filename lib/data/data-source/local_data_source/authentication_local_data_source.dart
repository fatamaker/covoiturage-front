// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:covoiturage2/core/erreur/exception/exceptions.dart';
import 'package:covoiturage2/core/utils/string_const.dart';
import 'package:covoiturage2/data/models/token_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class AuthenticationLocalDataSource {
  Future<void> saveUserInformations(TokenModel token);
  Future<TokenModel?> getUserInformations();
  Future<void> logout();
}

class AuthenticationLocalDataSourceImpl
    implements AuthenticationLocalDataSource {
  @override
  Future<void> saveUserInformations(TokenModel token) async {
    try {
      final sp = await SharedPreferences.getInstance();
      sp.setString(StringConst.SP_TOKEN_KEY, json.encode(token.toJson()));
    } catch (e) {
      throw LocalStorageException();
    }
  }

  @override
  Future<TokenModel?> getUserInformations() async {
    try {
      final sp = await SharedPreferences.getInstance();
      print(sp.getString("access"));
      if (sp.getString(StringConst.SP_TOKEN_KEY) == '' ||
          sp.getString(StringConst.SP_TOKEN_KEY) == null) {
        return null;
      }
      final data = sp.getString(StringConst.SP_TOKEN_KEY);
      TokenModel token = TokenModel.fromJson(json.decode(data.toString()));
      return token;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> logout() async {
    try {
      final sp = await SharedPreferences.getInstance();
      sp.setString(StringConst.SP_TOKEN_KEY, '');
      print("logout");
      print(sp.getString("access"));
    } catch (e) {
      throw LocalStorageException();
    }
  }
}
