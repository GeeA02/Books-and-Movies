import 'package:books_and_movies/database/bookRepository.dart';
import 'package:books_and_movies/model/book.dart';
import 'package:books_and_movies/view/widget/bookForm.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BookCard extends StatefulWidget {
  final Book _book;
  final String? _bookId;

  BookCard(this._book, this._bookId);

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
              style: Theme.of(context).textTheme.headline5),
          subtitle: widget._book.author != null
              ? Text(widget._book.author!,
                  style: Theme.of(context).textTheme.bodyText2)
              : null,
        ),
        ButtonBar(alignment: MainAxisAlignment.end, children: [
          Checkbox(
              value: widget._book.seen,
              onChanged: (bool? seen) {
                setState(() {
                  widget._book.seen = seen!;
                });
                BookRepository.updateBook(widget._book, widget._bookId!);
              }),
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              showDialog<void>(
                  context: context,
                  builder: (context) => BookForm(widget._book, widget._bookId));
            },
          ),
          IconButton(
              icon: Icon(Icons.delete),
              onPressed: () => BookRepository.deleteBook(widget._bookId!)),
        ]),
      ]),
    );
  }
}
