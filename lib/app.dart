import 'package:flutter/material.dart';
import 'package:books_and_movies/theme/config.dart';
import 'package:books_and_movies/theme/defaultTheme.dart';
import 'package:books_and_movies/view/mainView.dart';

class App extends StatefulWidget {
  const App({Key key}) : super(key: key);

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State {
  @override
  void initState() {
    super.initState();
    currentTheme.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: DefaultTheme.lightTheme,
      darkTheme: DefaultTheme.darkTheme,
      themeMode: currentTheme.currentTheme,
      //debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => MainView(),
      },
    );
  }
}
