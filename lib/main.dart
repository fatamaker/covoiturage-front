import 'package:covoiturage2/presentation/controllers/authetification_controller.dart';
import 'package:covoiturage2/presentation/ui/HomePage.dart';
import 'package:covoiturage2/presentation/ui/LoginScreen.dart';
import 'package:covoiturage2/presentation/ui/page1.dart';
import 'package:covoiturage2/presentation/ui/page2.dart';
import 'package:covoiturage2/presentation/ui/registerScreen.dart';
import 'package:covoiturage2/presentation/ui/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'di.dart' as di;

Future<void> main() async {
  await di.init();

  Get.put(AuthenticationController());

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Splash Screen App',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => SplashScreen(),
        '/home': (context) => HomePage(),
        '/page1': (context) => page1(),
        '/page2': (context) => Page2(),
        '/register': (context) => Registerscreen(),
        '/login': (context) => LoginScreen(),
      },
    );
  }
}
