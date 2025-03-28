import 'package:covoiturage2/presentation/ui/widgets/RideTile.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Welcome', style: TextStyle(fontSize: 16)),
                Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.notifications_none),
                      onPressed: () {},
                    ),
                    IconButton(
                      icon: Icon(Icons.menu),
                      onPressed: () {},
                    ),
                  ],
                ),
              ],
            ),
            Text('Fatma Kerkeni',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            SizedBox(height: 16),
            TextField(
              decoration: InputDecoration(
                hintText: 'Search',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            SizedBox(height: 20),
            Container(
              decoration: BoxDecoration(
                color: Colors.grey[200], // Example background color
                borderRadius: BorderRadius.circular(8),
              ),
              padding: EdgeInsets.all(16),
              child: Column(
                children: [
                  Image.asset('assets/images/Smart.jpg',
                      height: 250), // Replace with your car image
                  // ... Add other car details here if needed
                ],
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Nearby Rides',
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                TextButton(
                  onPressed: () {},
                  child: Text('See more'),
                ),
              ],
            ),
            SizedBox(height: 10),
            RideTile(
              time1: '03:30',
              time2: '04:30',
              location1: 'Nabeul',
              location2: 'Tunis',
              smoking: true,
              animals: true,
              driverName: 'Flan Flani',
              freePlaces: '2/5',
              driverImageUrl: '',
            ),
            RideTile(
              time1: '03:30',
              time2: '04:30',
              location1: 'Nabeul',
              location2: 'Tunis',
              smoking: true,
              animals: true,
              driverName: 'Flan Flani',
              freePlaces: '3/4',
              driverImageUrl: '',
            ),
            RideTile(
              time1: '03:30',
              time2: '04:30',
              location1: 'Nabeul',
              location2: 'Tunis',
              smoking: true,
              animals: true,
              driverName: 'Flan Flani',
              freePlaces: '2/5',
              driverImageUrl: '',
            ),
          ],
        ),
      ),
    ));
  }
}
