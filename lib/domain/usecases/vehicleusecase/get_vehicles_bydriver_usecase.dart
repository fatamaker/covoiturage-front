import 'package:covoiturage2/core/erreur/failure/failures.dart';
import 'package:covoiturage2/domain/entities/vehicle.dart';
import 'package:covoiturage2/domain/repository/VehicleRepository.dart';
import 'package:dartz/dartz.dart';

class GetVehiclesByDriverUsecase {
  final VehicleRepository repository;
  GetVehiclesByDriverUsecase(this.repository);

  Future<Either<Failure, List<Vehicle>>> call(String driverID) async {
    return await repository.getAllVehiclesByDriver(driverID);
  }
}
