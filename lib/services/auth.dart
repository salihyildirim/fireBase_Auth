import 'dart:ffi';

import 'package:firebase_auth/firebase_auth.dart';

class Auth {
  final _firebaseAuth = FirebaseAuth.instance;

  Future<User?> signInAnonymously() async {
    final userCredential = await _firebaseAuth.signInAnonymously();
    return userCredential.user;
  }

  Future<User?> createCreateUserWithEmailAndPassword(email, password) async {
    UserCredential userCredential = await _firebaseAuth
            .createUserWithEmailAndPassword(email: email, password: password)
        as UserCredential;
    return userCredential.user;
  }

  Future<User?> signInUserWithEmailAndPassword(email, password) async {
    UserCredential userCredential = await _firebaseAuth
            .signInWithEmailAndPassword(email: email, password: password)
        as UserCredential;
    return userCredential.user;
  }

  Future<Void?> signOut() async {
    await _firebaseAuth.signOut();
  }

  Stream<User?> authStatus() {
    return _firebaseAuth.authStateChanges();
  }
}
