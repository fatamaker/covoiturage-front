import 'package:flutter/material.dart';

class RideTile extends StatelessWidget {
  final String time1;
  final String time2;
  final String location1;
  final String location2;
  final bool smoking;
  final bool animals;
  final String driverName;
  final String freePlaces;
  final String driverImageUrl;
  final VoidCallback? onTap; // Declare onTap here as part of the widget's state

  RideTile({
    required this.time1,
    required this.time2,
    required this.location1,
    required this.location2,
    required this.smoking,
    required this.animals,
    required this.driverName,
    required this.freePlaces,
    required this.driverImageUrl,
    this.onTap, // Make onTap optional in the constructor
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onTap, // Use onTap here to trigger the action
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 8),
          padding: EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Colors.lightGreen[100],
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(time1, style: TextStyle(fontSize: 16)),
                          Text(time2, style: TextStyle(fontSize: 16)),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Column(
                          children: [
                            Container(
                              width: 8,
                              height: 8,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.teal,
                              ),
                            ),
                            Container(
                              width: 2,
                              height: 30,
                              color: Colors.teal,
                            ),
                            Container(
                              width: 8,
                              height: 8,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.teal,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(location1, style: TextStyle(fontSize: 16)),
                          Text(location2, style: TextStyle(fontSize: 16)),
                        ],
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Row(
                        children: [
                          if (smoking)
                            Icon(Icons.smoking_rooms_sharp, size: 20),
                          SizedBox(width: 4),
                          Text('Smoking', style: TextStyle(fontSize: 14)),
                        ],
                      ),
                      Row(
                        children: [
                          if (animals) Icon(Icons.pets, size: 20),
                          SizedBox(width: 4),
                          Text('Animals', style: TextStyle(fontSize: 14)),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundImage: NetworkImage(driverImageUrl),
                        radius: 25,
                      ),
                      SizedBox(width: 8),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(driverName,
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold)),
                          Text('$freePlaces free place',
                              style: TextStyle(fontSize: 14)),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.call,
                            color: const Color.fromARGB(255, 0, 0, 0)),
                        onPressed: () {},
                      ),
                      IconButton(
                        icon: Icon(Icons.message,
                            color: const Color.fromARGB(255, 0, 0, 0)),
                        onPressed: () {},
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ));
  }
}
