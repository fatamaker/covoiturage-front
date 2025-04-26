import 'dart:io';

import 'package:covoiturage2/core/erreur/exception/exceptions.dart';
import 'package:covoiturage2/core/erreur/failure/failures.dart';
import 'package:covoiturage2/data/data-source/local_data_source/authentication_local_data_source.dart';
import 'package:covoiturage2/data/data-source/remote_data_source/remote_authentication_data_source.dart';
import 'package:covoiturage2/data/models/token_model.dart';
import 'package:covoiturage2/domain/entities/token.dart';
import 'package:covoiturage2/domain/entities/user.dart';
import 'package:covoiturage2/domain/repository/authentication_repository.dart';
import 'package:dartz/dartz.dart';

class AuthenticationRepositoryImpl implements AuthenticationRepository {
  final AuthenticationRemoteDataSource authenticationRemoteDataSource;
  final AuthenticationLocalDataSource authenticationLocalDataSource;

  AuthenticationRepositoryImpl(
    this.authenticationLocalDataSource,
    this.authenticationRemoteDataSource,
  );

  @override
  Future<Either<Failure, String>> createAccount(
      {required String firstName,
      required String lastName,
      required String imageUrl,
      required String email,
      required String governorate,
      required String phone,
      required DateTime birthDate,
      required String password}) async {
    try {
      final res = await authenticationRemoteDataSource.createAccount(firstName,
          lastName, imageUrl, email, governorate, phone, birthDate, password);
      return Right(res);
    } on RegistrationException catch (e) {
      return Left(RegistrationFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, Token>> login(
      {required String phone, required String password}) async {
    try {
      TokenModel tm =
          await authenticationRemoteDataSource.login(phone, password);
      await authenticationLocalDataSource.saveUserInformations(tm);
      Token t =
          Token(token: tm.token, expiryDate: tm.expiryDate, userId: tm.userId);

      return right(t);
    } on LoginException catch (e) {
      return left(LoginFailure(e.message));
    } on LocalStorageException {
      return left(LocalStorageFailure());
    }
  }

  @override
  Future<Either<Failure, Token?>> autologin() async {
    try {
      final tk = await authenticationRemoteDataSource.autoLogin();
      return right(tk);
    } on NotAuthorizedException {
      return left(NotAuthorizedFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> logout() async {
    try {
      await authenticationLocalDataSource.logout();
      return right(unit);
    } catch (e) {
      return left(LocalStorageFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> resetPassword(
      {required String email, required String password}) async {
    try {
      await authenticationRemoteDataSource.resetPassword(email, password);
      return const Right(unit);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> verifyOTP(
      {required String email, required int otp}) async {
    try {
      await authenticationRemoteDataSource.verifyOTP(email, otp);
      return const Right(unit);
    } on BadOTPException catch (e) {
      return Left(BadOTPFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, Unit>> forgetPassword(
      {required String email, required String destination}) async {
    try {
      await authenticationRemoteDataSource.forgetPassword(
          email: email, destination: destination);
      return const Right(unit);
    } on DataNotFoundException catch (e) {
      return Left(DataNotFoundFailure(e.message));
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, User>> getUserById({required String userId}) async {
    try {
      final res = await authenticationRemoteDataSource.getUserById(userId);
      return right(res);
    } on ServerException catch (_) {
      return left(ServerFailure());
    } on UserNotFoundException catch (_) {
      return left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> updateImage(
      {required String userId, required File image}) async {
    try {
      await authenticationRemoteDataSource.updateImage(userId, image);
      return const Right(unit);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> updatePassword(
      {required String userId,
      required String oldPassword,
      required String newPassword}) async {
    try {
      await authenticationRemoteDataSource.updatePassword(
          userId, oldPassword, newPassword);
      return const Right(unit);
    } on DataNotFoundException catch (e) {
      return Left(DataNotFoundFailure(e.message));
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, Unit>> updateUser(
      {required String id,
      required String firstName,
      required String lastName,
      required String phone,
      required String governorate,
      required DateTime birthDate}) async {
    try {
      await authenticationRemoteDataSource.updateUser(
        id,
        firstName,
        lastName,
        phone,
        governorate,
        birthDate,
      );
      return const Right(unit);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, Unit>> clearUserImage(String userId) async {
    try {
      await authenticationRemoteDataSource.clearUserImage(userId);
      return const Right(unit);
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
