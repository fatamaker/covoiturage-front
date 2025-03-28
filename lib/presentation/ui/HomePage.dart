// import 'package:covoiturage2/presentation/ui/AddRideScreen1.dart';
// import 'package:covoiturage2/presentation/ui/HomeScreen.dart';
// import 'package:covoiturage2/presentation/ui/widgets/BottomNavBar.dart';
// import 'package:flutter/material.dart';

// class HomePage extends StatefulWidget {
//   @override
//   _HomePageState createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   int _selectedIndex = 0;

//   static List<Widget> _widgetOptions = <Widget>[
//     HomeScreen(),
//     AddRideScreen1(),
//     Text('Search'),
//     Text('Profile'),
//     Text('Inbox'),
//   ];

//   void _onItemTapped(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: _widgetOptions.elementAt(_selectedIndex),
//       ),
//       bottomNavigationBar: BottomNavBar(
//         currentIndex: _selectedIndex,
//         onTap: _onItemTapped,
//       ),
//     );
//   }
// }
import 'package:covoiturage2/presentation/ui/AddRideScreen1.dart';
import 'package:covoiturage2/presentation/ui/HomeScreen.dart';
import 'package:covoiturage2/presentation/ui/widgets/BottomNavBar.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  static List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    AddRideScreen1(),
    Text('Search'),
    Text('Profile'),
    Text('Inbox'),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: _selectedIndex,
        onTabChange:
            _onItemTapped, // Adjusted to match the updated BottomNavBar
      ),
    );
  }
}
