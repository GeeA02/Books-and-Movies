import 'package:books_and_movies/database/bookRepository.dart';
import 'package:books_and_movies/model/book.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BookCard extends StatefulWidget {
  final Book _book;
  final String? bookId;

  BookCard(this._book, this.bookId);

  @override
  _BookCardState createState() => _BookCardState();
}

class _BookCardState extends State<BookCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      color: Theme.of(context).cardColor,
      clipBehavior: Clip.antiAlias,
      child: Column(children: [
        ListTile(
          title: Text(widget._book.name,
              style: Theme.of(context).textTheme.bodyText1),
          subtitle: Text(widget._book.author,
              style: Theme.of(context).textTheme.bodyText2),
        ),
        ButtonBar(alignment: MainAxisAlignment.end, children: [
          Checkbox(
              value: widget._book.seen,
              onChanged: (bool? seen) {
                setState(() {
                  widget._book.seen = seen!;
                });
                BookRepository.updateBook(widget._book, widget.bookId!);
              }),
          IconButton(icon: Icon(Icons.edit), onPressed: () {}),
          IconButton(
              icon: Icon(Icons.delete),
              onPressed: () => BookRepository.deleteBook(widget.bookId!)),
        ]),
      ]),
    );
  }
}
