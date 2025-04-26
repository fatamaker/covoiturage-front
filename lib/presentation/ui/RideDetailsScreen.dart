import 'package:covoiturage2/presentation/controllers/authetification_controller.dart';
import 'package:covoiturage2/presentation/controllers/reservation_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:covoiturage2/data/models/ride_model.dart';
import 'package:covoiturage2/data/models/vehicle_model.dart';
import 'package:covoiturage2/presentation/controllers/ride_controller.dart';
import 'package:covoiturage2/presentation/controllers/vehicle_controller.dart';

class RideDetailsScreen extends StatefulWidget {
  final String rideId;

  RideDetailsScreen({required this.rideId});

  @override
  State<RideDetailsScreen> createState() => _RideDetailsScreenState();
}

class _RideDetailsScreenState extends State<RideDetailsScreen> {
  late RideController rideController;
  late VehicleController vehicleController;
  late AuthenticationController authController;

  @override
  void initState() {
    super.initState();
    rideController = Get.find();
    vehicleController = Get.find();
    authController = Get.find();

    // Only call the API once when the screen is initialized
    rideController.getRideById(widget.rideId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ride Details'),
        foregroundColor: Colors.black,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: GetBuilder<RideController>(
        builder: (_) {
          if (rideController.isLoading || rideController.rideDetails == null) {
            return Center(child: CircularProgressIndicator());
          }

          final RideModel ride = rideController.rideDetails!;
          final driver = rideController.drivers[ride.driverId];
          final userId = authController.currentUser.id;

          final ReservationController reservationController = Get.put(
            ReservationController(driverId: ride.driverId),
          );

          return FutureBuilder<VehicleModel?>(
            future: vehicleController.getVehicleById(ride.vehicleId),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }

              final vehicle = snapshot.data;

              return Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // DRIVER INFO
                          Row(
                            children: [
                              CircleAvatar(
                                radius: 32,
                                backgroundImage: NetworkImage(
                                  driver?.imageUrl ?? '',
                                ),
                              ),
                              SizedBox(width: 16),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '${driver?.firstName ?? 'Unknown'} ${driver?.lastName ?? ''}',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    '${ride.passengerCount}/5 seats available',
                                    style: TextStyle(color: Colors.grey[600]),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(height: 24),
                          Divider(thickness: 1, color: Colors.grey[300]),

                          // RIDE INFO
                          _infoRow(Icons.location_on, 'From', ride.location1),
                          _infoRow(Icons.flag, 'To', ride.location2),
                          _infoRow(
                              Icons.access_time, 'Departure Time', ride.time1),
                          _infoRow(Icons.schedule, 'Arrival Time', ride.time2),
                          _infoRow(Icons.smoking_rooms, 'Smoking Allowed',
                              ride.smoking ? 'Yes' : 'No'),
                          _infoRow(Icons.pets, 'Pets Allowed',
                              ride.animals ? 'Yes' : 'No'),

                          SizedBox(height: 24),
                          Divider(thickness: 1, color: Colors.grey[300]),

                          // VEHICLE INFO
                          if (vehicle != null) ...[
                            Text(
                              'Vehicle Details',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 12),
                            _infoRow(
                                Icons.directions_car, 'Model', vehicle.model),
                            _infoRow(
                                Icons.color_lens, 'Color', vehicle.couleur),
                            _infoRow(Icons.calendar_today, 'Year',
                                vehicle.year.toString()),
                          ],
                        ],
                      ),
                    ),
                  ),

                  // RESERVE BUTTON
                  Padding(
                    padding: EdgeInsets.all(16),
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Color(0xFFBFD834), Color(0xFF133A1B)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: ElevatedButton(
                        onPressed: () async {
                          await reservationController.createReservation(
                            ride.id,
                            userId!,
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent,
                          padding: EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Text(
                          'Reserve This Ride',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }

  Widget _infoRow(IconData icon, String title, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          Icon(icon, color: Color.fromARGB(255, 145, 171, 0)),
          SizedBox(width: 12),
          Text(
            '$title: ',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(fontSize: 16, color: Color(0xFF133A1B)),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
