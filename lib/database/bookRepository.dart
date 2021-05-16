import 'package:books_and_movies/database/db.dart';
import 'package:books_and_movies/model/book.dart';
import 'package:firebase_auth/firebase_auth.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:firebase_database/firebase_database.dart';

class BookRepository {
  final DatabaseReference _dbReference = Db().reference;
  final String? uid = FirebaseAuth.instance.currentUser?.uid;


  Query getBooks() {
      return _dbReference.child('$uid').child('book');
  }

  Future<void> addBook(Book book) async {
    print("AddBooks");
    print(_dbReference.path);
    _dbReference.child('$uid').child('book').push().set(book.toJson());
    print(_dbReference.path);
  }
}
