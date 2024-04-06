import 'package:sae_mobile/modele/modele_local/bd/CategorieBD.dart';

import '../file/Annonce.dart';
import 'database.dart';

class AnnonceBD{
  final tableName='Annonce';

  Future<List<Annonce>> getAnnonceByProduit(int id) async {
    final db = await DatabaseService.instance.database;
    final result = await db.rawQuery('SELECT * FROM $tableName WHERE idProduit=$id');
    return result.map((data) => Annonce.fromSqfliteDatabase(data)).toList();
  }



  Future<List<Annonce>> getAllAnnoces() async {
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


  Future<void> creationAnnonce(titire, description,idCategorie, dateDebut, dateFin) async {
    final db = await DatabaseService.instance.database;
    // on va récuperer le max id de la table annonce
    var result = await getAllAnnoces();
    print("ddd");
    print(result.length);

    int id = result.length+1;
    if (titire == '' || description == '' || idCategorie == null || dateDebut == null || dateFin == null) {
      return;
    }
    // on verifie si l'annonce existe deja
    for (var i = 0; i < result.length; i++) {
      if(result[i].titre==titire){
        return;
      }
    }

    // on prend l'id de la categorie par rapport a son nom
    var idCategorieBD = await db.rawQuery('SELECT * FROM Categorie WHERE nomC="$idCategorie"');
    print(idCategorieBD[0]['id']);
    await db.rawInsert('''
      INSERT INTO $tableName(id, titre, description, idCategorie, dateDebut, dateFin) VALUES($id, '$titire', '$description', ${idCategorieBD[0]['id']}, '$dateDebut', '$dateFin')
    ''');

  }
}