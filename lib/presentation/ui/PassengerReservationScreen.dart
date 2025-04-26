import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:covoiturage2/presentation/controllers/reservation_controller.dart';
import 'package:covoiturage2/presentation/controllers/ride_controller.dart'; // Import RideController

class PassengerReservationScreen extends StatelessWidget {
  final String passengerId;

  const PassengerReservationScreen({super.key, required this.passengerId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Reservations'),
      ),
      body: GetBuilder<ReservationController>(
        init: ReservationController(driverId: passengerId),
        builder: (controller) {
          if (controller.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (controller.reservations.isEmpty) {
            return const Center(child: Text("No reservations found"));
          }

          // Group reservations by status
          final acceptedReservations = controller.reservations
              .where((r) => r.status == 'accepted')
              .toList();
          final pendingReservations = controller.reservations
              .where((r) => r.status == 'pending')
              .toList();
          final refusedReservations = controller.reservations
              .where((r) => r.status == 'rejected')
              .toList();

          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildReservationSection(
                  title: "Accepted Reservations",
                  reservations: acceptedReservations,
                  context: context,
                ),
                _buildReservationSection(
                  title: "Pending Reservations",
                  reservations: pendingReservations,
                  context: context,
                ),
                _buildReservationSection(
                  title: "Refused Reservations",
                  reservations: refusedReservations,
                  context: context,
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildReservationSection({
    required String title,
    required List reservations,
    required BuildContext context,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        if (reservations.isEmpty)
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Text('No reservations in this category.'),
          ),
        ...reservations.map(
          (reservation) => Card(
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: ListTile(
              title: Text("Reservation Status: ${reservation.status}"),
              subtitle: Text("Tap to view ride details"),
              trailing: reservation.status == 'accepted'
                  ? IconButton(
                      icon: const Icon(Icons.chat, color: Colors.blue),
                      onPressed: () {
                        // You can add chat screen navigation later
                      },
                    )
                  : null,
              onTap: () async {
                // On tap, fetch ride details using RideController
                final rideController = Get.find<RideController>();
                await rideController.getRideById(reservation.rideId);

                if (rideController.rideDetails != null) {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('Ride Details'),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                              'Destination: ${rideController.rideDetails!.location2}'),
                          Text(
                              'Departure Time: ${rideController.rideDetails!.time2}'),
                          // Add other ride info if needed
                        ],
                      ),
                      actions: [
                        TextButton(
                          child: const Text('Close'),
                          onPressed: () => Navigator.of(context).pop(),
                        ),
                      ],
                    ),
                  );
                }
              },
            ),
          ),
        ),
      ],
    );
  }
}
