import 'package:flutter/material.dart';

class DefaultTheme with ChangeNotifier {
  static ThemeData get darkTheme {
    return ThemeData(
      primaryColor: Color(0xFF75a478),
      canvasColor: Color(0xFF75a478),
      scaffoldBackgroundColor: Color(0xffa5d6a7),
      fontFamily: 'Montserrat',
      textTheme: ThemeData.dark().textTheme.copyWith(
            headline1: ThemeData.dark().textTheme.headline1.copyWith(
                  color: Color(0xFF363640),
                ),
            headline3: ThemeData.dark().textTheme.headline3.copyWith(
                  color: Color(0xFF363640),
                ),
            headline4: ThemeData.dark().textTheme.headline4.copyWith(
                  color: Color(0xFF363640),
                ),
            headline5: ThemeData.dark().textTheme.headline5.copyWith(
                  color: Color(0xFF363640),
                ),
          ),
    );
  }

  static ThemeData get lightTheme {
    return ThemeData(
      primaryColor: Color(0xFF75a478),
      canvasColor: Color(0xFF75a478),
      scaffoldBackgroundColor: Color(0xffa5d6a7),
      fontFamily: 'Montserrat',
      textTheme: ThemeData.dark().textTheme.copyWith(
            headline1: ThemeData.dark().textTheme.headline1.copyWith(
                  color: Color(0xFF363640),
                  fontWeight: FontWeight.bold,
                  fontSize: 115,
                ),
            headline3: ThemeData.dark().textTheme.headline3.copyWith(
                  color: Color(0xFF363640),
                  fontWeight: FontWeight.bold,
                  fontSize: 50,
                ),
            headline4: ThemeData.dark().textTheme.headline4.copyWith(
                  color: Color(0xFF363640),
                  fontWeight: FontWeight.bold,
                  fontSize: 36,
                ),
            headline5: ThemeData.dark().textTheme.headline5.copyWith(
                  color: Color(0xFF363640),
                  fontWeight: FontWeight.bold,
                  fontSize: 26,
                ),
          ),
    );
  }

  static bool _isDarkTheme = true;
  ThemeMode get currentTheme => _isDarkTheme ? ThemeMode.dark : ThemeMode.light;

  void toggleTheme() {
    _isDarkTheme = !_isDarkTheme;
    notifyListeners();
  }
}
