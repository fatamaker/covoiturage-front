import 'package:covoiturage2/data/models/reservation_model.dart';
import 'package:covoiturage2/di.dart';
import 'package:covoiturage2/domain/entities/reservation.dart';
import 'package:covoiturage2/domain/usecases/reservationUsecase/create_reservation_usecase.dart';
import 'package:covoiturage2/domain/usecases/reservationUsecase/get_reservations_by_Passenger.dart';
import 'package:covoiturage2/domain/usecases/reservationUsecase/get_reservations_by_driver.dart';
import 'package:covoiturage2/domain/usecases/reservationUsecase/update_reservation_status.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class ReservationController extends GetxController {
  List<Reservation> reservations = [];
  bool isLoading = false;

  final String driverId;

  ReservationController({required this.driverId});

  @override
  void onInit() {
    super.onInit();
    getReservationsByDriver();
  }

  Future<void> getReservationsByDriver() async {
    isLoading = true;
    update();

    final res = await GetReservationsByDriver(sl()).call(driverId);

    res.fold(
      (l) => Fluttertoast.showToast(
        msg: l.message ?? "Failed to load reservations",
        backgroundColor: Colors.red,
        textColor: Colors.white,
      ),
      (r) {
        reservations = r;
        update();
      },
    );

    isLoading = false;
    update();
  }

  Future<void> getReservationsByPassenger() async {
    isLoading = true;
    update();

    final res = await GetReservationsByPassenger(sl()).call(driverId);

    res.fold(
      (l) => Fluttertoast.showToast(
        msg: l.message ?? "Failed to load reservations",
        backgroundColor: Colors.red,
        textColor: Colors.white,
      ),
      (r) {
        reservations = r;
        update();
      },
    );

    isLoading = false;
    update();
  }

  Future<void> updateReservationStatus(
      String reservationId, String status) async {
    final res = await UpdateReservationStatus(sl()).call(
      reservationId: reservationId,
      status: status,
    );
  }

  Future<void> createReservation(String rideId, String userId) async {
    final reservation = ReservationModel(
      rideId: rideId,
      passengerId: userId,
      status: "pending",
    );

    final result = await CreateReservationUseCase(sl()).call(reservation);

    result.fold(
      (failure) => Fluttertoast.showToast(
        msg: failure.message ?? "Failed to reserve ride",
        backgroundColor: Colors.red,
        textColor: Colors.white,
      ),
      (reservation) => Fluttertoast.showToast(
        msg: "Reservation request sent!",
        backgroundColor: Colors.green,
        textColor: Colors.white,
      ),
    );
  }
}
