import '../../modele_local/file/Annonce.dart';

class AnnonceS {
  final int idA;
  final String titreA;
  final String descriptionA;
  final int idCategorie;
  final DateTime dateDebut;
  final DateTime dateFin;

  AnnonceS({
    required this.idA,
    required this.titreA,
    required this.descriptionA,
    required this.idCategorie,
    required this.dateDebut,
    required this.dateFin,
  });

  int get getIdA => idA;
  String get getTitreA => titreA;
  String get getDescriptionA => descriptionA;
  int get getIdCategorie => idCategorie;
  DateTime get getDateDebut => dateDebut;
  DateTime get getDateFin => dateFin;

  static AnnonceS fromAnnonce(Annonce annonce) {
    return AnnonceS(
      idA: annonce.id,
      titreA: annonce.titre,
      descriptionA: annonce.description,
      idCategorie: annonce.idCategorie,
      dateDebut: annonce.dateDebut,
      dateFin: annonce.dateFin,
    );
  }
}
