import 'dart:ffi';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

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

  Future<void> sendPasswordResetEmail(email) async {
    await _firebaseAuth.sendPasswordResetEmail(email: email);
  }

  Future<User?> signInUserWithEmailAndPassword(email, password) async {
    UserCredential userCredential = await _firebaseAuth
            .signInWithEmailAndPassword(email: email, password: password)
        as UserCredential;
    return userCredential.user;
  }

  Future<Void?> signOut() async {
    await _firebaseAuth.signOut();
    await GoogleSignIn().signOut();
  }

  Stream<User?> authStatus() {
    return _firebaseAuth.authStateChanges();
  }

  Future<User?> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    if (googleUser != null) {
      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      // Once signed in, return the UserCredential
      UserCredential userCredential =
          await _firebaseAuth.signInWithCredential(credential);

      return userCredential.user;
    } else
      return null;
  }
}
