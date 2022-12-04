import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_deneme/services/auth.dart';
import 'package:firebase_deneme/widgets/on_board.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  //await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Provider<Auth>(
        create: (context) => Auth(),
        child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.orange,
          ),
          home: FutureBuilder(
              future: _initialization,
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(
                    child: Text('Beklenilmeyen bir hata oluştu'),
                  );
                } else if (snapshot.hasData) {
                  return OnBoardWidget();
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              }),
        )
        //OnBoardWidget(),
        );
  }
}
