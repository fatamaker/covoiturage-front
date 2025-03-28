import 'package:covoiturage2/core/erreur/failure/failures.dart';
import 'package:covoiturage2/data/models/vehicle_model.dart';
import 'package:covoiturage2/domain/entities/vehicle.dart';
import 'package:dartz/dartz.dart';

abstract class VehicleRepository {
  // Create a new vehicle
  Future<Either<Failure, Vehicle>> createVehicle(
      String model, String couleur, int year, String driverID);

  // Fetch all vehicles
  Future<Either<Failure, List<Vehicle>>> getAllVehicles();

  // Fetch all vehicles belonging to a specific driver
  Future<Either<Failure, List<Vehicle>>> getAllVehiclesByDriver(
      String driverId);

  // Fetch a vehicle by its ID
  Future<Either<Failure, Vehicle>> getVehicleById(String id);

  // Update a vehicle
  Future<Either<Failure, Vehicle>> updateVehicle(
      String id, VehicleModel vehicle);

  // Delete a vehicle
  Future<Either<Failure, Unit>> deleteVehicle(String id);
}
