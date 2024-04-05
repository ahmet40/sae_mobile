import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../main.dart';
import '../modele/modele_supabase/bd/utilistaeurService.dart';
import '../modele/modele_supabase/file/Utilisateur.dart';
import 'connexion.dart';


class Inscription extends StatelessWidget {
  const Inscription({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const InscriptionPage(),
    );
  }
}



class InscriptionPage extends StatefulWidget {
  const InscriptionPage({Key? key}) : super(key: key);

  @override
  _InscriptionState createState() => _InscriptionState();
}

class _InscriptionState extends State<InscriptionPage> {
  late Future<List<Utilisateur>> _utilisateursFuture;

  // Contrôleurs pour les champs de texte
  TextEditingController _nomUtilisateurController = TextEditingController();
  TextEditingController _mailUtilisateurController = TextEditingController();
  TextEditingController _motDePasseController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _utilisateursFuture = UtilisateurService().recupererTousLesUtilisateurObjet();
  }

  void inscrireUnUtilsiateur(String nomUtilisateur, String mailUtilisateur, String motDePasse) {
    _utilisateursFuture.then((listeUtilisateurs) {
      for (var utilisateur in listeUtilisateurs) {
        if (utilisateur.nom == nomUtilisateur || utilisateur.mail == mailUtilisateur) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Nom d\'utilisateur ou mail déjà utilisé'),
            ),
          );
          return;
        }
      }
      UtilisateurService().insererUnUtilisateur(nomUtilisateur, mailUtilisateur, motDePasse);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Connexion()),
      );
    });

  }

        @override
        Widget build(BuildContext context) {
          return Scaffold(
            appBar: AppBar(
              title: Text('Inscription'),
            ),
            body: Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextField(
                    controller: _nomUtilisateurController,
                    decoration: InputDecoration(
                      labelText: 'Nom d\'utilisateur',
                    ),
                  ),
                  TextField(
                    controller: _mailUtilisateurController,
                    decoration: InputDecoration(
                      labelText: 'Mail',
                    ),
                  ),
                  TextField(
                    controller: _motDePasseController,
                    decoration: InputDecoration(
                      labelText: 'Mot de passe',
                    ),
                    obscureText: true,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      inscrireUnUtilsiateur(_nomUtilisateurController.text,
                          _mailUtilisateurController.text,
                          _motDePasseController.text);
                    },
                    child: Text('Inscription'),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Connexion(),
                        ),
                      );
                    },
                    child: Text('Connexion'),
                  ),
                ],
              ),
            ),
          );
        }
      }