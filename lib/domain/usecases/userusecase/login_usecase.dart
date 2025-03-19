import 'package:covoiturage2/core/erreur/failure/failures.dart';
import 'package:covoiturage2/domain/entities/token.dart';
import 'package:dartz/dartz.dart';
import 'package:covoiturage2/domain/repository/authentication_repository.dart';

class LoginUsecase {
  final AuthenticationRepository _authenticationRepository;

  const LoginUsecase(this._authenticationRepository);

  Future<Either<Failure, Token>> call(
          {required String phone, required String password}) async =>
      await _authenticationRepository.login(phone: phone, password: password);
}
