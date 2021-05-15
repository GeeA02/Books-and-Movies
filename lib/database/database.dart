import 'package:firebase_database/firebase_database.dart';

class Database {
  static Database _database;

  Database._();

  static Database getDatabase() {
    if (_database == null) _database = Database._();
    return _database;
  }

  static final instance = FirebaseDatabase.instance;
}
