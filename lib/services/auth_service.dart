// ignore_for_file: non_constant_identifier_names, unused_local_variable

// ignore: depend_on_referenced_packages
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dio/dio.dart';
import 'package:draemai/models/user.dart';

class Authentication {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final dio = Dio();

  Future LogIntoApi(id, Email, Password, path) async {
    try {
      ApiUser user = ApiUser(id: id, Email: Email, Password: Password);
      var header = {'Content-type': 'application/json; charset=utf-8'};
      var response = dio.post(path,
          data: user.toJson(), options: Options(headers: header));
    } catch (e) {
      print("Some Error");
    }
  }

  Future SignUpIntoApi(id, Email, Password, path) async {
    try {
      ApiUser user = ApiUser(id: id, Email: Email, Password: Password);
      var header = {'Content-type': 'application/json; charset=utf-8'};
      var response = dio.post(path,
          data: user.toJson(), options: Options(headers: header));
      print(response);
    } catch (e) {
      print("Some Error");
    }
  }

  Future register(String Email, String Password, context) async {
    try {
      UserCredential userCredential = await firebaseAuth
          .createUserWithEmailAndPassword(email: Email, password: Password);
      var response = LogIntoApi(userCredential.user!.uid, Email, Password,
          "http://192.168.43.205:8000/api/v1/signup/");
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
    try {
      UserCredential userCredential = await firebaseAuth
          .signInWithEmailAndPassword(email: Email, password: Password);
      LogIntoApi(userCredential.user!.uid, Email, Password,
          "http://192.168.43.205:8000/api/v1/login/");
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
