import 'package:books_and_movies/database/bookRepository.dart';
import 'package:books_and_movies/model/book.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../deleteForm.dart';
import 'bookForm.dart';

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
    return Dismissible(
      key: UniqueKey(),
      onDismissed: (direction) {
        widget._book.seen = !widget._book.seen;
        BookRepository.updateBook(widget._book, widget._bookId!);

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(widget._book.seen
                ? '${widget._book.name} set as read'
                : '${widget._book.name} set as unread')));
      },
      background: Container(
        color: Theme.of(context).accentColor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 10),
              child: Text(widget._book.seen ? 'unread' : 'read',
                  style: Theme.of(context).textTheme.headline4),
            ),
          ],
        ),
      ),
      child: Card(
        elevation: 5,
        color: !widget._book.seen
            ? Theme.of(context).cardColor
            : Theme.of(context).cardColor.withOpacity(0.7),
        clipBehavior: Clip.antiAlias,
        child: ListTile(
          trailing: widget._book.seen ? Icon(Icons.check) : null,
          title: Text('${widget._book.name}',
              style: widget._book.name.length < 20
                  ? Theme.of(context).textTheme.headline5
                  : Theme.of(context).textTheme.headline6),
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
                builder: (context) => DeleteForm(widget._bookId!, 'Book'));
          },
        ),
      ),
    );
  }
}
