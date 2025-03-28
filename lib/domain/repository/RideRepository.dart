import 'package:covoiturage2/core/erreur/failure/failures.dart';
import 'package:covoiturage2/data/models/ride_model.dart';
import 'package:covoiturage2/domain/entities/ride.dart';
import 'package:dartz/dartz.dart';

abstract class RideRepository {
  // Create a new ride

  Future<Either<Failure, Ride>> createRide(
    String time1,
    String time2,
    String location1,
    String location2,
    String date,
    String driverId,
  );

  // Create or update a ride
  Future<Either<Failure, Ride>> createOrUpdateRide(RideModel ride);

  // Fetch all rides
  Future<Either<Failure, List<Ride>>> getAllRides();

  // Fetch a ride by its ID
  Future<Either<Failure, Ride>> getRideById(String id);

  // Update an existing ride
  Future<Either<Failure, Ride>> updateRide(String id, RideModel ride);

  // Delete a ride
  Future<Either<Failure, Unit>> deleteRide(String id);
}
