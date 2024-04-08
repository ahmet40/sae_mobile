import 'package:sae/modele/modele_local/file/Categorie.dart';

import 'database.dart';

class CategorieBD {
  final tableName = 'Categorie';

  Future<List<Categorie>> getAll() async {
    final db = await DatabaseService.instance.database;
    final result = await db.rawQuery('SELECT * FROM $tableName');
    List<Categorie> categories = [];
    for (var i = 0; i < result.length; i++) {
      categories.add(Categorie.fromSqfliteDatabase(result[i]));
    }
    return categories;
  }

  Future<List<String>> getAllName() async {
    final db = await DatabaseService.instance.database;
    final result = await db.rawQuery('SELECT * FROM $tableName');
    List<String> nomC = [];
    for (var i = 0; i < result.length; i++) {
      print(result[i]['nomC']);
      // ajouter un cast pour que le nom soit de type String
      nomC.add(result[i]['nomC'] as String);
    }
    return nomC;
  }

  Future<void> creeCategorie(nom) async {
    final db = await DatabaseService.instance.database;
    var resultat= await getAll();
    int id = resultat.length+1;
    // on verifie si la categorie existe deja
    for (var i = 0; i < resultat.length; i++) {
      if(resultat[i].nomC==nom){
        return;
      }
    }
    if (nom =='') {
      return;
    }
    await db.rawInsert('''
      INSERT INTO $tableName(id, nomC) VALUES($id, '$nom')
    ''');
  }

  Future<int> getIdCategorie(nom) async {
    final db = await DatabaseService.instance.database;
    final result = await db.rawQuery('SELECT * FROM $tableName WHERE nomC="$nom"');
    return result[0]['id'] as int;
  }
}