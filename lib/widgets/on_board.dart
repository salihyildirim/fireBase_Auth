import 'package:firebase_deneme/services/auth.dart';
import 'package:firebase_deneme/views/sign_in_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../views/home_page.dart';

class OnBoardWidget extends StatefulWidget {
  const OnBoardWidget({Key? key}) : super(key: key);

  @override
  State<OnBoardWidget> createState() => _OnBoardWidgetState();
}

class _OnBoardWidgetState extends State<OnBoardWidget> {
  //late bool _isLogged;

  @override
  Widget build(BuildContext context) {
    final _auth = Provider.of<Auth>(context, listen: false);

    return StreamBuilder(
      stream: _auth.authStatus(), //nereyi dinleyelim?
      builder: (context, snapshot) {
        // veri geldikçe builder çalışır. devamlı dinliyor.
        if (snapshot.connectionState == ConnectionState.active) {
          return snapshot.data != null ? HomePage() : SignInPage();
        } else {
          return SizedBox(
            width: 300,
            height: 300,
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
