import 'package:books_and_movies/model/book.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BookCard extends StatelessWidget {
  final Book _book;
  BookCard(this._book);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      color: Theme.of(context).cardColor,
      clipBehavior: Clip.antiAlias,
      child: Column(children: [
        ListTile(
          title: Text(_book.name, style: Theme.of(context).textTheme.bodyText1),
          subtitle:
              Text(_book.author, style: Theme.of(context).textTheme.bodyText2),
        ),
        ButtonBar(alignment: MainAxisAlignment.end, children: [
          //Checkbox(value: _book.seen, onChanged: (){}),
          IconButton(icon: Icon(Icons.edit), onPressed: () {}),
          IconButton(icon: Icon(Icons.delete), onPressed: () {}),
        ]),
      ]),
    );
  }
}
