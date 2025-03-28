import 'package:covoiturage2/core/erreur/failure/failures.dart';
import 'package:covoiturage2/data/data-source/remote_data_source/vehicle_remote_data_source.dart';

import 'package:covoiturage2/data/models/vehicle_model.dart';
import 'package:covoiturage2/domain/entities/vehicle.dart';
import 'package:covoiturage2/domain/repository/VehicleRepository.dart';

import 'package:dartz/dartz.dart';

class VehicleRepositoryImpl implements VehicleRepository {
  final VehicleRemoteDataSource vehicleRemoteDataSource;

  VehicleRepositoryImpl(this.vehicleRemoteDataSource);

  @override
  Future<Either<Failure, Vehicle>> createVehicle(
      String model, String couleur, int year, String driverID) async {
    try {
      final newVehicle = await vehicleRemoteDataSource.createVehicle(
          model, couleur, year, driverID);
      return Right(newVehicle);
    } catch (e) {
      return Left(
          ServerFailure(message: "Failed to create vehicle: ${e.toString()}"));
    }
  }

  @override
  Future<Either<Failure, List<Vehicle>>> getAllVehicles() async {
    try {
      final vehicles = await vehicleRemoteDataSource.getAllVehicles();
      return Right(vehicles);
    } catch (e) {
      return Left(
          ServerFailure(message: "Failed to fetch vehicles: ${e.toString()}"));
    }
  }

  @override
  Future<Either<Failure, List<Vehicle>>> getAllVehiclesByDriver(
      String driverId) async {
    try {
      final vehicles =
          await vehicleRemoteDataSource.getVehiclesByDriver(driverId);
      return Right(vehicles);
    } catch (e) {
      return Left(ServerFailure(
          message: "Failed to fetch vehicles for driver: ${e.toString()}"));
    }
  }

  @override
  Future<Either<Failure, Vehicle>> getVehicleById(String id) async {
    try {
      final vehicle = await vehicleRemoteDataSource.getVehicleById(id);
      return Right(vehicle);
    } catch (e) {
      return Left(
          ServerFailure(message: "Failed to fetch vehicle: ${e.toString()}"));
    }
  }

  @override
  Future<Either<Failure, Vehicle>> updateVehicle(
      String id, VehicleModel vehicle) async {
    try {
      final updatedVehicle =
          await vehicleRemoteDataSource.updateVehicle(id, vehicle);
      return Right(updatedVehicle);
    } catch (e) {
      return Left(
          ServerFailure(message: "Failed to update vehicle: ${e.toString()}"));
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteVehicle(String id) async {
    try {
      await vehicleRemoteDataSource.deleteVehicle(id);
      return const Right(unit);
    } catch (e) {
      return Left(
          ServerFailure(message: "Failed to delete vehicle: ${e.toString()}"));
    }
  }
}
