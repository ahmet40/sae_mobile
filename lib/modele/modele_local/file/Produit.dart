class Produit{
  final int id;
  final String nom;
  final int idCategorie;
  final String statut;

  Produit({required this.id, required this.nom, required this.idCategorie, required this.statut});
  get getId => id;
  get getNom => nom;
  get getIdCategorie => idCategorie;
  get getStatut => statut;

  factory Produit.fromSqfliteDatabase(Map<String, dynamic> data) => Produit(
    id: data['id'],
    nom: data['nom'],
    idCategorie: data['idCategorie'],
    statut: data['statut']
  );

}