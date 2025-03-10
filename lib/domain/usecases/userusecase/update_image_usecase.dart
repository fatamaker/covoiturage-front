import 'dart:io';

import 'package:covoiturage2/core/erreur/failure/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:covoiturage2/domain/repository/authentication_repository.dart';

class UpdateImageUsecase {
  final AuthenticationRepository _authenticationRepository;

  const UpdateImageUsecase(this._authenticationRepository);

  Future<Either<Failure, Unit>> call({
    required String userId,
    required File image,
  }) async =>
      await _authenticationRepository.updateImage(userId: userId, image: image);
}
