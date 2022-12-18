import 'package:flutter/material.dart';

class EmailSignInPage extends StatefulWidget {
  const EmailSignInPage({Key? key}) : super(key: key);

  @override
  State<EmailSignInPage> createState() => _EmailSignInPageState();
}

class _EmailSignInPageState extends State<EmailSignInPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: buildSignInForm(),
      ),
    );
  }

  Widget buildSignInForm() {
    return Form(
      child: Column(
        children: [
          Text("LÜTFEN GİRİŞ YAPINIZ."),
          TextFormField(),
          TextFormField(),
          ElevatedButton(
            onPressed: () {},
            child: Text("Giriş"),
          )
        ],
      ),
    );
  }
}
