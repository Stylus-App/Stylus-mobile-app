import 'package:flutter/material.dart';
import 'package:draemai/constants.dart';
import 'package:draemai/screens/signin/sign_in_screen.dart';
import 'package:draemai/size_config.dart';

// This is the best practice
import '../components/splash_content.dart';
import '../../../components/default_button.dart';

class Body extends StatefulWidget {
  const Body({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  int currentPage = 0;
  List<Map<String, String>> splashData = [
    {
      "text":
          "Unleash your creativity and transform your \n photos into works of \n art with just a few \n clicks",
      "image": "assets/images/splash/s2.png",
      "title": "Dream AI"
    },
    {
      "text":
          "Experience the fun and excitement of creating \n unique, beautiful images \n and  Discover the artist \n within you",
      "image": "assets/images/splash/s10.png",
      "title": ""
    },
    {
      "text":
          "Find inspiration to \n bring your visions \n into life with our app, elevate and transform mundane photos into dynamic, eye-catching \n  images ",
      "image": "assets/images/splash/s20.png",
      "title": ""
    },
  ];
  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      onPageChanged: (value) {
        setState(() {
          currentPage = value;
        });
      },
      itemCount: splashData.length,
      itemBuilder: (BuildContext context, int index) => SizedBox(
        width: double.infinity,
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(splashData[index]["image"]!),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            children: <Widget>[
              Expanded(
                  flex: 3,
                  child: SplashContent(
                    image: splashData[index]["image"],
                    text: splashData[index]['text'],
                    title: splashData[index]['title'],
                  )),
              Expanded(
                flex: 2,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: getProportionateScreenWidth(20)),
                  child: Column(
                    children: <Widget>[
                      const Spacer(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          splashData.length,
                          (index) => buildDot(index: index),
                        ),
                      ),
                      const Spacer(flex: 3),
                      DefaultButton(
                        text: "Continue",
                        press: () {
                          Navigator.pushNamed(context, SignInScreen.routeName);
                        },
                      ),
                      const Spacer(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  AnimatedContainer buildDot({int? index}) {
    return AnimatedContainer(
      duration: kAnimationDuration,
      margin: EdgeInsets.only(right: 5),
      height: 6,
      width: currentPage == index ? 20 : 6,
      decoration: BoxDecoration(
        color: currentPage == index ? kPrimaryColor : Color(0xFFD8D8D8),
        borderRadius: BorderRadius.circular(3),
      ),
    );
  }
}
