import 'package:covoiturage2/presentation/ui/AddRideScreen3.dart';
import 'package:flutter/material.dart';

class AddRideScreen2 extends StatefulWidget {
  @override
  _AddRideScreen2State createState() => _AddRideScreen2State();
}

class _AddRideScreen2State extends State<AddRideScreen2> {
  int _passengerCount = 2;
  String _selectedLuggageSize = "Moyen";
  bool _cigaretteAccepted = false;
  bool _animalsAccepted = false;

  Widget _buildBaggageOption(String label) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedLuggageSize = label;
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        decoration: BoxDecoration(
          color:
              _selectedLuggageSize == label ? Colors.black : Colors.grey[300],
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: _selectedLuggageSize == label ? Colors.white : Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 70),

            // Passenger Count
            Center(
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
                          setState(() {
                            if (_passengerCount > 1) _passengerCount--;
                          });
                        },
                      ),
                      Text("$_passengerCount",
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold)),
                      IconButton(
                        icon: Icon(Icons.add, size: 30),
                        onPressed: () {
                          setState(() {
                            _passengerCount++;
                          });
                        },
                      ),
                    ],
                  ),
                ],
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
            Text("Règles", style: TextStyle(fontSize: 18)),
            SizedBox(height: 10),
            Row(
              children: [
                Checkbox(
                  value: _cigaretteAccepted,
                  onChanged: (value) {
                    setState(() {
                      _cigaretteAccepted = value!;
                    });
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
                  value: _animalsAccepted,
                  onChanged: (value) {
                    setState(() {
                      _animalsAccepted = value!;
                    });
                  },
                ),
                Icon(Icons.pets, size: 20),
                SizedBox(width: 10),
                Text("Animaux Acceptée"),
              ],
            ),

            Spacer(),

            // Continue Button
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
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AddRideScreen3()),
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
          ],
        ),
      ),
    );
  }
}
