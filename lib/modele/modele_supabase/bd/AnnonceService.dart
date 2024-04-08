import '../../../main.dart';
import '../file/AnnonceS.dart';

class AnnonceService {
  // Récupérer toutes les annonces depuis la base de données Supabase
  Future<List<AnnonceS>> recupererToutesLesAnnonces() async {
    final response = await supabase.from('ANNONCE').select();

    List<AnnonceS> listeAnnonces = [];
    for (var i = 0; i < response.length; i++) {
      listeAnnonces.add(AnnonceS(
        idA: response[i]['idA'],
        titreA: response[i]['titreA'],
        descriptionA: response[i]['descriptionA'],
        idCategorie: response[i]['idCategorie'],
        dateDebut: DateTime.parse(response[i]['dateDebut']),
        dateFin: DateTime.parse(response[i]['dateFin']),
      ));
    }
    return listeAnnonces;
  }


  Future<int> recupererDernierIdAnnonce() async {
    final response = await supabase
        .from('ANNONCE')
        .select('idA')
        .order('idA', ascending: false);


    if (response.isEmpty) {
      // S'il n'y a pas d'annonce, renvoyer l'indice 1
      return 0;
    }

    // Initialiser la variable pour stocker le maximum
    int maxId = 0;

    // Parcourir les données pour trouver le maximum
    for (var i = 0; i < response.length; i++) {
      int currentId = response[i]['idA'] as int;
      if (currentId > maxId) {
        maxId = currentId;
      }
    }

    return maxId;
  }


  // Insérer une nouvelle annonce dans la base de données Supabase
  Future<int> insererUneAnnonce(AnnonceS nouvelleAnnonce) async {

    int dernierId = await recupererDernierIdAnnonce();
    print('--------------------------------------------');

    print(dernierId);
    int nouvelId = dernierId + 1;

    // Formater les dates au bon format
    String dateDebutFormatted = nouvelleAnnonce.dateDebut.toIso8601String().substring(0, 19);
    String dateFinFormatted = nouvelleAnnonce.dateFin.toIso8601String().substring(0, 19);

    final response = await supabase.from('ANNONCE').insert([
      {
        'idA': nouvelId,
        'titreA': nouvelleAnnonce.titreA,
        'descriptionA': nouvelleAnnonce.descriptionA,
        'idCategorie': nouvelleAnnonce.idCategorie,
        'dateDebut': dateDebutFormatted,
        'dateFin': dateFinFormatted,
      }
    ]);


    print('Annonce insérée avec succès. Nouvel ID: $nouvelId');
    return nouvelId;
  }



  // Méthode pour récupérer toutes les annonces d'un utilisateur spécifique
  Future<List<AnnonceS>> recupererAnnoncesNonUtilisateur(int idUtilisateur) async {
    // Récupérer les IDs des annonces non associées à l'utilisateur dans la table CREER
    final responseIds = await supabase
        .from('CREER')
        .select('idA')
        .neq('idU', idUtilisateur);

    // Extraire les IDs des annonces
    final List<int> annonceIds = responseIds.map((row) => row['idA'] as int).toList();

    List<AnnonceS> listeAnnonces = [];

    for (int idAnnonce in annonceIds) {
      final responseAnnonce = await supabase
          .from('ANNONCE')
          .select()
          .eq('idA', idAnnonce)
          .single(); // Ajoutez .single() pour obtenir une seule annonce

      // Convertir les données récupérées en objet AnnonceS et ajouter à la liste
      AnnonceS annonce = AnnonceS(
        idA: responseAnnonce['idA'] as int,
        titreA: responseAnnonce['titreA'] as String,
        descriptionA: responseAnnonce['descriptionA'] as String,
        idCategorie: responseAnnonce['idCategorie'] as int,
        dateDebut: DateTime.parse(responseAnnonce['dateDebut']),
        dateFin: DateTime.parse(responseAnnonce['dateFin']),
      );

      listeAnnonces.add(annonce);
    }

    return listeAnnonces;
  }

  // Récupérer les annonces dont l'ID utilisateur correspond
  Future<List<AnnonceS>> recupererAnnoncesUtilisateur(int idUtilisateur) async {
    // Récupérer les IDs des annonces associées à l'utilisateur dans la table CREER
    final responseIds = await supabase
        .from('CREER')
        .select('idA')
        .eq('idU', idUtilisateur);

    // Extraire les IDs des annonces
    final List<int> annonceIds = responseIds.map((row) => row['idA'] as int).toList();

    List<AnnonceS> listeAnnonces = [];

    for (int idAnnonce in annonceIds) {
      final responseAnnonce = await supabase
          .from('ANNONCE')
          .select()
          .eq('idA', idAnnonce)
          .single(); // Ajoutez .single() pour obtenir une seule annonce

      // Convertir les données récupérées en objet AnnonceS et ajouter à la liste
      AnnonceS annonce = AnnonceS(
        idA: responseAnnonce['idA'] as int,
        titreA: responseAnnonce['titreA'] as String,
        descriptionA: responseAnnonce['descriptionA'] as String,
        idCategorie: responseAnnonce['idCategorie'] as int,
        dateDebut: DateTime.parse(responseAnnonce['dateDebut']),
        dateFin: DateTime.parse(responseAnnonce['dateFin']),
      );

      listeAnnonces.add(annonce);
    }


    return listeAnnonces;
  }

  Future<void> supprimerAnnonce(int idAnnonce) async {

    final response = await supabase
        .from('CREER')
        .delete()
        .eq('idA', idAnnonce);


    final response2 = await supabase
        .from('ANNONCE')
        .delete()
        .eq('idA', idAnnonce);

    if (response2.error != null) {
      // Gérer l'erreur de suppression
      throw Exception('Erreur lors de la suppression de l\'annonce : ${response.error}');
    } else {
      print('Annonce avec ID $idAnnonce supprimée avec succès.');
    }
  }


// Ajoutez d'autres méthodes pour récupérer, mettre à jour ou supprimer des annonces si nécessaire
}