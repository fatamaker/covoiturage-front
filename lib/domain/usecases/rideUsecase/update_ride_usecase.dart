import 'package:covoiturage2/core/erreur/failure/failures.dart';
import 'package:covoiturage2/data/models/ride_model.dart';
import 'package:covoiturage2/domain/entities/ride.dart';
import 'package:covoiturage2/domain/repository/RideRepository.dart';
import 'package:dartz/dartz.dart';

class UpdateRideUsecase {
  final RideRepository repository;
  UpdateRideUsecase(this.repository);

  Future<Either<Failure, Ride>> call(String id, RideModel ride) async {
    return await repository.updateRide(id, ride);
  }
}
