import 'package:covoiturage2/core/erreur/exception/exceptions.dart';
import 'package:covoiturage2/core/erreur/failure/failures.dart';

import 'package:covoiturage2/data/data-source/remote_data_source/ride_remote_data_source.dart';
import 'package:covoiturage2/data/models/ride_model.dart';
import 'package:covoiturage2/domain/entities/ride.dart';
import 'package:covoiturage2/domain/repository/RideRepository.dart';

import 'package:dartz/dartz.dart';

class RideRepositoryImpl implements RideRepository {
  final RideRemoteDataSource rideRemoteDataSource;

  RideRepositoryImpl(
    this.rideRemoteDataSource,
  );

  @override
  Future<Either<Failure, Ride>> createRide(String time1, String time2,
      String location1, String location2, String date, String driverId) async {
    try {
      final res = await rideRemoteDataSource.createRide(
          time1, time2, location1, location2, date, driverId);
      return Right(res);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, Ride>> createOrUpdateRide(RideModel ride) async {
    try {
      final res = await rideRemoteDataSource.createOrUpdateRide(ride);
      return Right(res);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, List<Ride>>> getAllRides() async {
    try {
      final res = await rideRemoteDataSource.getAllRides();
      return Right(res);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, Ride>> getRideById(String id) async {
    try {
      final res = await rideRemoteDataSource.getRideById(id);
      return Right(res);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on RideNotFoundException {
      return Left(DataNotFoundFailure("Ride not found"));
    }
  }

  @override
  Future<Either<Failure, Ride>> updateRide(String id, RideModel ride) async {
    try {
      final res = await rideRemoteDataSource.updateRide(id, ride);
      return Right(res);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteRide(String id) async {
    try {
      await rideRemoteDataSource.deleteRide(id);
      return const Right(unit);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }
}
