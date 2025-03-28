import 'package:covoiturage2/data/models/ride_model.dart';
import 'package:covoiturage2/di.dart';
import 'package:covoiturage2/domain/entities/ride.dart';
import 'package:covoiturage2/domain/usecases/rideUsecase/get_all_rides_usecase.dart';
import 'package:covoiturage2/domain/usecases/rideUsecase/get_ridebyId_usecase.dart';
import 'package:covoiturage2/domain/usecases/rideusecase/create_ride_usecase.dart';

import 'package:covoiturage2/domain/usecases/rideusecase/delete_ride_usecase.dart';
import 'package:covoiturage2/domain/usecases/rideusecase/update_ride_usecase.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class RideController extends GetxController {
  List<Ride> rides = [];
  bool isLoading = false;
  RideModel? rideDetails;

  late final String userId;

  RideController({required this.userId});

  int passengerCount = 2;
  String selectedLuggageSize = "Moyen";
  bool cigaretteAccepted = false;
  bool animalsAccepted = false;

  @override
  void onInit() {
    super.onInit();
    update();
  }

  Future<RideModel?> updateRide(String rideId, RideModel ride,
      {String? vehicleId}) async {
    RideModel updatedRide = RideModel(
      id: rideId,
      time1: ride.time1,
      time2: ride.time2,
      location1: ride.location1,
      location2: ride.location2,
      date: ride.date,
      passengerCount: passengerCount,
      luggageSize: selectedLuggageSize,
      smoking: cigaretteAccepted,
      animals: animalsAccepted,
      driverId: ride.driverId,
      vehicleId: vehicleId ?? ride.vehicleId, // Update only if provided
    );

    RideModel? updatedRideResponse;

    try {
      final res = await UpdateRideUsecase(sl()).call(rideId, updatedRide);

      res.fold(
        (l) {
          Fluttertoast.showToast(
            msg: l.message ?? "Failed to update ride",
            backgroundColor: Colors.red,
            textColor: Colors.white,
          );
        },
        (r) {
          int index = rides.indexWhere((element) => element.id == rideId);
          if (index != -1) {
            rides[index] = r;
            update();
          }

          updatedRideResponse = r as RideModel?;

          Fluttertoast.showToast(
            msg: "Ride updated successfully!",
            backgroundColor: Colors.green,
            textColor: Colors.white,
          );
        },
      );
    } catch (e) {
      Fluttertoast.showToast(
        msg: "An unexpected error occurred: $e",
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
    }

    return updatedRideResponse;
  }

  void setPassengerCount(int value) {
    passengerCount = value;
    update();
  }

  void setLuggageSize(String size) {
    selectedLuggageSize = size;
    update();
  }

  void toggleCigarette(bool value) {
    cigaretteAccepted = value;
    update();
  }

  void toggleAnimals(bool value) {
    animalsAccepted = value;
    update();
  }

  Future<RideModel?> createRide({
    required TextEditingController departure,
    required TextEditingController destination,
    required TextEditingController time1,
    required TextEditingController time2,
    required TextEditingController date,
    required BuildContext context,
  }) async {
    isLoading = true;
    update();
    RideModel? ride;

    try {
      final res = await CreateRideUsecase(sl()).call(
        time1: time1.text,
        time2: time2.text,
        location1: departure.text,
        location2: destination.text,
        date: date.text,
        driverId: userId,
      );

      res.fold((l) {
        Fluttertoast.showToast(
          msg: l.message ?? "An error occurred",
          backgroundColor: Colors.red,
          textColor: Colors.white,
        );
      }, (r) {
        ride = r as RideModel?;
        update(); // Update the UI
        Fluttertoast.showToast(
          msg: "Ride created successfully!",
          backgroundColor: Colors.green,
          textColor: Colors.white,
        );
      });
    } catch (e) {
      // Catch any unhandled errors and show a generic error toast
      Fluttertoast.showToast(
        msg: "An unexpected error occurred: $e",
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
    } finally {
      isLoading = false; // Ensure that loading state is stopped
      update(); // Update the UI after the operation is complete
    }

    return ride; // Now return the ride object
  }

  Future<void> getRides() async {
    isLoading = true;
    update();

    final res = await GetAllRidesUsecase(sl()).call();

    res.fold(
      (l) => Fluttertoast.showToast(
        msg: l.message ?? "Failed to load rides",
        backgroundColor: Colors.red,
        textColor: Colors.white,
      ),
      (r) {
        rides = r;
        update();
      },
    );
    isLoading = false;
    update();
  }

  Future<void> getRideById(String rideId) async {
    isLoading = true;

    final res = await GetRideByIdUsecase(sl()).call(rideId);

    res.fold(
      (l) {
        Fluttertoast.showToast(
          msg: l.message ?? "Failed to fetch ride",
          backgroundColor: Colors.red,
          textColor: Colors.white,
        );
      },
      (r) {
        rideDetails = r as RideModel?;
        print("📜RIDE DETAILES: ${rideDetails}");
        Future.delayed(Duration(milliseconds: 100), () {
          update();
        });
      },
    );

    Future.delayed(Duration(milliseconds: 100), () {
      isLoading = false;
      update();
    });
  }

  Future<void> deleteRide(String rideId) async {
    final res = await DeleteRideUsecase(sl()).call(rideId);

    res.fold(
      (l) => Fluttertoast.showToast(
        msg: l.message ?? "Failed to delete ride",
        backgroundColor: Colors.red,
        textColor: Colors.white,
      ),
      (r) {
        rides.removeWhere((ride) => ride.id == rideId);
        update();
        Fluttertoast.showToast(
          msg: "Ride deleted successfully!",
          backgroundColor: Colors.green,
          textColor: Colors.white,
        );
      },
    );
  }
}
