import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:covoiturage2/presentation/controllers/reservation_controller.dart';

class ReservationListScreen extends StatelessWidget {
  final String driverId;

  const ReservationListScreen({super.key, required this.driverId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reservations'),
      ),
      body: GetBuilder<ReservationController>(
        init: ReservationController(driverId: driverId),
        builder: (controller) {
          if (controller.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (controller.reservations.isEmpty) {
            return const Center(child: Text("No reservations found"));
          }

          return ListView.builder(
            itemCount: controller.reservations.length,
            itemBuilder: (context, index) {
              final reservation = controller.reservations[index];

              return Card(
                margin: const EdgeInsets.all(8),
                child: ListTile(
                  title: Text("User: ${reservation.passengerId}"),
                  subtitle: Text("Status: ${reservation.status}"),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (reservation.status == 'pending') ...[
                        IconButton(
                          icon: const Icon(Icons.check, color: Colors.green),
                          onPressed: () {
                            controller.updateReservationStatus(
                                reservation.id ?? "", 'accepted');
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.close, color: Colors.red),
                          onPressed: () {
                            controller.updateReservationStatus(
                                reservation.id ?? "", 'rejected');
                          },
                        ),
                      ],
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
