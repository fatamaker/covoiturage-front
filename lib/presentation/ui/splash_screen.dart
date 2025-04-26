import 'package:covoiturage2/di.dart';
import 'package:covoiturage2/domain/usecases/userusecase/auto_login_usecase.dart';
import 'package:covoiturage2/domain/usecases/userusecase/get_user_by_id_usecase.dart';
import 'package:covoiturage2/presentation/controllers/authetification_controller.dart';
import 'package:covoiturage2/presentation/ui/HomeScreen.dart';
import 'package:covoiturage2/presentation/ui/LoginScreen.dart';
import 'package:covoiturage2/presentation/ui/page1.dart';
import 'package:covoiturage2/presentation/ui/registerScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  final AuthenticationController authController = Get.find();
  bool res = false;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    );

    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);
    _controller.forward();

    _checkAutoLogin();
  }

  Future<void> _checkAutoLogin() async {
    final autologiVarReturn = await AutoLoginUsecase(sl()).call();

    await autologiVarReturn.fold((l) {
      res = false;
    }, (r) async {
      if (r != null) {
        authController.token = r;
        final user = await GetUserByIdUsecase(sl()).call(userId: r.userId);
        user.fold((l) {
          res = false;
        }, (r) {
          authController.currentUser = r;
          res = true;
        });
      }
    });

    Future.delayed(const Duration(seconds: 1), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          // builder: (_) => res ? HomeScreen() : Registerscreen(),
          builder: (_) => Registerscreen(),
        ),
      );
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
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.greenAccent, Colors.green.shade900],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Lottie.asset(
                'assets/animations/car.json',
                width: 200,
                height: 200,
                fit: BoxFit.cover,
              ),
              const SizedBox(height: 40),
              Center(
                child: AnimatedBuilder(
                  animation: _animation,
                  builder: (context, child) {
                    return CustomPaint(
                      size: const Size(200, 50),
                      painter: TextPainterAnimation(
                        text: 'COVOITURAGE',
                        progress: _animation.value,
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TextPainterAnimation extends CustomPainter {
  final String text;
  final double progress;

  TextPainterAnimation({required this.text, required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    final textStyle = const TextStyle(
      color: Colors.white,
      fontSize: 24,
      fontWeight: FontWeight.bold,
      fontStyle: FontStyle.italic,
    );

    final textSpan = TextSpan(text: text, style: textStyle);
    final textPainter = TextPainter(
      text: textSpan,
      textDirection: TextDirection.ltr,
    );

    textPainter.layout(maxWidth: size.width);

    final textOffset = Offset(0, 0);
    final clipRect = Rect.fromLTWH(
      textOffset.dx,
      textOffset.dy,
      textPainter.width * progress,
      textPainter.height,
    );

    canvas.save();
    canvas.clipRect(clipRect);
    textPainter.paint(canvas, textOffset);
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
