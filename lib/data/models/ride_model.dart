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
    required int freePlaces,
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
          freePlaces: freePlaces,
          passengerCount: passengerCount,
          luggageSize: luggageSize,
        );

  factory RideModel.fromJson(Map<String, dynamic> json) {
    return RideModel(
      id: json['_id'],
      time1: json['time1'],
      time2: json['time2'],
      location1: json['location1'],
      location2: json['location2'],
      smoking: json['smoking'],
      animals: json['animals'],
      driverId: json['driver'],
      vehicleId: json['vehicle'],
      freePlaces: json['freePlaces'],
      passengerCount: json['passengerCount'],
      luggageSize: json['luggageSize'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'time1': time1,
      'time2': time2,
      'location1': location1,
      'location2': location2,
      'smoking': smoking,
      'animals': animals,
      'driver': driverId,
      'vehicle': vehicleId,
      'freePlaces': freePlaces,
      'passengerCount': passengerCount,
      'luggageSize': luggageSize,
    };
  }
}
