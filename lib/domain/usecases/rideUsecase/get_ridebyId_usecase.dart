import 'package:covoiturage2/core/erreur/failure/failures.dart';
import 'package:covoiturage2/domain/entities/ride.dart';
import 'package:covoiturage2/domain/repository/RideRepository.dart';
import 'package:dartz/dartz.dart';

class GetRideByIdUsecase {
  final RideRepository repository;
  GetRideByIdUsecase(this.repository);

  Future<Either<Failure, Ride>> call(String id) async {
    return await repository.getRideById(id);
  }
}
