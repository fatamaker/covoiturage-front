import 'package:covoiturage2/core/erreur/failure/failures.dart';
import 'package:covoiturage2/data/models/reservation_model.dart';
import 'package:covoiturage2/domain/entities/reservation.dart';
import 'package:covoiturage2/domain/repository/ReservationRepository.dart';

import 'package:dartz/dartz.dart';

class CreateReservationUseCase {
  final ReservationRepository repository;

  CreateReservationUseCase(this.repository);

  Future<Either<Failure, ReservationModel>> call(ReservationModel reservation) {
    return repository.createReservation(reservation);
  }
}
