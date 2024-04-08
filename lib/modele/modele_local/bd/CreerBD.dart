import 'package:sae/modele/modele_local/file/Produit.dart';
import '../file/Creer.dart';
import 'database.dart';

class CreerBD {
  final tableName = 'Creer';

  Future<List<Creer>> getAllCreer() async {
    final db = await DatabaseService.instance.database;
    final result = await db.rawQuery('SELECT * FROM $tableName');
    return result.map((data) => Creer.fromSqfliteDatabase(data)).toList();
  }

  Future<void> creationCreer(int idUtilisateur, int idAnnonce) async {
    final db = await DatabaseService.instance.database;
    // Utiliser une requête REPLACE INTO pour éviter les doublons de clés primaires
    await db.rawInsert('''
      REPLACE INTO $tableName(idUtilisateur, idAnnonce) VALUES($idUtilisateur, $idAnnonce)
    ''');
  }

  Future<void> deleteCreer(int idUtilisateur, int idAnnonce) async {
    final db = await DatabaseService.instance.database;
    await db.rawDelete('''
      DELETE FROM $tableName WHERE idUtilisateur = ? AND idAnnonce = ?
    ''', [idUtilisateur, idAnnonce]);
  }


}
