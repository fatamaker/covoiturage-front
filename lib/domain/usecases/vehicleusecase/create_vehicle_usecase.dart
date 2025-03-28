import 'package:covoiturage2/core/erreur/failure/failures.dart';
import 'package:covoiturage2/data/models/vehicle_model.dart';
import 'package:covoiturage2/domain/entities/vehicle.dart';
import 'package:covoiturage2/domain/repository/VehicleRepository.dart';
import 'package:dartz/dartz.dart';

class CreateVehicleUsecase {
  final VehicleRepository repository;
  CreateVehicleUsecase(this.repository);

  Future<Either<Failure, Vehicle>> call(
      {required String model,
      required couleur,
      required int year,
      required String driverID}) async {
    return await repository.createVehicle(
      model,
      couleur,
      year,
      driverID,
    );
  }
}
