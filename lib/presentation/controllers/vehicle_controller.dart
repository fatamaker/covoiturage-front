import 'package:covoiturage2/data/models/vehicle_model.dart';
import 'package:covoiturage2/di.dart';
import 'package:covoiturage2/domain/entities/vehicle.dart';
import 'package:covoiturage2/domain/usecases/vehicleUsecase/create_vehicle_usecase.dart';
import 'package:covoiturage2/domain/usecases/vehicleUsecase/get_all_vehicles_usecase.dart';

import 'package:covoiturage2/domain/usecases/vehicleUsecase/update_vehicle_usecase.dart';
import 'package:covoiturage2/domain/usecases/vehicleUsecase/delete_vehicle_usecase.dart';
import 'package:covoiturage2/domain/usecases/vehicleusecase/get_vehicleById_usecase.dart';
import 'package:covoiturage2/domain/usecases/vehicleusecase/get_vehicles_bydriver_usecase.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class VehicleController extends GetxController {
  List<Vehicle> vehicles = [];
  bool isLoading = false;

  late final String userId;

  VehicleController({required this.userId});

  @override
  void onInit() {
    super.onInit();
    update();
  }

  // Create a new vehicle
  Future<VehicleModel?> createVehicle({
    required TextEditingController model,
    required TextEditingController couleur,
    required TextEditingController year,
  }) async {
    isLoading = true;
    update();
    VehicleModel? vehicle;

    try {
      final res = await CreateVehicleUsecase(sl()).call(
        model: model.text,
        couleur: couleur.text,
        year: int.parse(year.text),
        driverID: userId,
      );

      res.fold((l) {
        Fluttertoast.showToast(
          msg: l.message ?? "An error occurred",
          backgroundColor: Colors.red,
          textColor: Colors.white,
        );
      }, (r) {
        vehicle = r as VehicleModel?;
        update(); // Update UI
        Fluttertoast.showToast(
          msg: "Vehicle added successfully!",
          backgroundColor: Colors.green,
          textColor: Colors.white,
        );
      });
    } catch (e) {
      Fluttertoast.showToast(
        msg: "An unexpected error occurred: $e",
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
    } finally {
      isLoading = false;
      update();
    }

    return vehicle;
  }

  // Fetch all vehicles
  Future<void> getVehicles() async {
    isLoading = true;
    update();

    final res = await GetAllVehiclesUsecase(sl()).call();

    res.fold(
      (l) => Fluttertoast.showToast(
        msg: l.message ?? "Failed to load vehicles",
        backgroundColor: Colors.red,
        textColor: Colors.white,
      ),
      (r) {
        vehicles = r;
        update();
      },
    );
    isLoading = false;
    update();
  }

  // Fetch a vehicle by ID
  Future<VehicleModel?> getVehicleById(String vehicleId) async {
    isLoading = true;
    update();

    VehicleModel? vehicle;
    final res = await GetVehicleByIdUsecase(sl()).call(vehicleId);

    res.fold(
      (l) => Fluttertoast.showToast(
        msg: l.message ?? "Failed to fetch vehicle",
        backgroundColor: Colors.red,
        textColor: Colors.white,
      ),
      (r) {
        vehicle = r as VehicleModel?;
        update();
      },
    );

    isLoading = false;
    update();
    return vehicle;
  }

  // Fetch vehicles by driver ID
  Future<void> getVehiclesByDriver() async {
    isLoading = true;
    update();

    final res = await GetVehiclesByDriverUsecase(sl()).call(userId);

    res.fold(
      (l) => Fluttertoast.showToast(
        msg: l.message ?? "Failed to load vehicles for driver",
        backgroundColor: Colors.red,
        textColor: Colors.white,
      ),
      (r) {
        vehicles = r;
        update();
      },
    );

    isLoading = false;
    update();
  }

  // Update a vehicle
  Future<VehicleModel?> updateVehicle(
      String vehicleId, VehicleModel vehicle) async {
    VehicleModel updatedVehicle = VehicleModel(
      id: vehicleId,
      model: vehicle.model,
      couleur: vehicle.couleur,
      year: vehicle.year,
      driverID: vehicle.driverID,
    );

    VehicleModel? updatedVehicleResponse;

    try {
      final res =
          await UpdateVehicleUsecase(sl()).call(vehicleId, updatedVehicle);

      res.fold(
        (l) {
          Fluttertoast.showToast(
            msg: l.message ?? "Failed to update vehicle",
            backgroundColor: Colors.red,
            textColor: Colors.white,
          );
        },
        (r) {
          int index = vehicles.indexWhere((element) => element.id == vehicleId);
          if (index != -1) {
            vehicles[index] = r;
            update();
          }

          updatedVehicleResponse = r as VehicleModel?;

          Fluttertoast.showToast(
            msg: "Vehicle updated successfully!",
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

    return updatedVehicleResponse;
  }

  // Delete a vehicle
  Future<void> deleteVehicle(String vehicleId) async {
    final res = await DeleteVehicleUsecase(sl()).call(vehicleId);

    res.fold(
      (l) => Fluttertoast.showToast(
        msg: l.message ?? "Failed to delete vehicle",
        backgroundColor: Colors.red,
        textColor: Colors.white,
      ),
      (r) {
        vehicles.removeWhere((vehicle) => vehicle.id == vehicleId);
        update();
        Fluttertoast.showToast(
          msg: "Vehicle deleted successfully!",
          backgroundColor: Colors.green,
          textColor: Colors.white,
        );
      },
    );
  }
}
