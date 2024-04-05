import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Accueil extends StatelessWidget {
  const Accueil({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Allo 45'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset('image/demande.png',
              width: 200,
              height: 200,
            ),
            const SizedBox(height: 20),
            const Text(
              'Bienvenue à Allo 45',
              style: TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 10)
          ],
        ),
      ),
    );
  }
}
