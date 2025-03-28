import 'package:covoiturage2/domain/entities/vehicle.dart';

class VehicleModel extends Vehicle {
  VehicleModel({
    required String id,
    required String model,
    required String couleur,
    required int year,
    required String driverID,
  }) : super(
          id: id,
          model: model,
          couleur: couleur,
          year: year,
          driverID: driverID,
        );

  factory VehicleModel.fromJson(Map<String, dynamic> json) {
    return VehicleModel(
      id: json['_id'] as String,
      model: json['model'] as String,
      couleur: json['couleur'] as String,
      year: json['year'] as int,
      driverID: json['driverID'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'model': model,
      'couleur': couleur,
      'year': year,
      'driverID': driverID,
    };
  }
}
