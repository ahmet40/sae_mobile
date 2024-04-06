import 'package:sae_mobile/modele/modele_local/file/Produit.dart';

import 'database.dart';

class ProduitBD{
  final tableName='Produit';

  Future<List<Produit>> getProduitByCatetgorie(String nomCat) async {
    final db = await DatabaseService.instance.database;
    final result = await db.rawQuery('SELECT * FROM $tableName join Categorie on Produit.idCategorie=Categorie.id where Categorie.nomC="$nomCat"');
    for (var i = 0; i < result.length; i++) {
      // affiche le nom
      print(result[i]['nom']);
    }
    return result.map((data) => Produit.fromSqfliteDatabase(data)).toList();
  }

  Future<List<Produit>> getAllProduits() async {
    final db = await DatabaseService.instance.database;
    final result = await db.rawQuery('SELECT * FROM $tableName');
    return result.map((data) => Produit.fromSqfliteDatabase(data)).toList();
  }

  Future<void> creationProduit(nom, nomCategorie, statut) async {
    final db = await DatabaseService.instance.database;
    // on va récuperer le max id de la table produit
    var result = await getAllProduits();
    int id = result.length+1;
    await db.rawInsert('''
      INSERT INTO $tableName(id, nom, idCategorie, statut) VALUES($id, '$nom', (SELECT id FROM Categorie WHERE nomC="$nomCategorie"), '$statut')
    ''');

  }
}