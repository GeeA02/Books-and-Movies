import 'package:books_and_movies/view/signInView.dart';
import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';

class FirebaseWidget extends StatefulWidget {
  @override
  _FirebaseWidgetState createState() => _FirebaseWidgetState();
}

class _FirebaseWidgetState extends State<FirebaseWidget> {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialization,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          //TODO error widget
          return Text("error");
        }

        if (snapshot.connectionState == ConnectionState.done) {
          return SignInView();
        }
        return CircularProgressIndicator();
      },
    );
  }
}
