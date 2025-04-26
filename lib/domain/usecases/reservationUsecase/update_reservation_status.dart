import 'package:covoiturage2/domain/repository/ReservationRepository.dart';

class UpdateReservationStatus {
  final ReservationRepository repository;

  UpdateReservationStatus(this.repository);

  Future<void> call({required String reservationId, required String status}) {
    return repository.updateReservationStatus(reservationId, status);
  }
}
