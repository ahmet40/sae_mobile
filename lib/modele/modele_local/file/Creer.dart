class Creer {
  final int idUtilisateur;
  final int idAnnonce;

  Creer({required this.idUtilisateur, required this.idAnnonce});

  int get getIdUtilisateur => idUtilisateur;
  int get getIdAnnonce => idAnnonce;

  factory Creer.fromSqfliteDatabase(Map<String, dynamic> data) => Creer(
    idUtilisateur: data['idUtilisateur'],
    idAnnonce: data['idAnnonce'],
  );
}
