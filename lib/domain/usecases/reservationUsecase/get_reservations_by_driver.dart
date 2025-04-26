import 'package:covoiturage2/core/erreur/failure/failures.dart';
import 'package:covoiturage2/domain/entities/reservation.dart';

import 'package:covoiturage2/domain/repository/ReservationRepository.dart';
import 'package:dartz/dartz.dart';

class GetReservationsByDriver {
  final ReservationRepository repository;

  GetReservationsByDriver(this.repository);

  Future<Either<Failure, List<Reservation>>> call(String driverId) {
    return repository.getReservationsByDriver(driverId);
  }
}
