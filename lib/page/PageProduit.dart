import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../modele/modele_local/bd/ProduitBD.dart';
import '../modele/modele_local/file/Produit.dart';

class PageProduit extends StatefulWidget {
  final String nomCategorie;
  const PageProduit({Key? key, required this.nomCategorie}) : super(key: key);
  @override
  _PageProduitState createState() => _PageProduitState();
}

class _PageProduitState extends State<PageProduit> {
  late Future<List<Produit >> _produitsFuture;

  @override
  void initState() {
    super.initState();
    _produitsFuture = ProduitBD().getProduitByCatetgorie(widget.nomCategorie);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Vos produits de la catégorie ${widget.nomCategorie}'),
      ),
      body: FutureBuilder<List<Produit>>(
        future: _produitsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Erreur lors du chargement des données'),
            );
          } else if (snapshot.hasData && snapshot.data!.isEmpty) {
            return Center(
              child: Text('Aucun produit disponible'),
            );
          } else {
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      final produit = snapshot.data![index];
                      return ListTile(
                        title: Text(produit.nom),
                        subtitle: Text('Statut: ${produit.statut}'),
                      );
                    },
                  ),
                ),
                ElevatedButton(
                  onPressed: () => _ajouterProduit(context),
                  child: const Text('Ajouter un produit'),
                ),
              ],
            );
          }
        },
      ),
    );
  }
  void _ajouterProduit(BuildContext context) {
    String nvProd = '';
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Ajouter un produit'),
          content: TextField(
            onChanged: (value) {
              nvProd = value;
            },
            decoration: InputDecoration(hintText: 'Nom produit'),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Annuler'),
            ),
            TextButton(
              onPressed: () {
                // Appeler la fonction pour créer la catégorie avec le nom saisi
                ProduitBD().creationProduit(nvProd, widget.nomCategorie, 'disponible');
                Navigator.of(context).pop();
                // Rafraîchir la liste des catégories après l'ajout
                setState(() {
                  _produitsFuture = ProduitBD().getProduitByCatetgorie(widget.nomCategorie);
                });
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
