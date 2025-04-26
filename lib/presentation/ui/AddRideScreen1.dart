import 'package:covoiturage2/presentation/controllers/ride_controller.dart';
import 'package:covoiturage2/presentation/ui/AddRideScreen2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class AddRideScreen1 extends StatefulWidget {
  @override
  _AddRideScreen1State createState() => _AddRideScreen1State();
}

class _AddRideScreen1State extends State<AddRideScreen1> {
  final RideController rideController = Get.find();
  TextEditingController _dateController = TextEditingController();
  TextEditingController _timeController = TextEditingController();
  TextEditingController _timeController2 = TextEditingController();
  TextEditingController _departController = TextEditingController();
  TextEditingController _destinationController = TextEditingController();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        _dateController.text = DateFormat('dd/MM/yyyy').format(picked);
      });
    }
  }

  Future<void> _selectTime(TextEditingController controller) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      setState(() {
        controller.text = picked.format(context);
      });
    }
  }

  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    bool readOnly = false,
    VoidCallback? onTap,
    IconData? icon,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: TextFormField(
        controller: controller,
        readOnly: readOnly,
        onTap: onTap,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
          prefixIcon: icon != null ? Icon(icon, color: Colors.green) : null,
          contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text("Ajouter un trajet"),
        automaticallyImplyLeading: false,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTextField(
                  label: "Ville de départ", controller: _departController),
              _buildTextField(
                  label: "Ville d'arrivée", controller: _destinationController),
              _buildTextField(
                label: "Date",
                controller: _dateController,
                readOnly: true,
                onTap: () => _selectDate(context),
                icon: Icons.calendar_today,
              ),
              _buildTextField(
                label: "Heure de départ",
                controller: _timeController,
                readOnly: true,
                onTap: () => _selectTime(_timeController),
                icon: Icons.access_time,
              ),
              _buildTextField(
                label: "Heure d'arrivée",
                controller: _timeController2,
                readOnly: true,
                onTap: () => _selectTime(_timeController2),
                icon: Icons.access_time,
              ),
              SizedBox(height: 20),
              GetBuilder<RideController>(
                builder: (controller) {
                  return controller.isLoading
                      ? Center(child: CircularProgressIndicator())
                      : Container(
                          width: double.infinity,
                          height: 50,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [Color(0xFFBFD834), Color(0xFF133A1B)],
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: ElevatedButton(
                            onPressed: () async {
                              final ride = await controller.createRide(
                                departure: _departController,
                                destination: _destinationController,
                                time1: _timeController,
                                time2: _timeController2,
                                date: TextEditingController(
                                    text: _dateController.text),
                                context: context,
                              );
                              if (ride != null) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => AddRideScreen2(
                                      rideId: ride.id,
                                      ride: ride,
                                    ),
                                  ),
                                );
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.transparent,
                              shadowColor: Colors.transparent,
                            ),
                            child: Text("Continuer",
                                style: TextStyle(color: Colors.white)),
                          ),
                        );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
