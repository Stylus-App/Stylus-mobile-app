import 'package:flutter/material.dart';

import '../../../constants.dart';
import '../../../size_config.dart';

class SplashContent extends StatelessWidget {
  const SplashContent({
    Key? key,
    this.text,
    this.image,
    this.title,
  }) : super(key: key);
  final String? text, image, title;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const Spacer(),
        Text(
          title!,
          style: TextStyle(
            fontFamily: 'krona',
            fontSize: getProportionateScreenWidth(50),
            color: kPrimaryColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        const Spacer(
          flex: 3,
        ),
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Card(
            elevation: 0,
            color: Colors.white
                .withOpacity(0.6), //Colors.redAccent.withOpacity(0.5),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            child: Padding(
              padding: const EdgeInsets.all(25),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text(
                  text!,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontFamily: 'krona',
                      color: kPrimaryColor,
                      fontSize: getProportionateScreenWidth(15),
                      fontWeight: FontWeight.w400),
                ),
              ),
            ),
          ),
        ),
        //
        const Spacer(flex: 2),
        // Image.asset(
        //   image!,
        //   height: getProportionateScreenHeight(265),
        //   width: getProportionateScreenWidth(235),
        // ),
      ],
    );
  }
}
