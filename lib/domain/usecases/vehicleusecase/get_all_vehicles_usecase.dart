import 'package:covoiturage2/core/erreur/failure/failures.dart';
import 'package:covoiturage2/domain/entities/vehicle.dart';
import 'package:covoiturage2/domain/repository/VehicleRepository.dart';
import 'package:dartz/dartz.dart';

class GetAllVehiclesUsecase {
  final VehicleRepository repository;
  GetAllVehiclesUsecase(this.repository);

  Future<Either<Failure, List<Vehicle>>> call() async {
    return await repository.getAllVehicles();
  }
}
