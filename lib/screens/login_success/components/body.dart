import 'package:flutter/material.dart';
// import 'package:katale_ko_client/components/default_button.dart';
// import 'package:katale_ko_client/screens/home/home_screen.dart';
// import 'package:katale_ko_client/size_config.dart';
import 'package:draemai/components/default_button.dart';
import 'package:draemai/size_config.dart';
import 'package:draemai/screens/Home/home_screen.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/splash/s17.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(mainAxisAlignment: MainAxisAlignment.end, children: [
          Padding(
              padding: const EdgeInsets.all(12.0),
              child: Card(
                elevation: 0,
                color: Colors.white
                    .withOpacity(0.4), //Colors.redAccent.withOpacity(0.5),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(25),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      children: [
                        Text(
                          "Start creating your unique images",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontFamily: 'krona',
                              color: Colors.white,
                              fontSize: getProportionateScreenWidth(22),
                              fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Get started to make your dreams come to life by creating the most stunning images ever",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontFamily: 'muli',
                                color: Colors.white,
                                fontSize: getProportionateScreenWidth(15),
                                fontWeight: FontWeight.w300),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(12.0),
                          child: GestureDetector(
                              child: const DefaultButton(
                                text: "Get Started",
                              ),
                              onTap: () => Navigator.pushNamed(
                                  context, HomeScreen.routeName)),
                        )
                      ],
                    ),
                  ),
                ),
              ))
        ]));
  }
}
