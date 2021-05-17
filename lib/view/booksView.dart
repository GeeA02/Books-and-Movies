import 'package:books_and_movies/database/bookRepository.dart';
import 'package:books_and_movies/model/book.dart';
import 'package:books_and_movies/view/widget/bookCard.dart';
import 'package:books_and_movies/view/widget/bookForm.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:firebase_database/firebase_database.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';

class BooksView extends StatelessWidget {
  BooksView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Padding(
      padding: EdgeInsets.all(30),
      child: Container(
        child: new Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              new Text(
                "Books",
                style: Theme.of(context).textTheme.headline4,
                textAlign: TextAlign.center,
              ),
              Expanded(
                  child: SizedBox(
                      height: 200.0,
                      child: FirebaseAnimatedList(
                          query: BookRepository.getBooks(),
                          itemBuilder: (BuildContext context,
                              DataSnapshot snapshot,
                              Animation<double> animation,
                              int index) {
                            return BookCard(
                                Book.fromJson(snapshot.value), snapshot.key);
                          }))),
              IconButton(
                icon: Icon(Icons.ac_unit),
                onPressed: () {
                  showDialog<void>(
                      context: context,
                      builder: (context) => BookForm(null, null));
                },
              ),
            ]),
      ),
    )));
  }
}
