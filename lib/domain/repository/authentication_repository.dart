import 'dart:io';

import 'package:covoiturage2/core/erreur/failure/failures.dart';
import 'package:covoiturage2/domain/entities/token.dart';
import 'package:covoiturage2/domain/entities/user.dart';
import 'package:dartz/dartz.dart';

abstract class AuthenticationRepository {
  Future<Either<Failure, String>> createAccount(
      {required String firstName,
      required String lastName,
      required String imageUrl,
      required String email,
      required String governorate,
      required String phone,
      required DateTime birthDate,
      required String password});

  Future<Either<Failure, Token>> login(
      {required String phone, required String password});

  Future<Either<Failure, Token?>> autologin();
  Future<Either<Failure, Unit>> logout();

  Future<Either<Failure, Unit>> resetPassword(
      {required String email, required String password});
  Future<Either<Failure, Unit>> forgetPassword(
      {required String email, required String destination});
  Future<Either<Failure, Unit>> verifyOTP(
      {required String email, required int otp});

  Future<Either<Failure, Unit>> updateUser({
    required String id,
    required String firstName,
    required String lastName,
    required String phone,
    required String governorate,
    required DateTime birthDate,
  });

  Future<Either<Failure, Unit>> updatePassword({
    required String userId,
    required String oldPassword,
    required String newPassword,
  });

  Future<Either<Failure, Unit>> updateImage({
    required String userId,
    required File image,
  });

  Future<Either<Failure, Unit>> clearUserImage(String userId);

  Future<Either<Failure, User>> getUserById({required String userId});
}
