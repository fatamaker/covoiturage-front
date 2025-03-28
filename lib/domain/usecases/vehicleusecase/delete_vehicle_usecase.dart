import 'package:covoiturage2/core/erreur/failure/failures.dart';
import 'package:covoiturage2/domain/repository/VehicleRepository.dart';
import 'package:dartz/dartz.dart';

class DeleteVehicleUsecase {
  final VehicleRepository repository;
  DeleteVehicleUsecase(this.repository);

  Future<Either<Failure, Unit>> call(String id) async {
    return await repository.deleteVehicle(id);
  }
}
