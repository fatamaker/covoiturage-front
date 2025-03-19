import 'package:flutter/material.dart';

class AddRideScreen4 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Search")),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text("Volkswagen | Gris", style: TextStyle(fontSize: 18)),
                Spacer(),
                Text("2 Places", style: TextStyle(fontSize: 18)),
              ],
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Container(
                        height: 100, // Adjust as needed
                        child: ListView.builder(
                          itemCount: 5, // Replace with your data
                          itemBuilder: (context, index) {
                            return Container(
                              width: 8,
                              height: 8,
                              margin: EdgeInsets.symmetric(vertical: 8),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: index == 0 ? Colors.green : Colors.grey,
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Départ à 10:00", style: TextStyle(fontSize: 16)),
                      SizedBox(height: 8),
                      Text("Prix total par personne",
                          style: TextStyle(fontSize: 16)),
                      SizedBox(height: 8),
                      Text("20 DT",
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                // Add your confirmation logic here
              },
              child: Text("Valider"),
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 50),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
