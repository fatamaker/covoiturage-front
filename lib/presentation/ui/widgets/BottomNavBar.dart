// import 'package:flutter/material.dart';

// class BottomNavBar extends StatelessWidget {
//    final void Function(int)? onTabChange;
// final int currentIndex;

//   BottomNavBar( super.key,
// required this.onTabChange,
// required this.currentIndex,);

//   @override
//   Widget build(BuildContext context) {
//     return BottomNavigationBar(
//       items: const <BottomNavigationBarItem>[
//         BottomNavigationBarItem(
//           icon: Icon(Icons.home),
//           label: 'Home',
//         ),
//         BottomNavigationBarItem(
//           icon: Icon(Icons.map),
//           label: 'Trajet',
//         ),
//         BottomNavigationBarItem(
//           icon: Icon(Icons.search),
//           label: 'Search',
//         ),
//         BottomNavigationBarItem(
//           icon: Icon(Icons.person),
//           label: 'Profile',
//         ),
//         BottomNavigationBarItem(
//           icon: Icon(Icons.inbox),
//           label: 'Inbox',
//         ),
//       ],
//       currentIndex: currentIndex,
//       selectedItemColor: Color.fromARGB(255, 57, 167, 79),
//       unselectedItemColor: Colors.grey,
//       onTap: onTap,
//     );
//   }
// }

import 'package:flutter/material.dart';

class BottomNavBar extends StatelessWidget {
  final void Function(int)? onTabChange; // Callback to handle tab change
  final int currentIndex; // Current index of selected tab

  // Constructor to receive currentIndex and onTabChange callback
  BottomNavBar(
      {super.key, required this.onTabChange, required this.currentIndex});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.map),
          label: 'Trajet',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.search),
          label: 'Search',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Profile',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.inbox),
          label: 'Inbox',
        ),
      ],
      currentIndex: currentIndex, // Updates the selected index
      selectedItemColor:
          Color.fromARGB(255, 57, 167, 79), // Color when item is selected
      unselectedItemColor: Colors.grey, // Color when item is not selected
      onTap:
          onTabChange, // Executes the onTabChange callback when a tab is clicked
    );
  }
}
