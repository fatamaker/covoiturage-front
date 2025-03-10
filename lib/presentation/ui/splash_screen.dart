import 'package:covoiturage2/presentation/ui/page1.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {
  @override
  // ignore: library_private_types_in_public_api
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    // Initialiser l'AnimationController
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 5), // Durée de l'animation
    );

    // Créer une animation de 0.0 à 1.0
    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);

    // Démarrer l'animation
    _controller.forward();

    // Naviguer vers l'écran principal après 8 secondes
    Future.delayed(Duration(seconds: 8), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => page1()),
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose(); // Nettoyer l'AnimationController
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.greenAccent, Colors.green.shade900], // Dégradé vert
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
              SizedBox(height: 40),
              // Animation de texte "Mon Application"
              Center(
                child: AnimatedBuilder(
                  animation: _animation,
                  builder: (context, child) {
                    return CustomPaint(
                      size: Size(200, 50), // Taille du texte
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
    final textStyle = TextStyle(
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

    // Dessiner le texte progressivement
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
