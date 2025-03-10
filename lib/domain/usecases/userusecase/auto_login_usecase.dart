import 'package:covoiturage2/core/erreur/failure/failures.dart';
import 'package:covoiturage2/domain/entities/token.dart';
import 'package:covoiturage2/domain/repository/authentication_repository.dart';
import 'package:dartz/dartz.dart';

class AutoLoginUsecase {
  final AuthenticationRepository repository;
  const AutoLoginUsecase(this.repository);
  Future<Either<Failure, Token?>> call() async => await repository.autologin();
}
