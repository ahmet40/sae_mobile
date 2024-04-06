class Categorie{
  final int id;
  final String nomC;

  Categorie({required this.id, required this.nomC});

  get getId => id;
  get getNomC => nomC;

  factory Categorie.fromSqfliteDatabase(Map<String, dynamic> data) => Categorie(
    id: data['id'],
    nomC: data['nomC']
  );

}