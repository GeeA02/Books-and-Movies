import 'package:books_and_movies/model/book.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class BookRepository {
  final _dbReference = FirebaseDatabase.instance.reference();
  final String uid = FirebaseAuth.instance.currentUser.uid;

  List<Book> GetBooks() {
    //TODO get users books
    print("GetBooks");
    try {
      _dbReference
          .child('$uid')
          .child('book')
          .once()
          .then((DataSnapshot snapshot) {
        print('Connected to second database and read ${snapshot.value}');
      });
    } catch (e) {
      print(e);
    }
    return null;
  }

  Future<void> AddBook() async {
    print("AddBooks");
    _dbReference.child('$uid').child('book').push().set(false).asStream();
  }
}
