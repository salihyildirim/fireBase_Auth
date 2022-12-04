import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_deneme/views/sign_in_page.dart';
import 'package:flutter/material.dart';

import '../views/home_page.dart';

class OnBoardWidget extends StatefulWidget {
  const OnBoardWidget({Key? key}) : super(key: key);

  @override
  State<OnBoardWidget> createState() => _OnBoardWidgetState();
}

class _OnBoardWidgetState extends State<OnBoardWidget> {
  late bool _isLogged;

  @override
  void initState() {
    FirebaseAuth.instance.authStateChanges().listen((user) {
      if (user == null) {
        print("yok subluk");
        _isLogged = false;
      } else {
        print("subluk varrrrrrrrrrr");
        _isLogged = true;
      }
      setState(() {}); // set state lazım. ekranı tekrar çizcek
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _isLogged == null
        ? Center(
            child: CircularProgressIndicator(),
          )
        : _isLogged
            ? HomePage()
            : SignInPage();
  }
}
