

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'AnnonceDistante.dart';
import 'AnnonceLocal.dart';

class ChoisirAnnonce extends StatefulWidget {
  const ChoisirAnnonce({Key? key}) : super(key: key);

  @override
  _ChoisirAnnonce createState() => _ChoisirAnnonce();
}


class _ChoisirAnnonce extends State<ChoisirAnnonce> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Choisir une annonce'),
      ),
      body:
          Column(
            children: [
              // deux boutons pour choisir entre les annonces locales et distantes
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AnnonceLocal(),
                    ),
                  );
                  Text('Annonces locales');
                },
                child: const Text('Annonces locales'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AnnonceDisante(),
                    ),
                  );
                  Text('Annonces Publier');
                },
                child: const Text('Annonces distantes'),
              ),
            ],
          ),
    );
  }
}

