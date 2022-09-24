import 'package:together/services/firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

import 'package:google_sign_in/google_sign_in.dart';

class Auth {
  final user = FirebaseAuth.instance;

  Future<String?> mailRegister(String mail, String pwd, String name) async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: mail, password: pwd);

      user.currentUser!.updateDisplayName(name);
      return null;
    } on FirebaseAuthException catch (ex) {
      return "${ex.message}";
    }
  }

  Future<String?> signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
      return null;
    } on FirebaseAuthException catch (ex) {
      return "${ex.message}";
    }
  }

  Future<bool> isLoggedIn() async {
    bool loggedIn = await user.currentUser != null;

    return loggedIn;
  }

  Future<String?> passReset({required String email}) async {
    try {
      await user.sendPasswordResetEmail(email: email);
      return null;
    } on FirebaseAuthException catch (ex) {
      return "${ex.message}";
    }
  }

  Future<String?> mailSignIn(String mail, String pwd) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: mail, password: pwd);

      return null;
    } on FirebaseAuthException catch (ex) {
      return "${ex.message}";
    }
  }

  Future signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    return await FirebaseAuth.instance.signInWithCredential(credential);
  }
}
