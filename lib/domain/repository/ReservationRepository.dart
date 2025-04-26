import 'package:covoiturage2/core/erreur/failure/failures.dart';
import 'package:covoiturage2/data/models/reservation_model.dart';
import 'package:covoiturage2/domain/entities/reservation.dart';
import 'package:dartz/dartz.dart';

abstract class ReservationRepository {
  Future<Either<Failure, ReservationModel>> createReservation(
      ReservationModel reservation);
  Future<Either<Failure, List<Reservation>>> getReservationsByDriver(
      String driverId);
  Future<Either<Failure, List<Reservation>>> getReservationsByPassenger(
      String driverId);

  Future<Either<Failure, void>> updateReservationStatus(
      String reservationId, String status);
}
