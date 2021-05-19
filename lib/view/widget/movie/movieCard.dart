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
    return Dismissible(
      key: Key(widget._movieId!),
      onDismissed: (direction) {
        widget._movie.seen = !widget._movie.seen;
        MovieRepository.updateMovie(widget._movie, widget._movieId!);

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(widget._movie.seen
                ? '${widget._movie.name} set as seen'
                : '${widget._movie.name} set as unseen')));
      },
      background: Container(
        color: Theme.of(context).accentColor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 10),
              child: Text(widget._movie.seen ? 'unseen' : 'seen',
                  style: Theme.of(context).textTheme.headline4),
            ),
          ],
        ),
      ),
      child: Card(
        elevation: 5,
        color: !widget._movie.seen
            ? Theme.of(context).cardColor
            : Theme.of(context).cardColor.withOpacity(0.7),
        clipBehavior: Clip.antiAlias,
        child: ListTile(
          trailing: widget._movie.seen ? Icon(Icons.check) : null,
          title: Text(
              widget._movie.year != null
                  ? '${widget._movie.name} (${widget._movie.year})'
                  : '${widget._movie.name}',
              style: widget._movie.name.length < 20
                  ? Theme.of(context).textTheme.headline5
                  : Theme.of(context).textTheme.headline6),
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
      ),
    );
  }
}
