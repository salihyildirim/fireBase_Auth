import 'dart:ffi';

import 'package:firebase_auth/firebase_auth.dart';

class Auth {
  final _firebaseAuth = FirebaseAuth.instance;

  Future<User?> signInAnonymously() async {
    final userCredential = await _firebaseAuth.signInAnonymously();
    return userCredential.user;
  }

  Future<Void?> signOutAnonymously() async {
    await _firebaseAuth.signOut();
  }
}
