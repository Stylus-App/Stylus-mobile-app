import 'package:flutter/material.dart';
import 'package:draemai/screens/Home/components/body.dart';
import 'package:draemai/screens/Home/components/customBottomNavBar.dart';

class HomeScreen extends StatelessWidget {
  static String routeName = "/home";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Body(),
      bottomNavigationBar: Container(
          color: Colors.transparent, child: const CustomBottomNavBar()),
    );
  }
}
