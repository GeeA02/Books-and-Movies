import 'package:flutter/material.dart';

class BooksView extends StatelessWidget {
  BooksView({Key key}) : super(key: key);

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
                "Books",
                style: Theme.of(context).textTheme.headline1,
                textAlign: TextAlign.center,
              ),
            ]),
      ),
    )));
  }

  void buttonPressed() {}
}
