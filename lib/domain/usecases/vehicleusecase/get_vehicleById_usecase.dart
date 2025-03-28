import 'package:covoiturage2/core/erreur/failure/failures.dart';
import 'package:covoiturage2/domain/entities/vehicle.dart';
import 'package:covoiturage2/domain/repository/VehicleRepository.dart';
import 'package:dartz/dartz.dart';

class GetVehicleByIdUsecase {
  final VehicleRepository repository;
  GetVehicleByIdUsecase(this.repository);

  Future<Either<Failure, Vehicle>> call(String id) async {
    return await repository.getVehicleById(id);
  }
}
