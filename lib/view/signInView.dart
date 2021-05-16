// Copyright 2020 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

final FirebaseAuth _auth = FirebaseAuth.instance;

/// Entrypoint example for various sign-in flows with Firebase.
class SignInView extends StatefulWidget {
  /// The page title.
  final String title = 'Books and movies';

  @override
  State<StatefulWidget> createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
  User? user;

  @override
  void initState() {
    _auth.authStateChanges().listen((User? user) {
      if (user == null) {
        print('User is currently signed out!');
      } else {
        Navigator.pushReplacementNamed(context, '/main', arguments: user);
        print('User is signed in!');
      }
    });
    _auth.userChanges().listen((event) => setState(() => user = event));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        /*actions: <Widget>[
          Builder(builder: (BuildContext context) {
            return FlatButton(
              textColor: Theme.of(context).buttonColor,
              onPressed: () async {
                final User user = _auth.currentUser;
                if (user == null) {
                  Scaffold.of(context).showSnackBar(const SnackBar(
                    content: Text('No one has signed in.'),
                  ));
                  return;
                }
                await _signOut();

                final String uid = user.uid;
                Scaffold.of(context).showSnackBar(SnackBar(
                  content: Text('$uid has successfully signed out.'),
                ));
              },
              child: const Text('Sign out'),
            );
          })
        ],*/
      ),
      body: Builder(builder: (BuildContext context) {
        return Container(
            child: ListView(
          padding: const EdgeInsets.fromLTRB(8, 25, 8, 8),
          children: <Widget>[
            _SignInForm(),
          ],
        ));
      }),
    );
  }
}

/*
class _UserInfoCard extends StatefulWidget {
  final User user;

  const _UserInfoCard(this.user);

  @override
  _UserInfoCardState createState() => _UserInfoCardState();
}

class _UserInfoCardState extends State<_UserInfoCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.only(bottom: 8),
              alignment: Alignment.center,
              child: const Text(
                'User info',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            if (widget.user != null)
              if (widget.user.photoURL != null)
                Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.only(bottom: 8),
                  child: Image.network(widget.user.photoURL),
                )
              else
                Align(
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    margin: const EdgeInsets.only(bottom: 8),
                    color: Colors.black,
                    child: const Text(
                      'No image',
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
            Text(widget.user == null
                ? 'Not signed in'
                : '${widget.user.isAnonymous ? 'User is anonymous\n\n' : ''}'
                    'Email: ${widget.user.email} (verified: ${widget.user.emailVerified})\n\n'
                    'Phone number: ${widget.user.phoneNumber}\n\n'
                    'Name: ${widget.user.displayName}\n\n\n'
                    'ID: ${widget.user.uid}\n\n'
                    'Tenant ID: ${widget.user.tenantId}\n\n'
                    'Refresh token: ${widget.user.refreshToken}\n\n\n'
                    'Created: ${widget.user.metadata.creationTime.toString()}\n\n'
                    'Last login: ${widget.user.metadata.lastSignInTime}\n\n'),
            if (widget.user != null)
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    widget.user.providerData.isEmpty
                        ? 'No providers'
                        : 'Providers:',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  for (var provider in widget.user.providerData)
                    Dismissible(
                      key: Key(provider.uid),
                      onDismissed: (action) =>
                          widget.user.unlink(provider.providerId),
                      child: Card(
                        color: Colors.grey[700],
                        child: ListTile(
                          leading: provider.photoURL == null
                              ? IconButton(
                                  icon: const Icon(Icons.remove),
                                  onPressed: () =>
                                      widget.user.unlink(provider.providerId))
                              : Image.network(provider.photoURL),
                          title: Text(provider.providerId),
                          subtitle: Text(
                              "${provider.uid == null ? "" : "ID: ${provider.uid}\n"}"
                              "${provider.email == null ? "" : "Email: ${provider.email}\n"}"
                              "${provider.phoneNumber == null ? "" : "Phone number: ${provider.phoneNumber}\n"}"
                              "${provider.displayName == null ? "" : "Name: ${provider.displayName}\n"}"),
                        ),
                      ),
                    ),
                ],
              ),
            Visibility(
              visible: widget.user != null,
              child: Container(
                margin: const EdgeInsets.only(top: 8),
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                      onPressed: () => widget.user.reload(),
                      icon: const Icon(Icons.refresh),
                    ),
                    IconButton(
                      onPressed: () => showDialog(
                        context: context,
                        builder: (context) => UpdateUserDialog(widget.user),
                      ),
                      icon: const Icon(Icons.text_snippet),
                    ),
                    IconButton(
                      onPressed: () => widget.user.delete(),
                      icon: const Icon(Icons.delete_forever),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
*/
class _SignInForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SignInFormState();
}

