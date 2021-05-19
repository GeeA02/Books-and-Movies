import 'package:books_and_movies/database/movieRepository.dart';
import 'package:books_and_movies/model/movie.dart';
import 'package:books_and_movies/view/widget/movie/movieCard.dart';
import 'package:books_and_movies/view/widget/movie/movieForm.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';

class MoviesView extends StatelessWidget {
  MoviesView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Padding(
      padding: EdgeInsets.all(30),
      child: Container(
        child: new Column(
            mainAxisAlignment: MainAxisAlignment.end,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              new Text(
                "Movies",
                style: Theme.of(context).textTheme.headline4,
                textAlign: TextAlign.center,
              ),
              Expanded(
                child: SizedBox(
                  height: 500.0,
                  child: FirebaseAnimatedList(
                      defaultChild: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [CircularProgressIndicator()]),
                      query: MovieRepository.getMovies(),
                      itemBuilder: (BuildContext context, DataSnapshot snapshot,
                          Animation<double> animation, int index) {
                        return MovieCard(
                            Movie.fromJson(snapshot.value), snapshot.key);
                      }),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              FloatingActionButton.extended(
                foregroundColor: Colors.black,
                onPressed: () {
                  showDialog<void>(
                    context: context,
                    builder: (context) => MovieForm(null, null),
                  );
                },
                icon: Icon(Icons.add),
                label: Text('Add'),
              ),
            ]),
      ),
    )));
  }
}
