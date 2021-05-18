import 'package:books_and_movies/database/db.dart';
import 'package:books_and_movies/model/movie.dart';
import 'package:firebase_auth/firebase_auth.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:firebase_database/firebase_database.dart';

class MovieRepository {
  static final DatabaseReference _dbReference = Db().reference;
  static final String? _uid = FirebaseAuth.instance.currentUser?.uid;

  void getMovies() {
    //TODO get users books
    try {
      _dbReference
          .child('$_uid')
          .child('movie')
          .once()
          .then((DataSnapshot snapshot) {
        print('Connected to second database and read ${snapshot.value}');
      });
    } catch (e) {
      print(e);
    }
  }

  static void deleteMovie(String movieId) {
    _dbReference.child('$_uid').child('movie').child(movieId).remove();
  }

  static Future<void> addMovie(Movie movie) async {
    _dbReference.child('$_uid').child('movie').push().set(movie.toJson());
    print(_dbReference.path);
  }
}
