import 'package:covoiturage2/core/erreur/failure/failures.dart';
import 'package:covoiturage2/domain/entities/ride.dart';
import 'package:covoiturage2/domain/repository/RideRepository.dart';
import 'package:dartz/dartz.dart';

class GetAllRidesUsecase {
  final RideRepository repository;
  GetAllRidesUsecase(this.repository);

  Future<Either<Failure, List<Ride>>> call() async {
    return await repository.getAllRides();
  }
}
