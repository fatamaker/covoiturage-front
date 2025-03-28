import 'package:covoiturage2/presentation/controllers/ride_controller.dart';
import 'package:covoiturage2/presentation/ui/HomeScreen.dart';
import 'package:covoiturage2/presentation/ui/confirmation_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:covoiturage2/data/models/ride_model.dart';

class AddRideScreen4 extends StatelessWidget {
  final String rideId;
  final RideModel ride;

  AddRideScreen4({required this.rideId, required this.ride});

  @override
  Widget build(BuildContext context) {
    final RideController rideController = Get.find<RideController>();

    return Scaffold(
      appBar: AppBar(title: Text("Ride Details"), centerTitle: true),
      body: GetBuilder<RideController>(
        initState: (_) => rideController.getRideById(rideId),
        builder: (controller) {
          if (controller.isLoading) {
            return Center(child: CircularProgressIndicator());
          }
          if (controller.rideDetails == null) {
            return Center(child: Text("Failed to load ride details"));
          }

          final rideData = controller.rideDetails!;

          return SingleChildScrollView(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.luggage, color: Colors.grey),
                          SizedBox(width: 8),
                          Text(" ${rideData.luggageSize}",
                              style:
                                  TextStyle(fontSize: 16, color: Colors.grey)),
                          Spacer(),
                          Icon(Icons.person_outline, color: Colors.grey),
                          SizedBox(width: 8),
                          Text("${rideData.passengerCount} Places",
                              style:
                                  TextStyle(fontSize: 16, color: Colors.grey)),
                        ],
                      ),
                      SizedBox(height: 30),
                      // You'll need to fetch and display the actual route points here
                      // This is a placeholder for the visual route
                      // Replace the placeholder with the actual route display
                      Row(
                        children: [
                          Column(
                            children: [
                              Icon(Icons.circle_outlined,
                                  color: Colors.grey, size: 16),
                              Container(
                                width: 2,
                                height: 20,
                                color: Colors.grey.shade300,
                              ),
                              Container(
                                width: 2,
                                height: 20,
                                color: Colors.grey.shade300,
                              ),
                              Icon(Icons.circle, color: Colors.green, size: 16),
                            ],
                          ),
                          SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("${rideData.location1} ",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                                SizedBox(height: 12),
                                SizedBox(height: 12),
                                SizedBox(height: 12),
                                Text("${rideData.location2} "),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 30),
                      Icon(Icons.departure_board, color: Colors.grey),
                      SizedBox(height: 12),
                      Text(
                          "Départ à ${rideData.time1} | Arriver à ${rideData.time2}",
                          style: TextStyle(fontSize: 16, color: Colors.black)),

                      SizedBox(height: 12),
                      Icon(Icons.money, color: Colors.grey),
                      SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Prix total par personne",
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 16)),
                          // Text("${rideData.price} DT",
                          //     style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                          Text("10 DT")
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 24),
                Container(
                  width: double.infinity,
                  height: 50,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color(0xFFBFD834), Color(0xFF133A1B)],
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ElevatedButton(
                    onPressed: () {
                      // Added parentheses to make it a function
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ConfirmationScreen(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                    ),
                    child: Text("Continuer",
                        style: TextStyle(color: Colors.white, fontSize: 16)),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
