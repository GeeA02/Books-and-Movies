import 'package:books_and_movies/database/db.dart';
import 'package:books_and_movies/model/movie.dart';
import 'package:firebase_auth/firebase_auth.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:firebase_database/firebase_database.dart';

class MovieRepository {
  static final String? _uid = FirebaseAuth.instance.currentUser?.uid;

  static Query getMovies() {
    return Db().reference.child('$_uid').child('movie');
  }

  static void deleteMovie(String movieId) {
    Db().reference.child('$_uid').child('movie').child(movieId).remove();
  }

  static void updateMovie(Movie movie, String movieId) {
    Db()
        .reference
        .child('$_uid')
        .child('movie')
        .child(movieId)
        .set(movie.toJson());
  }

  static Future<void> addMovie(Movie movie) async {
    Db().reference.child('$_uid').child('movie').push().set(movie.toJson());
  }
}
