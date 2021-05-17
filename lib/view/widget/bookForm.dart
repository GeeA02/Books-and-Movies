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
  bool _seen = false;

  @override
  void initState() {
    setState(() {
      nameController = TextEditingController(
          text: widget._book != null ? widget._book!.name : '');
      authorController = TextEditingController(
          text: widget._book != null ? widget._book!.author : '');
    });
    _seen = widget._book != null ? widget._book!.seen : false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: widget._book == null ? Text('Add Book') : Text('Edit Book'),
      contentPadding: EdgeInsets.all(10),
      content: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(bottom: 5),
                    child: TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Name',
                      ),
                      controller: nameController,
                      validator: validator,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 5),
                    child: TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Author',
                      ),
                      controller: authorController,
                    ),
                  ),
                  CheckboxListTile(
                    title: Text('Seen? '),
                    onChanged: (bool? seen) {
                      setState(() {
                        _seen = seen!;
                      });
                    },
                    value: _seen,
                  )
                ]),
          )),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('CANCEL'),
          style: TextButton.styleFrom(primary: Theme.of(context).accentColor),
        ),
        TextButton(
          onPressed: save,
          child: Text('SAVE'),
          style: TextButton.styleFrom(primary: Theme.of(context).accentColor),
        ),
      ],
    );
  }

  String? validator(String? text) {
    print(text);
    if (text == null || text == '') {
      return 'Please enter some text';
    }
    return null;
  }

  void save() {
    print(authorController!.text);
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
