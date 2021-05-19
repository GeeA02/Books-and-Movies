import 'package:books_and_movies/database/db.dart';
import 'package:books_and_movies/model/book.dart';
import 'package:firebase_auth/firebase_auth.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:firebase_database/firebase_database.dart';

class BookRepository {
  static final String? _uid = FirebaseAuth.instance.currentUser?.uid;

  static Query getBooks() {
    return Db().reference.child('$_uid').child('book');
  }

  static void deleteBook(String bookId) {
    Db().reference.child('$_uid').child('book').child(bookId).remove();
  }

  static void updateBook(Book book, String bookId) {
    Db()
        .reference
        .child('$_uid')
        .child('book')
        .child(bookId)
        .set(book.toJson());
  }

  static Future<void> addBook(Book book) async {
    Db().reference.child('$_uid').child('book').push().set(book.toJson());
  }
}
