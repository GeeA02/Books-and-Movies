import 'package:books_and_movies/view/mainView.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {
  const App({Key key}) : super(key: key);

  static const String _title = 'Kody QR';
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      //theme: defaultTheme(),
      initialRoute: '/',
      routes: {
        '/': (context) => MainView(),
      },
    );
  }
}
