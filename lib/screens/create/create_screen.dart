import 'package:draemai/constants.dart';
import 'package:draemai/screens/Home/components/customBottomNavBar.dart';
import 'package:draemai/screens/create/components/body.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CreateScreen extends StatelessWidget {
  static String routeName = "/create";
  const CreateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final image = ModalRoute.of(context)!.settings.arguments;
    return Scaffold(
      appBar: AppBar(),
      body: Body(image: image),
      bottomNavigationBar: const CustomBottomNavBar(),
    );
  }
}
