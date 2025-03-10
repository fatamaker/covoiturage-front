import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Accueil'), // Titre de l'écran principal
        backgroundColor: Colors.green, // Couleur de l'appBar
      ),
      body: Center(
        child: Text(
          'Bienvenue sur l\'écran principal !',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
