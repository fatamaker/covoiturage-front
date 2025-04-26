import 'dart:convert';
import 'package:covoiturage2/core/erreur/exception/exceptions.dart';
import 'package:covoiturage2/core/utils/api_const.dart';
import 'package:covoiturage2/data/models/reservation_model.dart';
import 'package:http/http.dart' as http;

abstract class ReservationRemoteDataSource {
  Future<ReservationModel> createReservation(ReservationModel reservation);
  Future<List<ReservationModel>> getReservationsByDriver(String driverId);
  Future<List<ReservationModel>> getReservationsByPassenger(String driverId);

  Future<void> updateReservationStatus(String reservationId, String status);
}

class ReservationRemoteDataSourceImpl implements ReservationRemoteDataSource {
  ReservationRemoteDataSourceImpl();
  @override
  Future<ReservationModel> createReservation(
      ReservationModel reservation) async {
    try {
      final url = Uri.parse(APIConst.reservations);
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(reservation.toJson()),
      );

      if (response.statusCode == 201) {
        final decoded = jsonDecode(response.body);
        print('Response body: $decoded');

        // If the whole response IS the reservation object
        return ReservationModel.fromJson(decoded);
      } else {
        throw ServerException(
            message: "Failed to create reservation: ${response.body}");
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<ReservationModel>> getReservationsByDriver(
      String driverId) async {
    try {
      final url = Uri.parse('${APIConst.reservations}/driver/$driverId');
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body)['reservations'] as List;
        return data.map((json) => ReservationModel.fromJson(json)).toList();
      } else {
        throw ServerException(
            message: "Failed to fetch reservations: ${response.body}");
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<ReservationModel>> getReservationsByPassenger(
      String driverId) async {
    // keeping it driverId as you asked
    try {
      final url = Uri.parse('${APIConst.reservations}/passenger/$driverId');
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body)['reservations'] as List;
        return data.map((json) => ReservationModel.fromJson(json)).toList();
      } else {
        throw ServerException(
            message: "Failed to fetch reservations: ${response.body}");
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> updateReservationStatus(
      String reservationId, String status) async {
    try {
      final url = Uri.parse('${APIConst.reservations}/$reservationId');
      final response = await http.patch(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'status': status}),
      );

      if (response.statusCode != 200) {
        throw ServerException(
            message: "Failed to update status: ${response.body}");
      }
    } catch (e) {
      rethrow;
    }
  }
}
