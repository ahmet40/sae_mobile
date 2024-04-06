import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sae_mobile/modele/modele_local/file/Annonce.dart';
import '../modele/modele_local/bd/AnnonceBD.dart';
import 'ajouterAnnonce.dart';

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
    _annonceLocal = AnnonceBD().getAllAnnoces();
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
            return Center(
              child: Text('Erreur lors du chargement des données'),
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
                          title: Text(annonce.titre),
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

  void _ajouterAnnonce(BuildContext context) {
    // Envoyer vers AjouterAnnonce
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AjouterAnnonce()),
    );
  }
}
