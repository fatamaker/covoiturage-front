import 'package:covoiturage2/presentation/ui/AddRideScreen3.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:covoiturage2/presentation/controllers/ride_controller.dart';
import 'package:covoiturage2/data/models/ride_model.dart';

class AddRideScreen2 extends StatefulWidget {
  final String rideId;
  final RideModel ride;

  AddRideScreen2({required this.rideId, required this.ride});

  @override
  _AddRideScreen2State createState() => _AddRideScreen2State();
}

class _AddRideScreen2State extends State<AddRideScreen2> {
  final RideController rideController = Get.find<RideController>();

  Widget _buildBaggageOption(String label) {
    return GestureDetector(
      onTap: () {
        rideController.setLuggageSize(label);
      },
      child: GetBuilder<RideController>(
        builder: (controller) => Container(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          decoration: BoxDecoration(
            color: controller.selectedLuggageSize == label
                ? Colors.black
                : Colors.grey[300],
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            label,
            style: TextStyle(
              color: controller.selectedLuggageSize == label
                  ? Colors.white
                  : Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 70),

            // Passenger Count
            GetBuilder<RideController>(
              builder: (controller) => Center(
                child: Column(
                  children: [
                    Text("Nombre de passagers", style: TextStyle(fontSize: 18)),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          icon: Icon(Icons.remove, size: 30),
                          onPressed: () {
                            if (controller.passengerCount > 1) {
                              controller.setPassengerCount(
                                  controller.passengerCount - 1);
                            }
                          },
                        ),
                        Text("${controller.passengerCount}",
                            style: TextStyle(
                                fontSize: 24, fontWeight: FontWeight.bold)),
                        IconButton(
                          icon: Icon(Icons.add, size: 30),
                          onPressed: () {
                            controller.setPassengerCount(
                                controller.passengerCount + 1);
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: 50),

            // Baggage Size Selection
            Center(
              child: Column(
                children: [
                  Text("Taille de bagage", style: TextStyle(fontSize: 18)),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildBaggageOption("Petit"),
                      SizedBox(width: 10),
                      _buildBaggageOption("Moyen"),
                      SizedBox(width: 10),
                      _buildBaggageOption("Grand"),
                    ],
                  ),
                ],
              ),
            ),

            SizedBox(height: 50),

            // Rules Section
            GetBuilder<RideController>(
              builder: (controller) => Column(
                children: [
                  Row(
                    children: [
                      Checkbox(
                        value: controller.cigaretteAccepted,
                        onChanged: (value) {
                          controller.toggleCigarette(value!);
                        },
                      ),
                      Icon(Icons.smoking_rooms_sharp, size: 20),
                      SizedBox(width: 10),
                      Text("Cigarette Acceptée"),
                    ],
                  ),
                  Row(
                    children: [
                      Checkbox(
                        value: controller.animalsAccepted,
                        onChanged: (value) {
                          controller.toggleAnimals(value!);
                        },
                      ),
                      Icon(Icons.pets, size: 20),
                      SizedBox(width: 10),
                      Text("Animaux Acceptée"),
                    ],
                  ),
                ],
              ),
            ),

            Spacer(),

            // Continue Button
            GetBuilder<RideController>(
              builder: (controller) => Container(
                width: double.infinity,
                height: 50,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFFBFD834), Color(0xFF133A1B)],
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ElevatedButton(
                  onPressed: () async {
                    final updatedRide =
                        await controller.updateRide(widget.rideId, widget.ride);

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AddRideScreen3(
                          rideId: widget.rideId,
                          ride: updatedRide!,
                        ),
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
              ),
            ),

            SizedBox(height: 20),

            // FutureBuilder to Observe Ride Update
            FutureBuilder(
              future: rideController.updateRide(widget.rideId, widget.ride),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text("Error: ${snapshot.error}"));
                } else {
                  return SizedBox(); // No widget if update is successful
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
