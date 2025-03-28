import 'package:covoiturage2/domain/entities/ride.dart';

class RideModel extends Ride {
  RideModel({
    required String id,
    required String time1,
    required String time2,
    required String location1,
    required String location2,
    required bool smoking,
    required bool animals,
    required String driverId,
    required String vehicleId,
    required String date,
    required int passengerCount,
    required String luggageSize,
  }) : super(
          id: id,
          time1: time1,
          time2: time2,
          location1: location1,
          location2: location2,
          smoking: smoking,
          animals: animals,
          driverId: driverId,
          vehicleId: vehicleId,
          date: date,
          passengerCount: passengerCount,
          luggageSize: luggageSize,
        );

  factory RideModel.fromJson(Map<String, dynamic> json) {
    print('Parsed JSON: $json'); // Log the JSON for debugging

    return RideModel(
      id: json['_id']?.toString() ?? "",
      time1: json['time1']?.toString() ?? "",
      time2: json['time2']?.toString() ?? "",
      location1: json['location1']?.toString() ?? "",
      location2: json['location2']?.toString() ?? "",
      smoking: json['smoking'] ?? false,
      animals: json['animals'] ?? false,
      driverId: _parseDriverId(json),
      vehicleId: _parseVehicleId(json),
      date: json['date']?.toString() ?? "",
      passengerCount: json['passengerCount'] ?? 1,
      luggageSize: json['luggageSize']?.toString() ?? 'Petit',
    );
  }

  static String _parseDriverId(Map<String, dynamic> json) {
    // Check if 'driver' is a string or a map and extract the driver ID
    if (json['driver'] is String) {
      return json['driver']; // Driver is just a string (ID)
    } else if (json['driver'] is Map && json['driver']['_id'] != null) {
      return json['driver']['_id'].toString(); // Driver is a map with an ID
    }
    return ""; // Return empty if no valid ID is found
  }

  static String _parseVehicleId(Map<String, dynamic> json) {
    // Check if 'vehicle' is null, string, or a map and extract the vehicle ID
    if (json['vehicle'] == null) return ""; // No vehicle data
    if (json['vehicle'] is String)
      return json['vehicle']; // Vehicle is just a string (ID)
    if (json['vehicle'] is Map && json['vehicle']['_id'] != null) {
      return json['vehicle']['_id'].toString(); // Vehicle is a map with an ID
    }
    return ""; // Return empty if no valid ID is found
  }

  @override
  String toString() {
    return 'RideModel(id: $id, time1: $time1, time2: $time2, location1: $location1, location2: $location2, date: $date, driver: $driverId, vehicle: $vehicleId  , passengerCount: $passengerCount,luggageSize: $luggageSize,smoking: $smoking,animals: $animals,)';
  }

  Map<String, dynamic> toJson() {
    return {
      'time1': time1,
      'time2': time2,
      'location1': location1,
      'location2': location2,
      'smoking': smoking,
      'animals': animals,
      'driver': driverId,
      'vehicle': vehicleId,
      'date': date,
      'passengerCount': passengerCount,
      'luggageSize': luggageSize,
    };
  }
}
