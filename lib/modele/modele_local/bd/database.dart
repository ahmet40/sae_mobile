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
    return join(await getDatabasesPath(), 'sae-mobile.db');
  }

  Future<Database> _initialize() async {
    final path= await fullPath;
    var database = await openDatabase(path, version: 1, onCreate: create);
    return database;
  }

  Future<void> create(Database db, int version) async {
    try {
        // pass

    } catch (e) {
      // Handle the error here
      log(e.toString());

    }
  }
}