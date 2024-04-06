class Annonce{
  final int id;
  final String titre;
  final String description;
  final int idCategorie;
  final String dateDebut;
  final String dateFin;

  Annonce({required this.id, required this.titre, required this.description, required this.idCategorie, required this.dateDebut, required this.dateFin});

  get getId => id;
  get getTitre => titre;
  get getDescription => description;
  get getIdCategorie => idCategorie;
  get getDateDebut => dateDebut;
  get getDateFin => dateFin;

  factory Annonce.fromSqfliteDatabase(Map<String, dynamic> data) => Annonce(
    id: data['id'],
    titre: data['titre'],
    description: data['description'],
    idCategorie: data['idCategorie'],
    dateDebut: data['dateDebut'],
    dateFin: data['dateFin']
  );
}