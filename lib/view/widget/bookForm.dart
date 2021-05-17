import 'package:books_and_movies/database/bookRepository.dart';
import 'package:books_and_movies/model/book.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BookForm extends StatefulWidget {
  final Book? _book;
  final String? _bookId;

  BookForm(this._book, this._bookId);

  @override
  _BookFormState createState() => _BookFormState();
}

class _BookFormState extends State<BookForm> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController? nameController;
  TextEditingController? authorController;
  final bool _seen = false;

  @override
  void initState() {
    setState(() {
      nameController = TextEditingController(
          text: widget._book != null ? widget._book!.name : '');
      authorController = TextEditingController(
          text: widget._book != null ? widget._book!.author : '');
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: widget._book == null ? Text('Add Book') : Text('Edit Book'),
      contentPadding: EdgeInsets.zero,
      content: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text("Name:", style: Theme.of(context).textTheme.headline6),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: TextFormField(
                      controller: nameController,
                    ),
                  ),
                  Text("Author", style: Theme.of(context).textTheme.headline6),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: TextFormField(
                      controller: authorController,
                    ),
                  ),
                  Text("Seen?", style: Theme.of(context).textTheme.headline6),
                  Checkbox(
                    onChanged: (seen) {},
                    value: widget._book != null ? widget._book!.seen : _seen,
                  )
                ]),
          )),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('CANCEL'),
        ),
        TextButton(
          onPressed: save,
          child: Text('SAVE'),
        ),
      ],
    );
  }

  String? validator(String? text) {
    if (text == null || text.isEmpty) {
      return 'Please enter some text';
    }
    return null;
  }

  void save() {
    print(authorController);
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Processing Data')));
      if (widget._book == null) {
        Book newBook =
            Book(nameController!.text, authorController!.text, _seen);
        BookRepository.addBook(newBook);
      } else {
        widget._book!
            .update(nameController!.text, authorController!.text, _seen);
        BookRepository.updateBook(widget._book!, widget._bookId!);
      }
      Navigator.pop(context);
    }
  }
}
