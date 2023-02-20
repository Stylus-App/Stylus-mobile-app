//import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
//import 'package:katale_ko_client/components/no_account_text.dart';
//import 'package:katale_ko_client/components/socal_card.dart';
import '../../../size_config.dart';
import 'package:draemai/components/socal_card.dart';
//import '../../login_success/login_success_screen.dart';
//import '../../../services/auth_service.dart';
import 'sign_form.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: getProportionateScreenWidth(20)),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Column(
                    children: [
                      SizedBox(height: SizeConfig.screenHeight * 0.04),
                      Padding(
                        padding: const EdgeInsets.all(9.0),
                        child: Text(
                          "Welcome!",
                          style: TextStyle(
                              color: Colors.black.withOpacity(0.9),
                              fontSize: getProportionateScreenWidth(30),
                              fontWeight: FontWeight.bold,
                              fontFamily: 'muli'),
                        ),
                      ),
                      const Text(
                        "Sign in with your email and password  \nand start dreaming!",
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: SizeConfig.screenHeight * 0.08),
                      SignForm(),
                      SizedBox(height: SizeConfig.screenHeight * 0.08),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Signin with google",
                          style: TextStyle(
                            color: Colors.black.withOpacity(0.9),
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        // ignore: prefer_const_literals_to_create_immutables
                        children: [
                          const SocalCard(
                            icon: "assets/icons/google-icon.svg",
                            //   press: () async{
                            //     User? result = await Authentication().googleSignIn(context);
                            //     if(result != null){
                            //       if(result!=null){
                            //         Navigator.pushNamed(context, LoginSuccessScreen.routeName);
                            //       }
                            //     }
                            //   },
                          ),
                          //SocalCard(
                          //icon: "assets/icons/facebook-2.svg",
                          // press: () {},
                          //),
                          //SocalCard(
                          //icon: "assets/icons/twitter.svg",
                          // press: () {},
                          //),
                        ],
                      ),
                      SizedBox(
                          height: getProportionateScreenHeight(200),
                          child: Container(
                            color: Colors.white,
                          )),
                      //NoAccountText(),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
