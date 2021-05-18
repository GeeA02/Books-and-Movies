import 'package:books_and_movies/database/bookRepository.dart';
import 'package:books_and_movies/database/movieRepository.dart';
import 'package:books_and_movies/model/book.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DeleteForm extends StatelessWidget {
  final String _itemId;
  final String _itemType;
  DeleteForm(this._itemId, this._itemType);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Text('Delete $_itemType?'),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('CANCEL'),
          style: TextButton.styleFrom(primary: Theme.of(context).accentColor),
        ),
        TextButton(
          onPressed: () {
            _itemType == 'Book'
                ? BookRepository.deleteBook(_itemId)
                : MovieRepository.deleteMovie(_itemId);
            Navigator.pop(context);
          },
          child: Text('DELETE'),
          style: TextButton.styleFrom(primary: Theme.of(context).errorColor),
        ),
      ],
    );
  }
}
