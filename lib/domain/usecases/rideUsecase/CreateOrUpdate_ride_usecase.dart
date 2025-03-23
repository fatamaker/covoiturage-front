import 'package:covoiturage2/core/erreur/failure/failures.dart';
import 'package:covoiturage2/data/models/ride_model.dart';
import 'package:covoiturage2/domain/entities/ride.dart';
import 'package:covoiturage2/domain/repository/RideRepository.dart';
import 'package:dartz/dartz.dart';

class CreateOrUpdateRideUsecase {
  final RideRepository repository;
  CreateOrUpdateRideUsecase(this.repository);

  Future<Either<Failure, Ride>> call(RideModel ride) async {
    return await repository.createOrUpdateRide(ride);
  }
}
