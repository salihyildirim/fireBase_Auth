import 'package:firebase_deneme/widgets/my_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../services/auth.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () async {
                await Provider.of<Auth>(context,listen:false).signOutAnonymously();
                print('logout tıklandı');
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
              onPressed: () async {
                final user = await Provider.of<Auth>(context, listen: false)
                    .signInAnonymously();
                print(user?.uid);
              },
            ),
            MyElevatedButton(
              child: Text("E-Mail"),
              color: Colors.yellowAccent,
              onPressed: () {},
            ),
            MyElevatedButton(
              child: Text("Google"),
              color: Colors.blue,
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
