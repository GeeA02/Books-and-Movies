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
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        ListTile(
          trailing: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Checkbox(
                  value: widget._book.seen,
                  onChanged: (bool? seen) {
                    setState(() {
                      widget._book.seen = seen!;
                    });
                    BookRepository.updateBook(widget._book, widget._bookId!);
                  }),
              Text(
                'Read',
                textScaleFactor: 0.5,
              ),
            ],
          ),
          title: Text(widget._book.name,
              style: Theme.of(context).textTheme.headline5),
          subtitle: widget._book.author != null
              ? Text(widget._book.author!,
                  style: Theme.of(context).textTheme.bodyText2)
              : null,
          onTap: () {
            showDialog<void>(
                context: context,
                builder: (context) => BookForm(widget._book, widget._bookId));
          },
          onLongPress: () {
            showDialog<void>(
                context: context,
                builder: (context) => AlertDialog(
                      content: Text('Delete book?'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text('CANCEL'),
                          style: TextButton.styleFrom(
                              primary: Theme.of(context).accentColor),
                        ),
                        TextButton(
                          onPressed: () {
                            BookRepository.deleteBook(widget._bookId!);
                            Navigator.pop(context);
                          },
                          child: Text('DELETE'),
                          style: TextButton.styleFrom(
                              primary: Theme.of(context).errorColor),
                        ),
                      ],
                    ));
          },
        ),
      ]),
    );
  }
}
