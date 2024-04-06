import 'package:flutter/material.dart';

import '../modele/modele_local/bd/CategorieBD.dart';
import '../modele/modele_local/file/Categorie.dart';
import 'PageProduit.dart';

class ChoisirCategorie extends StatefulWidget {
  const ChoisirCategorie({Key? key}) : super(key: key);

  @override
  _ChoisirCategorieState createState() => _ChoisirCategorieState();
}

class _ChoisirCategorieState extends State<ChoisirCategorie> {
  late Future<List<Categorie>> _categoriesFuture;

  @override
  void initState() {
    super.initState();
    _categoriesFuture = CategorieBD().getAll();
    // afficher le nom de la categorie
    _categoriesFuture.then((value) {
      for (var i = 0; i < value.length; i++) {
        print(value[i].nomC);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Choisir une catégorie'),
      ),
      body: FutureBuilder<List<Categorie>>(
        future: _categoriesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Erreur: ${snapshot.error}'));
          }
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    final categorie = snapshot.data![index];
                    return ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PageProduit(nomCategorie: categorie.nomC),
                          ),
                        );
                      },
                      child: Text(categorie.nomC),
                    );
                  },
                ),
              ),
              ElevatedButton(
                onPressed: () => _ajouterCategorie(context),
                child: Text('Ajouter une catégorie'),
              ),
            ],
          );
        },
      ),
    );
  }

  void _ajouterCategorie(BuildContext context) {
    String nouvelleCategorie = '';
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Ajouter une catégorie'),
          content: TextField(
            onChanged: (value) {
              nouvelleCategorie = value;
            },
            decoration: InputDecoration(hintText: 'Nom de la catégorie'),
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
                CategorieBD().creeCategorie(nouvelleCategorie);
                Navigator.of(context).pop();
                // Rafraîchir la liste des catégories après l'ajout
                setState(() {
                  _categoriesFuture = CategorieBD().getAll();
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
