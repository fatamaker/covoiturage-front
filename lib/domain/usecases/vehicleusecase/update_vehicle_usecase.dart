import 'package:covoiturage2/core/erreur/failure/failures.dart';
import 'package:covoiturage2/data/models/vehicle_model.dart';
import 'package:covoiturage2/domain/entities/vehicle.dart';
import 'package:covoiturage2/domain/repository/VehicleRepository.dart';
import 'package:dartz/dartz.dart';

class UpdateVehicleUsecase {
  final VehicleRepository repository;
  UpdateVehicleUsecase(this.repository);

  Future<Either<Failure, Vehicle>> call(String id, VehicleModel vehicle) async {
    return await repository.updateVehicle(id, vehicle);
  }
}
