
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../modele/modele_local/bd/AnnonceBD.dart';

class AnnonceDisante extends StatefulWidget {

  const AnnonceDisante({Key? key}) : super(key: key);

  @override
  _AnnonceDisanteState createState() => _AnnonceDisanteState();
}

class _AnnonceDisanteState extends State<AnnonceDisante>{
  late Future <List<AnnonceDisante>> _annonceDistante;

  @override
  void initState() {
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Annonces distantes'),
      ),
      body:  Column(
              children:[
                Expanded(
                  child: Text('Annonces distantes'),
                ),
              ],
            ),
    );

  }
}
