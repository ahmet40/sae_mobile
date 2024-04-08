import 'package:sae/modele/modele_local/bd/CategorieBD.dart';

import '../file/Annonce.dart';
import 'database.dart';

class AnnonceBD{
  final tableName='Annonce';

  Future<List<Annonce>> getAnnonceByProduit(int id) async {
    final db = await DatabaseService.instance.database;
    final result = await db.rawQuery('SELECT * FROM $tableName WHERE idProduit=$id');
    return result.map((data) => Annonce.fromSqfliteDatabase(data)).toList();
  }



  Future<List<Annonce>> getAllAnnonces() async {
    final db = await DatabaseService.instance.database;
    final result = await db.rawQuery('SELECT * FROM $tableName');
    for (var i = 0; i < result.length; i++) {
      // affiche chaque composant
      print(result[i]['titre']);
      print(result[i]['description']);
      print(result[i]['idCategorie']);
      print(result[i]['dateDebut']);
      print(result[i]['dateFin']);
    }
    return result.map((data) => Annonce.fromSqfliteDatabase(data)).toList();
  }


  Future<int> creationAnnonce(String titre, String description, String? idCategorie, DateTime? dateDebut, DateTime? dateFin) async {
    final db = await DatabaseService.instance.database;
    // on prend l'id de la categorie par rapport a son nom
    var idCategorieBD = await db.rawQuery('SELECT * FROM Categorie WHERE nomC="$idCategorie"');

    if (idCategorieBD.isEmpty) {
      throw Exception('Catégorie introuvable');
    }

    var result = await db.rawQuery('SELECT MAX(id) AS max_id FROM $tableName');
    int maxId = result[0]['max_id'] as int? ?? 0;
    int newId = maxId + 1;

    await db.rawInsert('''
    INSERT INTO $tableName(id, titre, description, idCategorie, dateDebut, dateFin) VALUES($newId, '$titre', '$description', ${idCategorieBD[0]['id']}, '$dateDebut', '$dateFin')
  ''');

    return newId;
  }


  Future<List<Annonce>> getAnnoncesByUtilisateur(int idUtilisateur) async {
    final db = await DatabaseService.instance.database;
    final result = await db.rawQuery('''
    SELECT * FROM $tableName
    INNER JOIN Creer ON $tableName.id = Creer.idAnnonce
    WHERE Creer.idUtilisateur = $idUtilisateur
  ''');

    if (result.isEmpty) {
      return []; // Retourne une liste vide si aucun enregistrement n'est trouvé
    }

    return result.map((data) => Annonce.fromSqfliteDatabase(data)).toList();
  }

  Future<void> deleteAnnonce(int idAnnonce) async {
    final db = await DatabaseService.instance.database;
    await db.rawDelete('''
      DELETE FROM $tableName WHERE id = ?
    ''', [idAnnonce]);
  }

}