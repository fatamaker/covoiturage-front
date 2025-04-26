// ignore_for_file: avoid_print, unused_local_variable

import 'dart:convert';
import 'dart:io';

import 'package:covoiturage2/core/erreur/exception/exceptions.dart';
import 'package:covoiturage2/core/utils/api_const.dart';
import 'package:covoiturage2/data/data-source/local_data_source/authentication_local_data_source.dart';
import 'package:covoiturage2/data/models/token_model.dart';
import 'package:covoiturage2/data/models/user_model.dart';
import 'package:covoiturage2/domain/entities/user.dart';
import 'package:http/http.dart' as http;

import 'package:http_parser/http_parser.dart';

abstract class AuthenticationRemoteDataSource {
  Future<String> createAccount(
    String firstName,
    String lastName,
    String imageUrl,
    String email,
    String governorate,
    String phone,
    DateTime birthDate,
    String password,
  );
  Future<TokenModel> login(String email, String password);
  Future<TokenModel?> autoLogin();

  Future<void> forgetPassword(
      {required String email, required String destination});
  Future<void> verifyOTP(String email, int otp);
  Future<void> resetPassword(String email, String password);
  Future<void> updateUser(
    String id,
    String firstName,
    String lastName,
    String phone,
    String governorate,
    DateTime birthDate,
  );

  Future<void> updateImage(String userId, File image);

  Future<void> updatePassword(
      String userId, String oldPassword, String newPassword);

  Future<User> getUserById(String userId);
  Future<void> clearUserImage(String userId);
}

