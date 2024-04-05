import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../modele/modele_supabase/bd/utilistaeurService.dart';
import '../modele/modele_supabase/file/Utilisateur.dart';
import 'MyApp.dart';
import 'inscription.dart';


class Connexion extends StatelessWidget {
  const Connexion({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const ConnexionPage(),
    );
  }
}



class ConnexionPage extends StatefulWidget {
  const ConnexionPage({Key? key}) : super(key: key);

  @override
  _ConnexionState createState() => _ConnexionState();
}

class _ConnexionState extends State<ConnexionPage> {
  late Future<List<Utilisateur>> _utilisateursFuture;

  // Contrôleurs pour les champs de texte
  TextEditingController _nomUtilisateurController = TextEditingController();
  TextEditingController _motDePasseController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _utilisateursFuture = UtilisateurService().recupererTousLesUtilisateurObjet();
  }

  void verifierUtilisateur(String nomUtilisateur, String motDePasse) {
    _utilisateursFuture.then((listeUtilisateurs) {
      for (var utilisateur in listeUtilisateurs) {
        if ((utilisateur.nom == nomUtilisateur || utilisateur.mail == nomUtilisateur) && utilisateur.motDePasse == motDePasse) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const MyApp()),
          );
          return;
        }
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Nom d\'utilisateur ou mot de passe incorrect'),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Connexion'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _nomUtilisateurController, // Utilisation du contrôleur
              decoration: InputDecoration(
                labelText: 'Nom d\'utilisateur',
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _motDePasseController, // Utilisation du contrôleur
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Mot de passe',
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Récupérer les valeurs des champs de texte
                String nomUtilisateur = _nomUtilisateurController.text;
                String motDePasse = _motDePasseController.text;
                // Utiliser les valeurs pour vérifier l'utilisateur
                verifierUtilisateur(nomUtilisateur, motDePasse);
              },
              child: Text('Se connecter'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Inscription(),
                  ),
                );
              },
              child: Text('S\'inscrire'),
            ),
          ],
        ),
      ),
    );
  }
}
