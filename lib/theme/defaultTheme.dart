import 'package:flutter/material.dart';

//TODO change theme properties
class DefaultTheme with ChangeNotifier {
  static ThemeData get darkTheme {
    return ThemeData(
      accentColor: Color(0xFF6b705c),
      primaryColor: Color(0xFFcb997e),
      buttonColor: Color(0xFF606c38),
      scaffoldBackgroundColor: Color(0xFFb7b7a4),
      cardColor: Color(0xFFffe8d6),
      errorColor: Color(0xFF9d0208),
      bottomAppBarColor: Color(0xFFcb997e),
      fontFamily: 'Montserrat',
      textTheme: ThemeData.light().textTheme.copyWith(
            headline1: ThemeData.dark().textTheme.headline1!.copyWith(
                  color: Color(0xFF363640),
                ),
            headline3: ThemeData.dark().textTheme.headline3!.copyWith(
                  color: Color(0xFF363640),
                ),
            headline4: ThemeData.dark().textTheme.headline4!.copyWith(
                  color: Color(0xFF363640),
                ),
            headline5: ThemeData.dark().textTheme.headline5!.copyWith(
                  color: Color(0xFF363640),
                ),
            headline6: ThemeData.dark().textTheme.headline6!.copyWith(
                  color: Color(0xFF101010),
                  fontWeight: FontWeight.w400,
                ),
            bodyText2: ThemeData.dark().textTheme.bodyText2!.copyWith(
                  color: Color(0xFF363640),
                ),
            bodyText1: ThemeData.dark().textTheme.bodyText1!.copyWith(
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
      textTheme: ThemeData.light().textTheme.copyWith(
            headline1: ThemeData.light().textTheme.headline1!.copyWith(
                  color: Color(0xFF363640),
                  fontWeight: FontWeight.bold,
                ),
            headline3: ThemeData.light().textTheme.headline3!.copyWith(
                  color: Color(0xFF363640),
                  fontWeight: FontWeight.bold,
                ),
            headline4: ThemeData.light().textTheme.headline4!.copyWith(
                  color: Color(0xFF363640),
                  fontWeight: FontWeight.bold,
                ),
            headline5: ThemeData.light().textTheme.headline5!.copyWith(
                  color: Color(0xFF363640),
                  fontWeight: FontWeight.bold,
                ),
            headline6: ThemeData.light().textTheme.headline6!.copyWith(
                  color: Color(0xFF363640),
                  fontWeight: FontWeight.bold,
                ),
            bodyText2: ThemeData.light().textTheme.bodyText2!.copyWith(
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
