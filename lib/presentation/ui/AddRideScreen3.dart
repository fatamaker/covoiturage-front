import 'package:covoiturage2/data/models/ride_model.dart';
import 'package:covoiturage2/data/models/vehicle_model.dart';
import 'package:covoiturage2/presentation/controllers/ride_controller.dart';
import 'package:covoiturage2/presentation/controllers/vehicle_controller.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'AddRideScreen4.dart';

class AddRideScreen3 extends StatelessWidget {
  final String rideId;
  final RideModel ride;

  AddRideScreen3({required this.rideId, required this.ride});

  final TextEditingController modelController = TextEditingController();
  final TextEditingController yearController = TextEditingController();
  final TextEditingController colorController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final RideController rideController = Get.find<RideController>();
    final VehicleController vehicleController = Get.find<VehicleController>();

    return Scaffold(
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.85,
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(15),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  SizedBox(width: 10),
                  Text("Ajouter votre véhicule",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                ],
              ),
              SizedBox(height: 7),
              _buildTextField("Modèle", FontAwesomeIcons.car, modelController),
              _buildTextField(
                  "Année", FontAwesomeIcons.calendar, yearController),
              _buildTextField(
                  "Couleur", FontAwesomeIcons.palette, colorController),
              SizedBox(height: 10),
              SizedBox(height: 10),
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
                      VehicleModel? newVehicle =
                          await vehicleController.createVehicle(
                        model: modelController,
                        couleur: colorController,
                        year: yearController,
                      );

                      if (newVehicle != null) {
                        RideModel? updatedRide = await rideController
                            .updateRide(rideId, ride, vehicleId: newVehicle.id);

                        if (updatedRide != null) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AddRideScreen4(
                                rideId: rideId,
                                ride: updatedRide!,
                              ),
                            ),
                          );
                        }
                      }
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
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
      String label, IconData icon, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
        SizedBox(height: 5),
        TextField(
          controller: controller,
          decoration: InputDecoration(
            prefixIcon: Icon(icon, size: 18),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            filled: true,
            fillColor: Colors.white,
          ),
        ),
        SizedBox(height: 10),
      ],
    );
  }
}
