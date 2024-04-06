import 'package:flutter/material.dart';
import 'package:sae_mobile/page/ChoisirCategorie.dart';
import 'package:sae_mobile/page/choisirAnnonce.dart';
import 'PageProduit.dart';
import 'Accueil.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Nombre mystere',
      theme: ThemeData.dark(),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int numeroNavBarSelection = 0;

  @override
  void initState() {
    super.initState();
  }


  void _onItemTapped(int index) {
    setState(() {
      numeroNavBarSelection = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget pageSelectionnee;
    switch (numeroNavBarSelection) {
      case 0:
        pageSelectionnee = Accueil();
        break;
      case 1:
        pageSelectionnee = ChoisirCategorie();
        break;
      case 2:
        pageSelectionnee = ChoisirAnnonce();
        break;
      default:
        pageSelectionnee = Accueil();
    }
    return Scaffold(
      body: pageSelectionnee,
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Accueil',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            label: 'Catégories',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.production_quantity_limits),
            label: 'Annonces',
          ),
        ],
        currentIndex: numeroNavBarSelection,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}

