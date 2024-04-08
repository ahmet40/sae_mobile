import '../../../main.dart';
import '../file/Creer.dart';

class CreerService {
  // Récupérer tous les liens depuis la base de données Supabase
  Future<List<Creer>> recupererTousLesLiens() async {
    final response = await supabase.from('CREER').select();

    List<Creer> listeLiens = [];
    for (var i = 0; i < response.length; i++) {
      listeLiens.add(Creer(
        idU: response[i]['idU'],
        idA: response[i]['idA'],
      ));
    }
    return listeLiens;
  }

  // Insérer un nouveau lien dans la base de données Supabase
  Future<void> insererUnLien(Creer nouveauLien) async {
    final response = await supabase.from('CREER').insert([
      {
        'idU': nouveauLien.idU,
        'idA': nouveauLien.idA,
      }
    ]);
    // Vous pouvez ajouter ici des gestionnaires d'erreurs ou des validations supplémentaires si nécessaire
  }

// Ajoutez d'autres méthodes pour mettre à jour ou supprimer des liens si nécessaire
}
