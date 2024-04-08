import 'dart:developer';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseService {
  static final DatabaseService instance = DatabaseService._init();
  static Database? _database;


  DatabaseService._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initialize();
    return _database!;
  }

  Future<String> get fullPath async {
    return join(await getDatabasesPath(), 'base_donnee.db');
  }

  Future<Database> _initialize() async {
    final path = await fullPath;
    var database = await openDatabase(path, version: 1, onCreate: create);
    return database;
  }

  Future<void> create(Database db, int version) async {
    try {
      // Create the table Categorie
      await db.execute('''
      CREATE TABLE IF NOT EXISTS Categorie(
        id INTEGER PRIMARY KEY,
        nomC TEXT
      );
    ''');

      // Create the table Produit
      await db.execute('''
      CREATE TABLE IF NOT EXISTS Produit(
        id INTEGER PRIMARY KEY,
        nom TEXT,
        idCategorie INTEGER,
        statut TEXT,
        FOREIGN KEY (idCategorie) REFERENCES Categorie(id)
      );
    ''');

      // Create the table Annonce
      await db.execute('''
      CREATE TABLE IF NOT EXISTS Annonce(
        id INTEGER PRIMARY KEY,
        titre TEXT,
        description TEXT,
        idCategorie INTEGER,
        dateDebut DATETIME,
        dateFin DATETIME,
        FOREIGN KEY (idCategorie) REFERENCES Categorie(id)
      );
    ''');

      // Create the table Creer
      await db.execute('''
      CREATE TABLE IF NOT EXISTS Creer(
        idUtilisateur INTEGER,
        idAnnonce INTEGER,
        PRIMARY KEY (idUtilisateur, idAnnonce),
        FOREIGN KEY (idUtilisateur) REFERENCES Utilisateur(id),
        FOREIGN KEY (idAnnonce) REFERENCES Annonce(id)
      );
    ''');

      // Insert some records
      await db.rawInsert('''
          INSERT INTO Categorie(id, nomC) VALUES(1, 'Informatique')
        ''');
      await db.rawInsert('''
          INSERT INTO Categorie(id, nomC) VALUES(2, 'Electromenager')
        ''');
      await db.rawInsert('''
          INSERT INTO Categorie(id, nomC) VALUES(3, 'Vetement')
        ''');
      await db.rawInsert('''
          INSERT INTO Categorie(id, nomC) VALUES(4, 'voiture')
        ''');

      await db.rawInsert('''
          INSERT INTO Produit(id, nom, idCategorie, statut) VALUES(1, 'Ordinateur', 1, 'disponible')
        ''');
      await db.rawInsert('''
          INSERT INTO Produit(id, nom, idCategorie, statut) VALUES(2, 'Refrigerateur', 2, 'disponible')
        ''');
      await db.rawInsert('''
          INSERT INTO Produit(id, nom, idCategorie, statut) VALUES(3, 'Pantalon', 3, 'disponible')
        ''');
      await db.rawInsert('''
          INSERT INTO Produit(id, nom, idCategorie, statut) VALUES(4, 'Souris', 3, 'disponible')
        ''');

      // Insert some records (if needed)
    } catch (e) {
      // Handle the error here
      log(e.toString());
    }
  }
}

