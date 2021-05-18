import 'package:books_and_movies/view/booksView.dart';
import 'package:books_and_movies/view/widget/bookForm.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'moviesView.dart';

class MainView extends StatefulWidget {
  MainView({Key? key}) : super(key: key);

  @override
  _MainViewState createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  final User? user = FirebaseAuth.instance.currentUser != null
      ? FirebaseAuth.instance.currentUser
      : null;

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

  Future<void> _signOut() async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacementNamed(context, '/signIn');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: Theme.of(context).cardColor),
        elevation: 0.0,
        actions: [IconButton(icon: Icon(Icons.search), onPressed: () {})],
      ),
      //leftside menu
      drawer: Drawer(
          child: ListView(padding: EdgeInsets.zero, children: <Widget>[
        DrawerHeader(
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
                  child: user!.photoURL != null
                      ? Image.network(user!.photoURL!)
                      : Icon(Icons.person, size: 50),
                )),
          ]),
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
          ),
        ),
        ListTile(
          leading: Icon(Icons.menu_book),
          title: Text('Add book', style: Theme.of(context).textTheme.bodyText2),
          onTap: () {
            _onItemTapped(0);
            Navigator.pop(context);
            showDialog<void>(
                context: context, builder: (context) => BookForm(null, null));
          },
        ),
        ListTile(
          leading: Icon(Icons.local_movies),
          title:
              Text('Add movie', style: Theme.of(context).textTheme.bodyText2),
          onTap: () {
            _onItemTapped(1);
            Navigator.pop(context);
          },
        ),
        Divider(
          height: 1,
          thickness: 1,
        ),
        ListTile(
          leading: Icon(Icons.logout),
          title: Text('Logout', style: Theme.of(context).textTheme.bodyText2),
          onTap: () {
            _signOut();
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
                  onPressed: () {
                    _onItemTapped(0);
                  },
                  iconSize: 30.0,
                  icon: Icon(
                    Icons.menu_book,
                    color: _selectedIndex == 0
                        ? Theme.of(context).cardColor
                        : Theme.of(context).secondaryHeaderColor,
                  ),
                ),
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
                        ? Theme.of(context).cardColor
                        : Theme.of(context).secondaryHeaderColor,
                  ),
                ),
              ],
            ),
          ),
          color: Theme.of(context).bottomAppBarColor),
    );
  }
}
