import 'package:covoiturage2/presentation/ui/HomePage.dart';
import 'package:covoiturage2/presentation/ui/HomeScreen.dart';
import 'package:covoiturage2/presentation/ui/widgets/BottomNavBar.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class ConfirmationScreen extends StatefulWidget {
  const ConfirmationScreen({super.key});

  @override
  _ConfirmationScreenState createState() => _ConfirmationScreenState();
}

class _ConfirmationScreenState extends State<ConfirmationScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeInAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 800),
    );
    _fadeInAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    );
    Future.delayed(Duration(milliseconds: 500), () {
      _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset(
              'assets/animations/success.json',
              width: 150,
              height: 150,
              repeat: false,
            ),
            FadeTransition(
              opacity: _fadeInAnimation,
              child: Column(
                children: [
                  Text(
                    'Ride Confirmed!',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Your ride has been successfully added.',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                  ),
                ],
              ),
            ),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Scaffold(
                      body: HomeScreen(),
                      bottomNavigationBar: BottomNavBar(
                        currentIndex: 2, // Set the tab index appropriately
                        onTabChange: (index) {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => HomePage()),
                          );
                        },
                      ),
                    ),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 12),
              ),
              child: Text(
                'Back to Home',
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
            SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
