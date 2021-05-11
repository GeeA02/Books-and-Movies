import 'package:books_and_movies/view/booksView.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'moviesView.dart';

/// This is the stateful widget that the main application instantiates.
class MainView extends StatefulWidget {
  MainView({Key key}) : super(key: key);

  @override
  _MainViewState createState() => _MainViewState();
}

/// This is the private State class that goes with MyStatefulWidget.
class _MainViewState extends State<MainView> {
  final User user = FirebaseAuth.instance.currentUser;

  int _selectedIndex = 0;

  static List<Widget> _widgetOptions = [
    BooksView(),
    MoviesView(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: Theme.of(context).primaryColorLight),
        elevation: 0.0,
      ),
      //leftside menu
      drawer: Drawer(
          child: ListView(
              // Important: Remove any padding from the ListView.
              padding: EdgeInsets.zero,
              children: <Widget>[
            DrawerHeader(
              //TODO edit the menu
              child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                Container(
                  padding: const EdgeInsets.only(top: 16, bottom: 16),
                  alignment: Alignment.bottomLeft,
                  child: Text("Menu"),
                ),
                Spacer(
                  flex: 2,
                ),
                Container(
                    padding: const EdgeInsets.only(top: 16, bottom: 16),
                    alignment: Alignment.topRight,
                    child: CircleAvatar(
                      radius: 50,
                      child: user.photoURL != null
                          ? Image.network(user.photoURL)
                          : Icon(Icons.person, size: 50),
                    )),
              ]),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
              ),
            ),
            ListTile(
              title: Text('Historia wyszukiwania'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('Item 2'),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
          ])),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomAppBar(
          child: Container(
            color: Theme.of(context).bottomAppBarColor,
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                IconButton(
                  //update the bottom app bar view each time an item is clicked
                  onPressed: () {
                    _onItemTapped(0);
                  },
                  iconSize: 30.0,
                  icon: Icon(
                    Icons.menu_book,
                    //darken the icon if it is selected or else give it a different color
                    color: _selectedIndex == 0
                        ? Theme.of(context).primaryColor
                        : Theme.of(context).secondaryHeaderColor,
                  ),
                ),
                //to leave space in between the bottom app bar items and below the FAB
                SizedBox(
                  width: 100.0,
                ),
                IconButton(
                  onPressed: () {
                    _onItemTapped(1);
                  },
                  iconSize: 30.0,
                  icon: Icon(
                    Icons.local_movies,
                    color: _selectedIndex == 1
                        ? Theme.of(context).primaryColor
                        : Theme.of(context).secondaryHeaderColor,
                  ),
                ),
              ],
            ),
          ),
          //to add a space between the FAB and BottomAppBar
          shape: CircularNotchedRectangle(),
          //color of the BottomAppBar
          color: Theme.of(context).bottomAppBarColor),
    );
  }
}
