class Reservation {
  final String? id;
  final String rideId;
  final String passengerId;
  final String status;

  Reservation({
    this.id,
    required this.rideId,
    required this.passengerId,
    required this.status,
  });
}
