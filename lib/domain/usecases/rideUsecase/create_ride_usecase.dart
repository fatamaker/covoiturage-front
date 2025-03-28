import 'package:covoiturage2/core/erreur/failure/failures.dart';
import 'package:covoiturage2/data/models/ride_model.dart';
import 'package:covoiturage2/domain/entities/ride.dart';
import 'package:covoiturage2/domain/repository/RideRepository.dart';
import 'package:dartz/dartz.dart';

class CreateRideUsecase {
  final RideRepository repository;
  CreateRideUsecase(this.repository);

  Future<Either<Failure, Ride>> call({
    required String time1,
    required String time2,
    required String location1,
    required String location2,
    required String date,
    required driverId,
  }) async {
    return await repository.createRide(
      time1,
      time2,
      location1,
      location2,
      date,
      driverId,
    );
  }
}
