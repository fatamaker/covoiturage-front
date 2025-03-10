import 'package:covoiturage2/core/erreur/failure/failures.dart';
import 'package:dartz/dartz.dart';

import 'package:covoiturage2/domain/repository/authentication_repository.dart';

class ClearUserImageUsecase {
  final AuthenticationRepository repository;
  ClearUserImageUsecase(this.repository);
  Future<Either<Failure, Unit>> call(String userId) async =>
      await repository.clearUserImage(userId);
}
