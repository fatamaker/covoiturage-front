import 'package:covoiturage2/core/erreur/failure/failures.dart';
import 'package:covoiturage2/data/data-source/remote_data_source/reservation_remote_data_source.dart';
import 'package:covoiturage2/data/models/reservation_model.dart';
import 'package:covoiturage2/domain/entities/reservation.dart';
import 'package:covoiturage2/domain/repository/ReservationRepository.dart';

import 'package:dartz/dartz.dart';

class ReservationRepositoryImpl implements ReservationRepository {
  final ReservationRemoteDataSource remoteDataSource;

  ReservationRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, ReservationModel>> createReservation(
      ReservationModel reservation) async {
    try {
      final result = await remoteDataSource.createReservation(reservation);
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Reservation>>> getReservationsByDriver(
      String driverId) async {
    try {
      final result = await remoteDataSource.getReservationsByDriver(driverId);
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Reservation>>> getReservationsByPassenger(
      String driverId) async {
    try {
      final result =
          await remoteDataSource.getReservationsByPassenger(driverId);
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> updateReservationStatus(
      String reservationId, String status) async {
    try {
      await remoteDataSource.updateReservationStatus(reservationId, status);
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
