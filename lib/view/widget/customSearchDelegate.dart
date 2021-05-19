import 'package:books_and_movies/database/bookRepository.dart';
import 'package:books_and_movies/database/movieRepository.dart';
import 'package:books_and_movies/model/book.dart';
import 'package:books_and_movies/model/movie.dart';
import 'package:books_and_movies/view/widget/book/bookCard.dart';
import 'package:books_and_movies/view/widget/movie/movieCard.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class CustomSearchDelegate extends SearchDelegate {
  late Map<dynamic, dynamic> books;
  late Map<dynamic, dynamic> movies;

  CustomSearchDelegate() {
    BookRepository.getBooks().once().then((DataSnapshot snap) {
      books = snap.value;
    });
    MovieRepository.getMovies().once().then((DataSnapshot snap) {
      movies = snap.value;
    });
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    if (query.length < 3) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Center(
            child: Text(
              "Search term must be longer than two letters.",
            ),
          )
        ],
      );
    }

    return Column(children: [
      ...findBooks(query),
      ...findMovies(query),
    ]);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Column();
  }

  List<Widget> findBooks(String query) {
    List<Widget> cards = [];
    books.forEach((key, value) {
      Book tmpBook = Book.fromJson(value);
      if (tmpBook.find(query)) cards.add(BookCard(tmpBook, key));
    });
    if (cards.isEmpty) cards.add(Text('There is no book like \'$query\''));
    return cards;
  }

  List<Widget> findMovies(String query) {
    List<Widget> cards = [];
    movies.forEach((key, value) {
      Movie tmpMovie = Movie.fromJson(value);
      if (tmpMovie.find(query)) cards.add(MovieCard(tmpMovie, key));
    });
    if (cards.isEmpty) cards.add(Text('There is no movie like \'$query\''));
    return cards;
  }
}
