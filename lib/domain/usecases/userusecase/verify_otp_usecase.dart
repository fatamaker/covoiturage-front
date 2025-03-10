import 'package:covoiturage2/core/erreur/failure/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:covoiturage2/domain/repository/authentication_repository.dart';

class OTPVerificationUsecase {
  final AuthenticationRepository repository;

  const OTPVerificationUsecase(this.repository);
  Future<Either<Failure, Unit>> call(
          {required String email, required int otp}) async =>
      await repository.verifyOTP(email: email, otp: otp);
}
