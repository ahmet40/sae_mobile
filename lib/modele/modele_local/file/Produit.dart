class Produit{
  final int id;
  final String nom;
  final int idCategorie;

  Produit({required this.id, required this.nom, required this.idCategorie});
  get getId => id;
  get getNom => nom;
  get getIdCategorie => idCategorie;

}