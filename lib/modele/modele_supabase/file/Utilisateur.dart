class Utilisateur{
  final int id;
  final String nom;
  final String mail;
  final String motDePasse;

  Utilisateur({required this.id, required this.nom, required this.mail, required this.motDePasse});

  get getId => id;
  get getNom => nom;
  get getMail => mail;
  get getMotDePasse => motDePasse;
}