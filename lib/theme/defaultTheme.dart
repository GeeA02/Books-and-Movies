import 'package:flutter/material.dart';

//TODO change theme properties
class DefaultTheme with ChangeNotifier {
  static ThemeData get darkTheme {
    return ThemeData(
      /*primaryColor: Color(0xFF75a478),
      canvasColor: Color(0xFF75a478),
      scaffoldBackgroundColor: Color(0xffa5d6a7),
      cardColor: Color(0xffa5d6a7),*/
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
            bodyText2: ThemeData.dark().textTheme.bodyText2.copyWith(
                  color: Color(0xFF363640),
                ),
          ),
    );
  }

  static ThemeData get lightTheme {
    return ThemeData(
      /*primaryColor: Color(0xFF75a478),
      canvasColor: Color(0xFF75a478),
      scaffoldBackgroundColor: Color(0xffa5d6a7),*/
      fontFamily: 'Montserrat',
      textTheme: ThemeData.dark().textTheme.copyWith(
            headline1: ThemeData.light().textTheme.headline1.copyWith(
                  color: Color(0xFF363640),
                  fontWeight: FontWeight.bold,
                ),
            headline3: ThemeData.light().textTheme.headline3.copyWith(
                  color: Color(0xFF363640),
                  fontWeight: FontWeight.bold,
                ),
            headline4: ThemeData.light().textTheme.headline4.copyWith(
                  color: Color(0xFF363640),
                  fontWeight: FontWeight.bold,
                ),
            headline5: ThemeData.light().textTheme.headline5.copyWith(
                  color: Color(0xFF363640),
                  fontWeight: FontWeight.bold,
                ),
            bodyText2: ThemeData.light().textTheme.bodyText2.copyWith(
                  color: Color(0xFF363640),
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
