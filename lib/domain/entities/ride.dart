class Ride {
  final String id;
  final String time1;
  final String time2;
  final String location1;
  final String location2;
  final bool smoking;
  final bool animals;
  final String driverId;
  final String vehicleId;
  final String date;
  final int passengerCount;
  final String luggageSize;

  Ride({
    required this.id,
    required this.time1,
    required this.time2,
    required this.location1,
    required this.location2,
    required this.smoking,
    required this.animals,
    required this.driverId,
    required this.vehicleId,
    required this.date,
    required this.passengerCount,
    required this.luggageSize,
  });
}
