class Annonce{
  final int id;
  final String titre;
  final String description;
  final String dateDebut;
  final String dateFin;
  final int idProduit;

  Annonce({required this.id, required this.titre, required this.description, required this.dateDebut, required this.dateFin, required this.idProduit});

  get getId => id;
  get getTitre => titre;
  get getDescription => description;
  get getDateDebut => dateDebut;
  get getDateFin => dateFin;
  get getIdProduit => idProduit;
}