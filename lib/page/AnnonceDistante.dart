import 'package:flutter/material.dart';
import '../modele/modele_supabase/file/AnnonceS.dart';
import '../modele/modele_supabase/bd/AnnonceService.dart';
import 'ajouterAnnonce.dart';
import '../modele/User/UtilisateurConnexion.dart';
import '../modele/modele_supabase/bd/utilistaeurService.dart';
import '../modele/modele_supabase/file/Utilisateur.dart';

class AnnonceDisante extends StatefulWidget {
  const AnnonceDisante({Key? key}) : super(key: key);

  @override
  _AnnonceDisanteState createState() => _AnnonceDisanteState();
}

class _AnnonceDisanteState extends State<AnnonceDisante> {
  late Future<List<AnnonceS>> _annoncesUtilisateur;
  late Future<List<AnnonceS>> _annoncesNonUtilisateur;
  late UtilisateurService _utilisateurService;

  @override
  void initState() {
    super.initState();
    _utilisateurService = UtilisateurService();
    _chargerAnnonces();
  }

  Future<void> _chargerAnnonces() async {
    int utilisateurId = UtilisateurConnecte.utilisateur!.getId;

    setState(() {
      _annoncesUtilisateur = AnnonceService().recupererAnnoncesUtilisateur(utilisateurId);
      _annoncesNonUtilisateur = AnnonceService().recupererAnnoncesNonUtilisateur(utilisateurId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Annonces en ligne'),
      ),
      body: Column(
        children: [
          _buildAnnoncesList(_annoncesUtilisateur, 'Mes annonces en ligne', true), // true pour indiquer que ce sont vos annonces
          SizedBox(height: 16), // Réduire l'espacement entre les deux sections
          _buildAnnoncesList(_annoncesNonUtilisateur, 'Annonces en ligne', false), // false pour indiquer que ce ne sont pas vos annonces
        ],
      ),
    );
  }

  Widget _buildAnnoncesList(Future<List<AnnonceS>> annoncesFuture, String title, bool isMesAnnonces) {
    return FutureBuilder<List<AnnonceS>>(
      future: annoncesFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Text('Erreur: ${snapshot.error}');
        } else {
          List<AnnonceS>? annonces = snapshot.data;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        title,
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                    ),
                  ],
                ),
              ),
              if (annonces != null && annonces.isNotEmpty)
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: annonces.length,
                  itemBuilder: (context, index) {
                    AnnonceS annonce = annonces[index];
                    return FutureBuilder<Utilisateur>(
                      future: _utilisateurService.trouverUtilisateurParAnnonceId(annonce.getIdA),
                      builder: (context, utilisateurSnapshot) {
                        if (utilisateurSnapshot.connectionState == ConnectionState.waiting) {
                          return Center(child: CircularProgressIndicator());
                        } else if (utilisateurSnapshot.hasError) {
                          return Text('Erreur: ${utilisateurSnapshot.error}');
                        } else {
                          Utilisateur? utilisateur = utilisateurSnapshot.data;
                          return ListTile(
                            title: Text('${utilisateur?.nom ?? 'Utilisateur inconnu'} - ${annonce.getTitreA}'),
                            subtitle: Text(annonce.getDescriptionA),
                            trailing: isMesAnnonces ? IconButton(
                              onPressed: () {
                                _supprimerAnnonce(annonce.getIdA); // Supprimer l'annonce
                              },
                              icon: Icon(Icons.delete),
                            ) : null,
                          );
                        }
                      },
                    );
                  },
                )
              else
                Center(child: Text('Aucune annonce trouvée pour cet utilisateur.')),
            ],
          );
        }
      },
    );
  }

  void _supprimerAnnonce(int annonceId) {
    AnnonceService().supprimerAnnonce(annonceId);
    int utilisateurId = UtilisateurConnecte.utilisateur!.getId;

    setState(() {
      _annoncesUtilisateur = AnnonceService().recupererAnnoncesUtilisateur(utilisateurId);
      _annoncesNonUtilisateur = AnnonceService().recupererAnnoncesNonUtilisateur(utilisateurId);
    });
  }
}
