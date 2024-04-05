import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PageProduit extends StatefulWidget {
  @override
  _PageProduitState createState() => _PageProduitState();
}

class _PageProduitState extends State<PageProduit> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Liste des produits'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PageProduit(),
                  ),
                );
              },
              child: const Text('Produit 1'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PageProduit(),
                  ),
                );
              },
              child: const Text('Produit 2'),
            ),
          ],
        ),
      ),
    );
  }
}