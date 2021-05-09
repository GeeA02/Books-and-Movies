import 'package:books_and_movies/view/mainView.dart';
import 'package:books_and_movies/view/signInView.dart';
import 'package:flutter/material.dart';

// Import the firebase_core plugin
import 'package:firebase_core/firebase_core.dart';

import '../../app.dart';

/// We are using a StatefulWidget such that we only create the [Future] once,
/// no matter how many times our widget rebuild.
/// If we used a [StatelessWidget], in the event where [App] is rebuilt, that
/// would re-initialize FlutterFire and make our application re-enter loading state,
/// which is undesired.
class FirebaseWidget extends StatefulWidget {
  // Create the initialization Future outside of `build`:
  @override
  _FirebaseWidgetState createState() => _FirebaseWidgetState();
}

class _FirebaseWidgetState extends State<FirebaseWidget> {
  /// The future is part of the state of our widget. We should not call `initializeApp`
  /// directly inside [build].
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Initialize FlutterFire:
      future: _initialization,
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          //TODO error widget
          return Text("da");
        }

        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          return SignInView();
        }

        // Otherwise, show something whilst waiting for initialization to complete
        //TODO waiting widget
        return CircularProgressIndicator();
      },
    );
  }
}
