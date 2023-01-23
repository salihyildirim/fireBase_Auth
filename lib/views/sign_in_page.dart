import 'package:firebase_deneme/views/email_sign_in.dart';
import 'package:firebase_deneme/widgets/my_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../services/auth.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  bool _isLoading = false;

  Future<void> _signInAnonymously() async {
    setState(() {
      _isLoading = true;
    });
    final user =
        await Provider.of<Auth>(context, listen: false).signInAnonymously();
    setState(() {
      _isLoading = false;
    });
    print(user?.uid);
  }

  Future<void> _signInWithGoogle() async {
    setState(() {
      _isLoading = true;
    });
    final user =
        await Provider.of<Auth>(context, listen: false).signInWithGoogle();
    setState(() {
      _isLoading = false;
    });
    print(user?.uid);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () async {
                await Provider.of<Auth>(context, listen: false).signOut();
              },
              icon: Icon(Icons.logout))
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Select Enter Type",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            MyElevatedButton(
              child: Text("Anonymous"),
              color: Colors.orange,
              onPressed: _isLoading ? () {} : _signInAnonymously,
            ),
            MyElevatedButton(
              child: Text("E-Mail"),
              color: Colors.yellowAccent,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (contex) {
                    return EmailSignInPage();
                  }),
                );
              },
            ),
            MyElevatedButton(
              child: Text("Google"),
              color: Colors.blue,
              onPressed: _isLoading ? () {} : _signInWithGoogle,
            ),
          ],
        ),
      ),
    );
  }
}
