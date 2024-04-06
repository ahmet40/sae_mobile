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

  Future<String> get fullPath async{
    return join(await getDatabasesPath(), 'dat.db');
  }

  Future<Database> _initialize() async {
    final path= await fullPath;
    var database = await openDatabase(path, version: 1, onCreate: create);
    return database;
  }

  Future<void> create(Database db, int version) async {
    try {
        // Create the table
        await db.execute('''
          CREATE TABLE Categorie(
            id INTEGER PRIMARY KEY,
            nomC TEXT
          );
        ''');
        await db.execute('''
          CREATE TABLE Produit(
            id INTEGER PRIMARY KEY,
            nom TEXT,
            idCategorie INTEGER,
            statut TEXT,
            FOREIGN KEY (idCategorie) REFERENCES Categorie(id)
          );
        ''');
        await db.execute('''
          CREATE TABLE Annonce(
            id INTEGER PRIMARY KEY,
            titre TEXT,
            description TEXT,
            idCategorie INTEGER,
            dateDebut TEXT,
            dateFin TEXT,
            FOREIGN KEY (idCategorie) REFERENCES Categorie(id)
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

        await db.rawInsert('''
          INSERT INTO Annonce(id, titre, description, idCategorie, dateDebut, dateFin) VALUES(1, 'Annonce 1', 'Description annonce 1', 1, '2021-10-10', '2021-10-20')
        ''');
    } catch (e) {
      // Handle the error here
      log(e.toString());

    }
  }
}