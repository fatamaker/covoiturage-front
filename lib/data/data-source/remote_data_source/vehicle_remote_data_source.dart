import 'dart:convert';
import 'package:covoiturage2/core/utils/api_const.dart';
import 'package:covoiturage2/data/models/vehicle_model.dart';
import 'package:http/http.dart' as http;

abstract class VehicleRemoteDataSource {
  Future<VehicleModel> createVehicle(
      String model, String couleur, int year, String driverID);
  Future<List<VehicleModel>> getAllVehicles();
  Future<List<VehicleModel>> getVehiclesByDriver(String driverID);
  Future<VehicleModel> updateVehicle(String id, VehicleModel vehicle);
  Future<void> deleteVehicle(String id);
  Future<VehicleModel> getVehicleById(String id);
}

class VehicleRemoteDataSourceImpl implements VehicleRemoteDataSource {
  @override
  Future<VehicleModel> createVehicle(
      String model, String couleur, int year, String driverID) async {
    final Map<String, dynamic> vehicle = {
      'model': model,
      'couleur': couleur,
      'year': year,
      'driverID': driverID,
    };

    final response = await http.post(
      Uri.parse(APIConst.Vehicle),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(vehicle),
    );

    if (response.statusCode == 201) {
      return VehicleModel.fromJson(jsonDecode(response.body)['vehicle']);
    } else {
      throw Exception("Failed to create vehicle");
    }
  }

  @override
  Future<List<VehicleModel>> getAllVehicles() async {
    final response = await http.get(Uri.parse(APIConst.Vehicle));

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body)['vehicles'];
      return data.map((json) => VehicleModel.fromJson(json)).toList();
    } else {
      throw Exception("Failed to fetch vehicles");
    }
  }

  @override
  Future<List<VehicleModel>> getVehiclesByDriver(String driverID) async {
    final response = await http.get(Uri.parse('${APIConst.Vehicle}/$driverID'));

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body)['vehicles'];
      return data.map((json) => VehicleModel.fromJson(json)).toList();
    } else {
      throw Exception("Failed to fetch vehicles by driver");
    }
  }

  @override
  Future<VehicleModel> getVehicleById(String id) async {
    final response = await http.get(Uri.parse('${APIConst.Vehicle}/$id'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body)['vehicle'];
      return VehicleModel.fromJson(data);
    } else {
      throw Exception("Failed to fetch vehicle by ID");
    }
  }

  @override
  Future<VehicleModel> updateVehicle(String id, VehicleModel vehicle) async {
    final response = await http.put(
      Uri.parse('${APIConst.Vehicle}/$id'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(vehicle.toJson()),
    );

    if (response.statusCode == 200) {
      return VehicleModel.fromJson(jsonDecode(response.body)['vehicle']);
    } else {
      throw Exception("Failed to update vehicle");
    }
  }

  @override
  Future<void> deleteVehicle(String id) async {
    final response = await http.delete(Uri.parse('${APIConst.Vehicle}/$id'));

    if (response.statusCode != 200) {
      throw Exception("Failed to delete vehicle");
    }
  }
}
