import 'package:books_and_movies/model/movie.dart';
import 'package:books_and_movies/database/movieRepository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../deleteForm.dart';

class MovieForm extends StatefulWidget {
  final Movie? _movie;
  final String? _movieId;

  MovieForm(this._movie, this._movieId);

  @override
  _MovieFormState createState() => _MovieFormState();
}

class _MovieFormState extends State<MovieForm> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController? nameController;
  TextEditingController? directorController;
  TextEditingController? yearController;
  bool _seen = false;

  @override
  void initState() {
    setState(() {
      nameController = TextEditingController(
          text: widget._movie != null ? widget._movie!.name : '');
      directorController = TextEditingController(
          text: widget._movie != null ? widget._movie!.director : '');
      yearController = TextEditingController(
          text: widget._movie != null ? widget._movie!.year.toString() : '');
    });
    _seen = widget._movie != null ? widget._movie!.seen : false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: widget._movie == null ? Text('Add Movie') : Text('Edit Movie'),
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
                        labelText: 'Name*',
                      ),
                      controller: nameController,
                      validator: validator,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 5),
                    child: TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Director',
                      ),
                      controller: directorController,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 5),
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      maxLength: 4,
                      decoration: const InputDecoration(
                        labelText: 'Year',
                      ),
                      controller: yearController,
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
                  ),
                ]),
          )),
      actions: [
        widget._movie != null
            ? IconButton(
                color: Theme.of(context).errorColor,
                icon: Icon(Icons.delete),
                onPressed: () {
                  Navigator.pop(context);
                  showDialog<void>(
                      context: context,
                      builder: (context) =>
                          DeleteForm(widget._movieId!, 'Movie'));
                },
              )
            : Container(),
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
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Processing Data')));
      if (widget._movie == null) {
        Movie newMovie = Movie(nameController!.text, directorController!.text,
            int.tryParse(yearController!.text), _seen);
        MovieRepository.addMovie(newMovie);
      } else {
        widget._movie!.update(nameController!.text, directorController!.text,
            int.parse(yearController!.text), _seen);
        MovieRepository.updateMovie(widget._movie!, widget._movieId!);
      }
      Navigator.pop(context);
    }
  }
}