class AuthenticationRemoteDataSourceImpl
    implements AuthenticationRemoteDataSource {
  Future<TokenModel?> get token async {
    return await AuthenticationLocalDataSourceImpl().getUserInformations();
  }

  @override
  Future<String> createAccount(
      String firstName,
      String lastName,
      String imageUrl,
      String email,
      String governorate,
      String phone,
      DateTime birthDate,
      String password) async {
    try {
      // Create the user model
      UserModel userModel = UserModel(
          firstName: firstName,
          lastName: lastName,
          imageUrl: "",
          email: email,
          governorate: governorate,
          phone: phone,
          birthDate: birthDate,
          password: password);
      Map<String, dynamic> requestData = userModel.toJson();
      // Parse the URL
      final url = Uri.parse(APIConst.register);

      // Make the POST request
      final response = await http.post(url, body: userModel.toJson());

      if (response.statusCode == 201) {
        final responseData = jsonDecode(response.body);
        return responseData["uId"];
      } else if (response.statusCode == 403) {
        throw RegistrationException("User already exists");
      } else {
        throw ServerException(
            message: "Unexpected error occurred: ${response.body}");
      }
    } catch (e) {
      // Re-throw the caught error for further handling
      print("Error: $e");
      rethrow;
    }
  }

  @override
  Future<TokenModel> login(String phone, String password) async {
    String msg = "";
    try {
      Map<String, dynamic> user = {'phone': phone, 'password': password};
      final url = Uri.parse(APIConst.login);
      final res = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(user),
      );
      print(res.body);
      if (res.statusCode == 200) {
        final data = jsonDecode(res.body);
        final TokenModel token = TokenModel.fromJson(data);
        print(token);
        return token;
      } else {
        switch (res.statusCode) {
          case 202:
            msg = "wrong password";
            break;
          case 404:
            msg = "Phone number not registred";

            break;
          default:
        }
        throw LoginException(msg);
      }
    } catch (e) {
      print(e.toString());
      rethrow;
    }
  }

  @override
  Future<TokenModel?> autoLogin() async {
    try {
      return await token;
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  // @override
  // Future<void> forgetPassword({
  //   required String email,
  //   required String destination,
  // }) async {
  //   try {
  //     final response = await http.post(
  //       Uri.parse(APIConst.forgetPassword),
  //       body: jsonEncode({"email": email, "destination": destination}),
  //       headers: {"Content-Type": "application/json"},
  //     );

  //     if (response.statusCode == 404) {
  //       throw DataNotFoundException("email not registred");
  //     } else if (response.statusCode == 500) {
  //       throw ServerException(message: "server error");
  //     }
  //   } catch (e) {
  //     rethrow;
  //   }
  // }

  @override
  Future<void> forgetPassword({
    required String email,
    required String destination,
  }) async {
    try {
      final url = Uri.parse(APIConst.forgetPassword);
      print("Sending request to: $url");

      final response = await http.post(
        url,
        body: jsonEncode({"email": email, "destination": destination}),
        headers: {"Content-Type": "application/json"},
      );

      print("Response Status Code: ${response.statusCode}");
      print("Response Body: ${response.body}");

      if (response.statusCode == 404) {
        throw DataNotFoundException("Email not registered");
      } else if (response.statusCode == 500) {
        throw ServerException(message: "Server error: ${response.body}");
      }
    } catch (e) {
      print("Exception caught: $e");
      rethrow;
    }
  }

  @override
  Future<void> resetPassword(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse(APIConst.resetPassword),
        body: jsonEncode({"email": email, "password": password}),
        headers: {"Content-Type": "application/json"},
      );

      if (response.statusCode == 404) {
        throw DataNotFoundException("email not registred");
      } else if (response.statusCode == 500) {
        throw ServerException(message: "error");
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> verifyOTP(String email, int otp) async {
    try {
      final response = await http.post(
        Uri.parse(APIConst.verfifCode),
        body: jsonEncode({"email": email, "otp": otp}),
        headers: {"Content-Type": "application/json"},
      );

      if (response.statusCode == 404) {
        throw BadOTPException("code invalid");
      } else if (response.statusCode == 400) {
        throw BadOTPException("expired code");
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<User> getUserById(String userId) async {
    try {
      final uri = Uri.parse('${APIConst.userProfile}/$userId');
      final res = await http.get(uri);
      if (res.statusCode == 200) {
        final body = json.decode(res.body)["user"];

        return UserModel.fromJson(body);
      } else if (res.statusCode == 404) {
        throw UserNotFoundException();
      } else {
        throw ServerException();
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> updateImage(String userID, File file) async {
    try {
      print('File path: ${file.path}');
      final url = Uri.parse(APIConst.updateUserImage);
      // Create a multipart request
      var request = http.MultipartRequest('POST', url);
      // Add fields
      request.fields['id'] = userID;
      // Add the file
      var fileName = file.path.split('/').last;
      request.files.add(
        await http.MultipartFile.fromPath(
          'file', // This should match the field name expected by the server
          file.path,
          contentType: MediaType('image', 'jpeg'),
        ),
      );
      // Send the request
      var response = await request.send();
    } catch (e) {
      throw ServerException(message: 'cannot update image');
    }
  }

  @override
  Future<void> clearUserImage(String userId) async {
    try {
      Map<String, dynamic> model = {'id': userId, 'image': ''};
      await http.put(
        Uri.parse('${APIConst.updateProfile}/$userId'),
        body: model,
        headers: {
          "authorization":
              "Bearer ${await token.then((value) => value!.token)}",
        },
      );
    } catch (e) {
      throw ServerException(message: 'cannot update profile');
    }
  }

  @override
  Future<void> updatePassword(
      String userId, String oldPassword, String newPassword) async {
    try {
      Map<String, dynamic> requestData = {
        'id': userId,
        'oldPassword': oldPassword,
        'newPassword': newPassword
      };

      String authToken = await token.then((value) => value!.token);

      final url = Uri.parse(APIConst.updatePassword);
      final res = await http.put(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $authToken',
        },
        body: jsonEncode(requestData),
      );
      if (res.statusCode == 202) {
        throw DataNotFoundException("t.wrong_password");
      } else if (res.statusCode == 500) {
        throw ServerException(message: "server error");
      } else if (res.statusCode != 200) {
        throw Exception('Unexpected error: ${res.statusCode}');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateUser(
    String id,
    String firstName,
    String lastName,
    String phone,
    String governorate,
    DateTime birthDate,
  ) async {
    try {
      // 1. Préparer les données de la requête
      final userModel = {
        'firstName': firstName,
        'lastName': lastName,
        'phone': phone,
        'governorate': governorate,
        'birthDate': birthDate.toUtc().toIso8601String(),
      };

      // 2. Récupérer le token d'authentification
      final authToken = await token.then((value) => value?.token);
      if (authToken == null)
        throw ServerException(message: 'Not authenticated');

      // 3. Effectuer la requête PUT
      final response = await http.put(
        Uri.parse('${APIConst.updateProfile}/$id'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $authToken',
        },
        body: jsonEncode(userModel),
      );

      // 4. Vérifier la réponse du serveur

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);

        // Vérifier si la mise à jour a bien été appliquée
        if (responseData['user']['governorate'] != governorate) {
          throw ServerException(message: 'Governorate update not confirmed');
        }

        return;
      }

      // 5. Gestion des erreurs
      final errorResponse = jsonDecode(response.body);
      throw ServerException(
        message: errorResponse['message'] ?? 'Failed to update profile',
      );
    } on SocketException {
      throw ServerException(message: 'No internet connection');
    } on FormatException {
      throw ServerException(message: 'Invalid server response');
    } catch (e) {
      throw ServerException(message: 'Update failed: ${e.toString()}');
    }
  }
}
