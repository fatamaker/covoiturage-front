import 'package:covoiturage2/domain/entities/reservation.dart';

class ReservationModel extends Reservation {
  ReservationModel({
    String? id,
    required String rideId,
    required String passengerId,
    required String status,
  }) : super(
          id: id,
          rideId: rideId,
          passengerId: passengerId,
          status: status,
        );

  factory ReservationModel.fromJson(Map<String, dynamic> json) {
    return ReservationModel(
      id: json['_id'],
      rideId: json['rideId'],
      passengerId: json['passengerId'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'rideId': rideId,
      'passengerId': passengerId,
      'status': status,
    };
  }
}
