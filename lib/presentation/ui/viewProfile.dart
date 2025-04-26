import 'package:covoiturage2/presentation/controllers/authetification_controller.dart';
import 'package:covoiturage2/presentation/ui/EditPasswordScreen.dart';
import 'package:covoiturage2/presentation/ui/EditProfileScreen.dart';
import 'package:covoiturage2/presentation/ui/PassengerReservationScreen.dart';
import 'package:covoiturage2/presentation/ui/ReservationListScreen.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class ViewProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final AuthenticationController authController = Get.find();

    return Scaffold(
      appBar: AppBar(
        backgroundColor:
            Colors.white, // Set the background color of the Scaffold to white
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      backgroundColor:
          Colors.white, // Set the background color of the Scaffold to white
      body: GetBuilder<AuthenticationController>(
        builder: (controller) {
          final currentUser = controller.currentUser;

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                const SizedBox(height: 32),
                CircleAvatar(
                  radius: 80,
                  backgroundImage: currentUser.imageUrl == null ||
                          currentUser.imageUrl!.isEmpty
                      ? const AssetImage('assets/images/person.png')
                      : NetworkImage(currentUser.imageUrl!) as ImageProvider,
                ),
                const SizedBox(height: 16),
                Text(
                  '${currentUser.firstName ?? ''} ${currentUser.lastName ?? ''}',
                  style: const TextStyle(
                      fontSize: 24, fontWeight: FontWeight.bold),
                ),
                Text(
                  currentUser.email ?? 'No email provided',
                  style: const TextStyle(fontSize: 18, color: Colors.grey),
                ),
                const SizedBox(height: 32),
                _buildCombinedStatCard('Rides', '360', 'Trips', '238'),
                const SizedBox(height: 50),
                _buildSettingsTile(
                  icon: Icons.car_repair,
                  title: 'My reservation list',
                  onTap: () => Get.to(
                      () => ReservationListScreen(driverId: currentUser.id!)),
                ),
                _buildSettingsTile(
                  icon: Icons.lock,
                  title: 'My trajet list',
                  onTap: () => Get.to(() =>
                      PassengerReservationScreen(passengerId: currentUser.id!)),
                ),
                _buildSettingsTile(
                  icon: Icons.edit,
                  title: 'Edit Profile',
                  onTap: () => Get.to(() => EditProfileScreen()),
                ),
                _buildSettingsTile(
                  icon: Icons.lock,
                  title: 'Edit Password',
                  onTap: () => Get.to(() => EditPassword()),
                ),
                const SizedBox(height: 32),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildCombinedStatCard(
      String title1, String value1, String title2, String value2) {
    return Container(
      constraints: BoxConstraints(maxWidth: 210, maxHeight: 90),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey
                .withOpacity(0.5), // Increased opacity for more visible shadow
            spreadRadius: 2, // Increased spread radius
            blurRadius: 5, // Increased blur radius
            offset: const Offset(
                0, 3), // Increased offset for more pronounced shadow
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Column(
                children: <Widget>[
                  Text(
                    title1,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    value1,
                    style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.teal),
                  ),
                ],
              ),
            ),
          ),
          Container(
            width: 1,
            height: 70,
            color: Colors.grey.withOpacity(0.5),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Column(
                children: <Widget>[
                  Text(
                    title2,
                    style: const TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                  Text(
                    value2,
                    style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.teal),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsTile({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return Card(
      // Changed back to Card
      color: Colors.white, // Ensure white background for the Card
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(
            vertical: 16.0, horizontal: 16.0), // Increased vertical padding
        leading: Icon(icon),
        title: Text(
          title,
          style: const TextStyle(fontSize: 18), // Slightly larger title
        ),
        trailing: const Icon(Icons.arrow_forward_ios),
        onTap: onTap,
      ),
    );
  }
}
