
import '../../../main.dart';
import '../file/Categorie.dart';

class CategorieService {

  Future<List<Categorie>> recupererToutesLesCategories() async {
    final response = await supabase.from('CATEGORIE').select();

    List<Categorie> listeCategories = [];
    for (var i = 0; i < response.length; i++) {
      listeCategories.add(Categorie(
        idC: response[i]['idC'],
        nomC: response[i]['nomC'],
      ));
    }
    return listeCategories;
  }

  // Récupérer le dernier ID de catégorie inséré
  Future<int> recupererDernierIdCategorie() async {
    try {
      final response = await supabase
          .from('CATEGORIE')
          .select('idC');

      if (response.isEmpty) {
        return 0;
      }

      int maxId = 0;
      for (var i = 0; i < response.length; i++) {
        int currentId = response[i]['idC'] as int;
        if (currentId > maxId) {
          maxId = currentId;
        }
      }

      return maxId;
    } catch (e) {
      throw Exception('Erreur lors de la récupération du dernier ID de catégorie: $e');
    }
  }



  // Insérer une nouvelle catégorie dans la base de données Supabase
  Future<void> insererUneCategorie(String nomCategorie) async {
    int dernierId = await recupererDernierIdCategorie();
    int nouvelId = dernierId + 1;

    final response = await supabase.from('CATEGORIE').insert([
      {
        'idC': nouvelId,
        'nomC': nomCategorie,
      }
    ]);

  }

// Ajoutez d'autres méthodes pour récupérer, mettre à jour ou supprimer des catégories si nécessaire
}
