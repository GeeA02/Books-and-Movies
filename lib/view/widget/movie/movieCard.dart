import 'package:books_and_movies/database/movieRepository.dart';
import 'package:books_and_movies/model/movie.dart';
import 'package:books_and_movies/view/widget/movie/movieForm.dart';
import 'package:books_and_movies/view/widget/deleteForm.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MovieCard extends StatefulWidget {
  final Movie _movie;
  final String? _movieId;

  MovieCard(this._movie, this._movieId);

  @override
  _MovieCardState createState() => _MovieCardState();
}

class _MovieCardState extends State<MovieCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      color: Theme.of(context).cardColor,
      clipBehavior: Clip.antiAlias,
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        ListTile(
          trailing: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Checkbox(
                  value: widget._movie.seen,
                  onChanged: (bool? seen) {
                    setState(() {
                      widget._movie.seen = seen!;
                    });
                    MovieRepository.updateMovie(
                        widget._movie, widget._movieId!);
                  }),
              Text(
                'Seen',
                textScaleFactor: 0.5,
              ),
            ],
          ),
          title: Text('${widget._movie.name} (${widget._movie.year})',
              style: Theme.of(context).textTheme.headline5),
          subtitle: widget._movie.director != null
              ? Text(widget._movie.director!,
                  style: Theme.of(context).textTheme.bodyText2)
              : null,
          onTap: () {
            showDialog<void>(
                context: context,
                builder: (context) =>
                    MovieForm(widget._movie, widget._movieId));
          },
          onLongPress: () {
            showDialog<void>(
                context: context,
                builder: (context) => DeleteForm(widget._movieId!, 'Movie'));
          },
        ),
      ]),
    );
  }
}
