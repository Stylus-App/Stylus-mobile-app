// ignore_for_file: non_constant_identifier_names

// ignore: depend_on_referenced_packages
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dio/dio.dart';

class Authentication {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  Future register(String Email, String Password, context) async {
    try {
      UserCredential userCredential = await firebaseAuth
          .createUserWithEmailAndPassword(email: Email, password: Password);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('email', Email);
      prefs.setString('password', Password);
      prefs.setString('id', userCredential.user!.uid);
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(e.toString()),
        backgroundColor: Colors.indigo,
        padding: const EdgeInsets.all(25),
      ));
    }
  }

  Future login(String Email, String Password, context) async {
    final dio = Dio();
    print(Email);
    print(Password);
    try {
      UserCredential userCredential = await firebaseAuth
          .signInWithEmailAndPassword(email: Email, password: Password);
      final response = await dio.get('https://dart.dev');
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(e.toString()),
        backgroundColor: Colors.deepOrange,
      ));
    }
  }

  Future resetPassword(String Email, context) async {
    try {
      await firebaseAuth.sendPasswordResetEmail(email: Email);
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(e.toString()),
        backgroundColor: Colors.deepOrange,
      ));
    }
  }

  Future logout(context) async {
    try {
      await firebaseAuth.signOut();
    } on FirebaseException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(e.toString()),
        backgroundColor: Colors.deepOrange,
      ));
    }
  }

  Future googleSignIn(context) async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser != null) {
        final GoogleSignInAuthentication googleAuth =
            await googleUser.authentication;
        final credentials = GoogleAuthProvider.credential(
            accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);

        UserCredential userCredential =
            await firebaseAuth.signInWithCredential(credentials);
        return userCredential;
      }
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(e.toString()),
        backgroundColor: Colors.deepOrange,
      ));
    }
  }
}
