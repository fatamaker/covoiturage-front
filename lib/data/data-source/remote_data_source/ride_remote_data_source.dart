import 'dart:convert';
import 'package:covoiturage2/core/erreur/exception/exceptions.dart';
import 'package:covoiturage2/core/utils/api_const.dart';
import 'package:covoiturage2/data/models/ride_model.dart';
import 'package:http/http.dart' as http;

abstract class RideRemoteDataSource {
  Future<RideModel> createRide(String time1, String time2, String location1,
      String location2, String date, String driverId);
  Future<RideModel> createOrUpdateRide(RideModel ride);
  Future<List<RideModel>> getAllRides();
  Future<RideModel> getRideById(String id);
  Future<RideModel> updateRide(String id, RideModel ride);
  Future<void> deleteRide(String id);
}

class RideRemoteDataSourceImpl implements RideRemoteDataSource {
  @override
  Future<RideModel> createRide(String time1, String time2, String location1,
      String location2, String date, String driverId) async {
    try {
      final url = Uri.parse(APIConst.rides);

      final Map<String, dynamic> rideData = {
        'time1': time1,
        'time2': time2,
        'location1': location1,
        'location2': location2,
        'date': date,
        'driver': driverId
      };

      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(rideData),
      );

      if (response.statusCode == 201) {
        final ride = RideModel.fromJson(jsonDecode(response.body)['ride']);

        return ride;
      } else {
        throw ServerException(
            message: "Failed to create ride: ${response.body}");
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<RideModel> createOrUpdateRide(RideModel ride) async {
    try {
      final url = Uri.parse(APIConst.createOrUpdateRide);
      final response = await http.put(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(ride.toJson()),
      );

      if (response.statusCode == 200) {
        return RideModel.fromJson(jsonDecode(response.body));
      } else {
        throw ServerException(
            message: "Failed to update ride: ${response.body}");
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<RideModel>> getAllRides() async {
    try {
      final url = Uri.parse(APIConst.rides);
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        final List<dynamic> data = json['rides'];
        return data.map((ride) => RideModel.fromJson(ride)).toList();
      } else {
        throw ServerException(
            message: "Failed to fetch rides: ${response.body}");
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<RideModel> getRideById(String id) async {
    try {
      final url = Uri.parse('${APIConst.rides}/$id');

      final response = await http.get(url);

      if (response.statusCode == 200) {
        final ride = RideModel.fromJson(jsonDecode(response.body)['ride']);

        return ride;
      } else {
        throw ServerException(
            message: "Failed to fetch ride: ${response.body}");
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<RideModel> updateRide(String id, RideModel ride) async {
    try {
      final url = Uri.parse('${APIConst.updateRide}/$id');

      final response = await http.put(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(ride.toJson()),
      );

      if (response.statusCode == 200) {
        final ride = RideModel.fromJson(jsonDecode(response.body)['ride']);
        print(
            'Created ride: $ride'); // Check if the ride is populated correctly

        return ride;
      } else {
        throw ServerException(
            message: "Failed to update ride: ${response.body}");
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> deleteRide(String id) async {
    try {
      final url = Uri.parse('${APIConst.deleteRide}/$id');
      final response = await http.delete(url);

      if (response.statusCode != 200) {
        throw ServerException(
            message: "Failed to delete ride: ${response.body}");
      }
    } catch (e) {
      rethrow;
    }
  }
}
