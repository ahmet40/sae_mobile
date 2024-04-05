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
}
