import 'package:covoiturage2/core/erreur/failure/failures.dart';
import 'package:dartz/dartz.dart';

import 'package:covoiturage2/domain/repository/authentication_repository.dart';

class CreateAccountUsecase {
  final AuthenticationRepository _authenticationRepository;

  const CreateAccountUsecase(this._authenticationRepository);

  Future<Either<Failure, String>> call(
          {required String firstName,
          required String lastName,
          required String imageUrl,
          required String email,
          required String governorate,
          required String phone,
          required DateTime birthDate,
          required String password}) async =>
      await _authenticationRepository.createAccount(
          firstName: firstName,
          lastName: lastName,
          imageUrl: imageUrl,
          email: email,
          governorate: governorate,
          phone: phone,
          birthDate: birthDate,
          password: password);
}
