import 'package:books_and_movies/database/db.dart';
import 'package:books_and_movies/model/movie.dart';
import 'package:firebase_auth/firebase_auth.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:firebase_database/firebase_database.dart';

class MovieRepository {
  final DatabaseReference _dbReference = Db().reference;
  final String? uid = FirebaseAuth.instance.currentUser?.uid;

  void getMovies() {
    //TODO get users books
    print("GetBooks");
    try {
      _dbReference
          .child('$uid')
          .child('movie')
          .once()
          .then((DataSnapshot snapshot) {
        print('Connected to second database and read ${snapshot.value}');
      });
    } catch (e) {
      print(e);
    }
  }

  Future<void> addMovie(Movie movie) async {
    print("AddBooks");
    print(_dbReference.path);
    _dbReference.child('$uid').child('movie').push().set(movie.toJson());
    print(_dbReference.path);
  }
}
