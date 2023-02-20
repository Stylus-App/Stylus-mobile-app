import 'package:flutter/material.dart';
import 'package:draemai/routes.dart';
import 'package:draemai/screens/splash/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dream AI',
      theme: ThemeData(
        // is not restarted.
        primarySwatch: Colors.blue,
        appBarTheme: const AppBarTheme(
            iconTheme: IconThemeData(color: Colors.black),
            color: Colors.white,
            elevation: 0),
      ),
      home: const SplashScreen(),
      routes: routes,
    );
  }
}
