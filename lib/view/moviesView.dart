import 'package:flutter/material.dart';

class MoviesView extends StatelessWidget {
  MoviesView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Padding(
      padding: EdgeInsets.all(30),
      child: Container(
        child: new Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              new Text(
                "Movies",
                style: Theme.of(context).textTheme.headline1,
                textAlign: TextAlign.center,
              ),
            ]),
      ),
    )));
  }

  void buttonPressed() {}
}
