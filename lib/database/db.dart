// ignore: import_of_legacy_library_into_null_safe
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class Db {
  static final Db _singleton = Db._internal();

  factory Db() => _singleton;

  Db._internal();

  final reference = FirebaseDatabase(databaseURL: env['DB_URL']).reference();
}
