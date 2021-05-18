import 'package:books_and_movies/database/db.dart';
import 'package:books_and_movies/model/book.dart';
import 'package:firebase_auth/firebase_auth.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:firebase_database/firebase_database.dart';

class BookRepository {
  static final DatabaseReference _dbReference = Db().reference;
  static final String? _uid = FirebaseAuth.instance.currentUser?.uid;

  static Query getBooks() {
    return _dbReference.child('$_uid').child('book');
  }

  static Query searchBooks() {
    return _dbReference.child('$_uid').child('book');
  }

  static void deleteBook(String bookId) {
    _dbReference.child('$_uid').child('book').child(bookId).remove();
  }

  static void updateBook(Book book, String bookId) {
    _dbReference.child('$_uid').child('book').child(bookId).set(book.toJson());
  }

  static Future<void> addBook(Book book) async {
    _dbReference.child('$_uid').child('book').push().set(book.toJson());
  }
}
