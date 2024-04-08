import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sae/modele/modele_local/file/Annonce.dart';
import '../modele/modele_local/bd/AnnonceBD.dart';
import 'ajouterAnnonce.dart';
import '../modele/User/UtilisateurConnexion.dart';
import '../modele/modele_supabase/bd/AnnonceService.dart';
import '../modele/modele_supabase/bd/CreerService.dart';
import '../modele/modele_supabase/file/AnnonceS.dart';
import '../modele/modele_supabase/file/Creer.dart';


class AnnonceLocal extends StatefulWidget {
  const AnnonceLocal({Key? key}) : super(key: key);

  @override
  _AnnonceLocalState createState() => _AnnonceLocalState();
}

class _AnnonceLocalState extends State<AnnonceLocal>{
  late Future <List<Annonce>> _annonceLocal;

  @override
  void initState() {
    super.initState();
    int utilisateurId = UtilisateurConnecte.utilisateur!.getId;
    _annonceLocal = AnnonceBD().getAnnoncesByUtilisateur(utilisateurId);

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Annonces locales'),
      ),
      body: FutureBuilder<List<Annonce>>(
        future: _annonceLocal,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            // Afficher un message d'erreur spécifique
            return Center(
              child: Text('Erreur lors du chargement des données: ${snapshot.error}'),
            );
          } else {
            return Column(
              children: [
                if (snapshot.hasData && snapshot.data!.isEmpty)
                  Center(
                    child: Text('Aucune annonce disponible'),
                  )
                else
                  Expanded(
                    child: ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        final annonce = snapshot.data![index];
                        return ListTile(
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(annonce.titre),
                              ElevatedButton(
                                onPressed: () => _publierAnnonce(context, annonce),
                                child: Text('Publier'),
                              ),
                            ],
                          ),
                          subtitle: Text('Description: ${annonce.description}'),
                        );
                      },
                    ),
                  ),
                ElevatedButton(
                  onPressed: () => _ajouterAnnonce(context),
                  child: Text('Ajouter une annonce'),
                ),
              ],
            );
          }
        },
      ),
    );
  }


  void _publierAnnonce(BuildContext context, Annonce annonce) async {
    // Publier l'annonce et la supprimer de la base de données locale
    AnnonceS annonceS = AnnonceS.fromAnnonce(annonce);
    int newId = await AnnonceService().insererUneAnnonce(annonceS);
    await CreerService().insererUnLien(Creer(idU: UtilisateurConnecte.utilisateur!.getId, idA: newId));
    await AnnonceBD().deleteAnnonce(annonce.getId);
    setState(() {
      _annonceLocal = AnnonceBD().getAnnoncesByUtilisateur(UtilisateurConnecte.utilisateur!.getId);
    });
  }


  void _ajouterAnnonce(BuildContext context) {
    // Envoyer vers AjouterAnnonce
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AjouterAnnonce()),
    );

  }
}
