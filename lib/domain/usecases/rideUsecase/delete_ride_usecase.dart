import 'package:covoiturage2/core/erreur/failure/failures.dart';
import 'package:covoiturage2/domain/repository/RideRepository.dart';
import 'package:dartz/dartz.dart';

class DeleteRideUsecase {
  final RideRepository repository;
  DeleteRideUsecase(this.repository);

  Future<Either<Failure, Unit>> call(String id) async {
    return await repository.deleteRide(id);
  }
}
