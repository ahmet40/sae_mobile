import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sae_mobile/modele/modele_local/bd/AnnonceBD.dart';
import 'package:sae_mobile/modele/modele_local/bd/CategorieBD.dart';
import 'package:sae_mobile/modele/modele_local/file/Categorie.dart';

class AjouterAnnonce extends StatefulWidget {
  @override
  _AjouterAnnonceState createState() => _AjouterAnnonceState();
}

class _AjouterAnnonceState extends State<AjouterAnnonce> {
  TextEditingController titreController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  String? _selectedCategorie;
  TextEditingController dateDebutController = TextEditingController();
  TextEditingController dateFinController = TextEditingController();

  DateTime? _selectedDateDebut;
  DateTime? _selectedDateFin;

  List<String> categories = [];

  @override
  void initState() {
    super.initState();
    _loadCategories();
  }

  // Fonction pour charger les catégories depuis la base de données
  void _loadCategories() async {
    List<String> loadedCategories = await CategorieBD().getAllName();
    setState(() {
      categories = loadedCategories;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ajouter une annonce'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            TextField(
              controller: titreController,
              decoration: InputDecoration(
                labelText: 'Titre',
              ),
            ),
            TextField(
              controller: descriptionController,
              decoration: InputDecoration(
                labelText: 'Description',
              ),
            ),
            DropdownButton<String>(
              value: _selectedCategorie,
              hint: Text('Sélectionner une catégorie'),
              onChanged: (String? value) {
                setState(() {
                  _selectedCategorie = value;
                });
              },
              items: categories.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            TextButton(
              onPressed: () => _selectDate(context, true),
              child: Text(
                _selectedDateDebut != null
                    ? 'Date de début: ${_selectedDateDebut!.toLocal()}'.split(' ')[0]
                    : 'Sélectionner la date de début',
              ),
            ),
            TextButton(
              onPressed: () => _selectDate(context, false),
              child: Text(
                _selectedDateFin != null
                    ? 'Date de fin: ${_selectedDateFin!.toLocal()}'.split(' ')[0]
                    : 'Sélectionner la date de fin',
              ),
            ),
            ElevatedButton(
              onPressed: () {
                _createAnnonce();
              },
              child: Text('Ajouter'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context, bool isStartDate) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != (isStartDate ? _selectedDateDebut : _selectedDateFin)) {
      setState(() {
        if (isStartDate) {
          _selectedDateDebut = picked;
          dateDebutController.text = picked.toString();
        } else {
          _selectedDateFin = picked;
          dateFinController.text = picked.toString();
        }
      });
    }
  }

  void _createAnnonce() {
    String titre = titreController.text;
    String description = descriptionController.text;
    String? categorie = _selectedCategorie; // Catégorie sélectionnée
    String dateDebut = _selectedDateDebut != null ? _selectedDateDebut.toString() : '';
    String dateFin = _selectedDateFin != null ? _selectedDateFin.toString() : '';

    if (titre.isNotEmpty && description.isNotEmpty && categorie != null && dateDebut.isNotEmpty && dateFin.isNotEmpty) {
      // on met la date de début et de fin au bon format string pour la base de données
      dateDebut = dateDebut.split(' ')[0];
      dateFin = dateFin.split(' ')[0];
      // on affiche le type de dateDebut et dateFin
      print('dateDebut: $dateDebut');
      print('dateFin: $dateFin');
      print('type de dateDebut: ${dateDebut.runtimeType}');
      print('type de dateFin: ${dateFin.runtimeType}');
      // Créer l'annonce
      AnnonceBD().creationAnnonce(
        titre,
        description,
        categorie,
        dateDebut,
        dateFin,
      ).then((value) {
        // Annonce ajoutée avec succès, retourner à la page précédente
        Navigator.pop(context);
      }).catchError((error) {
        // Gestion des erreurs lors de la création de l'annonce
        print('Erreur lors de la création de l\'annonce: $error');
        // Afficher une boîte de dialogue d'erreur ou un message d'erreur
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Erreur'),
            content: Text('Une erreur est survenue lors de la création de l\'annonce.'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('OK'),
              ),
            ],
          ),
        );
      });
    } else {
      // Afficher un message indiquant que les champs obligatoires doivent
      // être remplis
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Champs obligatoires'),
          content: Text('Veuillez remplir tous les champs obligatoires.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('OK'),
            ),
          ],
        ),
      );
    }
  }
}