class _SignInFormState extends State<_SignInForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(children: [
      Form(
          key: _formKey,
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    alignment: Alignment.center,
                    child: Text(
                      'Sign in with email and password',
                      style: Theme.of(context).textTheme.headline5,
                    ),
                  ),
                  TextFormField(
                    controller: _emailController,
                    decoration: const InputDecoration(labelText: 'Email'),
                    validator: (String? value) {
                      if (value!.isEmpty) return 'Please enter some text';
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _passwordController,
                    decoration: const InputDecoration(labelText: 'Password'),
                    validator: (String? value) {
                      if (value!.isEmpty) return 'Please enter some text';
                      return null;
                    },
                    obscureText: true,
                  ),
                  Container(
                    padding: const EdgeInsets.only(top: 16),
                    alignment: Alignment.center,
                    child: SignInButton(
                      Buttons.Email,
                      text: 'Sign In',
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          await _signInWithEmailAndPassword();
                        }
                      },
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(top: 16, bottom: 16),
                    alignment: Alignment.center,
                    child: Text("or sign in with Google",
                        style: Theme.of(context).textTheme.headline5),
                  ),
                  Container(
                    alignment: Alignment.center,
                    child: SignInButton(
                      Buttons.GoogleDark,
                      text: 'Sign In',
                      onPressed: () async {
                        _signInWithGoogle();
                      },
                    ),
                  ),
                ],
              ),
            ),
          )),
      Container(
        padding: const EdgeInsets.only(top: 16, bottom: 16),
        alignment: Alignment.center,
        child: Text("If you don't have account, you can create a new one",
            style: Theme.of(context).textTheme.bodyText2),
      ),
      Container(
          alignment: Alignment.center,
          child: OutlinedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/signIn/signUp');
              },
              child: Text("Sign up"))),
    ]));
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // Example code of how to sign in with email and password.
  Future<void> _signInWithEmailAndPassword() async {
    try {
      final User user = (await _auth.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      ))
          .user!;

      Scaffold.of(context).showSnackBar(
        SnackBar(
          content: Text('${user.email} signed in'),
        ),
      );
      Navigator.pushReplacementNamed(context, '/main');
    } catch (e) {
      Scaffold.of(context).showSnackBar(
        const SnackBar(
          content: Text('Failed to sign in with Email and Password'),
        ),
      );
    }
  }

//Example code of how to sign in with Google.
  Future<void> _signInWithGoogle() async {
    try {
      UserCredential userCredential;

      if (kIsWeb) {
        var googleProvider = GoogleAuthProvider();
        userCredential = await _auth.signInWithPopup(googleProvider);
      } else {
        final GoogleSignInAccount? googleUser = await (GoogleSignIn().signIn());
        if (googleUser != null) {
          final GoogleSignInAuthentication googleAuth =
              await googleUser.authentication;
          final googleAuthCredential = GoogleAuthProvider.credential(
            accessToken: googleAuth.accessToken,
            idToken: googleAuth.idToken,
          );
          userCredential =
              await _auth.signInWithCredential(googleAuthCredential);
        } else
          throw Exception("Something went wrong!");
      }

      final user = userCredential.user;
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text('Sign In ${user!.uid} with Google'),
      ));

      Navigator.pushReplacementNamed(context, '/main');
    } catch (e) {
      print(e);
      Scaffold.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to sign in with Google: $e'),
        ),
      );
    }
  }
}
