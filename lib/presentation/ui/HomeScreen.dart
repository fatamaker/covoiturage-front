import 'package:covoiturage2/presentation/controllers/ride_controller.dart';
import 'package:covoiturage2/presentation/ui/RideDetailsScreen.dart';
import 'package:covoiturage2/presentation/ui/widgets/RideTile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final RideController controller = Get.find();
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
            GetBuilder<RideController>(
              builder: (controller) {
                if (controller.isLoading) {
                  return Center(child: CircularProgressIndicator());
                }
                return Column(
                  children: controller.rides.map((ride) {
                    final driver = controller.drivers[ride.driverId];

                    return RideTile(
                      time1: ride.time1,
                      time2: ride.time2,
                      location1: ride.location1,
                      location2: ride.location2,
                      smoking: ride.smoking,
                      animals: ride.animals,
                      driverName: driver != null
                          ? '${driver.firstName} ${driver.lastName}'
                          : 'Unknown',
                      driverImageUrl: driver?.imageUrl ?? '',
                      freePlaces: '${ride.passengerCount}/5',
                      onTap: () {
                        Get.to(() => RideDetailsScreen(rideId: ride.id));
                      },
                    );
                  }).toList(),
                );
              },
            ),
          ],
        ),
      ),
    ));
  }
}
