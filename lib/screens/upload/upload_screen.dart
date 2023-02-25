import 'package:flutter/material.dart';
import 'components/body.dart';

class UploadScreen extends StatelessWidget {
  const UploadScreen({super.key});
  static String routeName = "/upload";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sign Up"),
      ),
      body: Body(),
    );
  }
}
