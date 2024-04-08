import '../../../main.dart';
import '../file/Utilisateur.dart';

class UtilisateurService {
  Future<List<String>> recupererTousLesUtilisateur() async {
    final response = await supabase.from('UTILISATEUR').select();

    List<String> listeUtilisateurs = [];
    for (var i = 0; i < response.length; i++) {
      listeUtilisateurs.add(response[i]['nom']);
    }
    return listeUtilisateurs;
  }

  Future<void> insererUnUtilisateur(
      String nomUtilisateur, String mailUtilisateur, String motDePasse) async {
    var listeUtilsiateur=await recupererTousLesUtilisateurObjet();
    var id=listeUtilsiateur.length+1;
    final response = await supabase.from('UTILISATEUR').insert([
      {'id':id, 'nom': nomUtilisateur, 'mail': mailUtilisateur, 'mot_de_passe': motDePasse}
    ]);
  }

  Future<List<Utilisateur>> recupererTousLesUtilisateurObjet() async {
    final response = await supabase.from('UTILISATEUR').select();

    List<Utilisateur> listeUtilisateurs = [];
    for (var i = 0; i < response.length; i++) {
      listeUtilisateurs.add(Utilisateur(
          id: response[i]['id'],
          nom: response[i]['nom'],
          mail: response[i]['mail'],
          motDePasse: response[i]['mot_de_passe']));
    }
    return listeUtilisateurs;
  }

  // Trouver l'utilisateur qui a posté une annonce à partir de l'ID de l'annonce
  Future<Utilisateur> trouverUtilisateurParAnnonceId(int annonceId) async {
    final response = await supabase
        .from('CREER')
        .select('idU')
        .eq('idA', annonceId)
        .single();

    final userId = response['idU'] as int?;
    if (userId == null) {
      print('Aucun utilisateur trouvé pour l\'annonce $annonceId');
      // Retourner un utilisateur par défaut ou fictif
      return Utilisateur(id: 0, nom: 'Utilisateur inconnu', mail: '', motDePasse: '');
    }

    // Récupérer tous les utilisateurs sous forme d'objets Utilisateur
    final users = await recupererTousLesUtilisateurObjet();

    // Rechercher l'utilisateur correspondant à l'ID
    final utilisateur = users.firstWhere((user) => user.id == userId, orElse: () {
      print('Utilisateur non trouvé pour l\'ID $userId');
      // Retourner un utilisateur par défaut ou fictif
      return Utilisateur(id: 0, nom: 'Utilisateur inconnu', mail: '', motDePasse: '');
    });

    return utilisateur;
  }

}
