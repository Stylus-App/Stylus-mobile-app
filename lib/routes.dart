import 'package:flutter/widgets.dart';
import 'package:draemai/screens/signin/sign_in_screen.dart';
import 'package:draemai/screens/signup/sign_up_screen.dart';
import 'package:draemai/screens/login_success/login_success_screen.dart';
import 'package:draemai/screens/Home/home_screen.dart';
import 'package:draemai/screens/create/create_screen.dart';

// We use name route
// All our routes will be available here
final Map<String, WidgetBuilder> routes = {
  //SplashScreen.routeName: (context) => SplashScreen(),
  SignInScreen.routeName: (context) => SignInScreen(),
  // ForgotPasswordScreen.routeName: (context) => ForgotPasswordScreen(),
  LoginSuccessScreen.routeName: (context) => LoginSuccessScreen(),
  SignUpScreen.routeName: (context) => const SignUpScreen(),
  // CompleteProfileScreen.routeName: (context) => CompleteProfileScreen(),
  // OtpScreen.routeName: (context) => OtpScreen(),
  HomeScreen.routeName: (context) => HomeScreen(),
  CreateScreen.routeName: (context) => const CreateScreen()
  // DetailsScreen.routeName: (context) => DetailsScreen(),
  // CartScreen.routeName: (context) => CartScreen(),
  // ProfileScreen.routeName: (context) => ProfileScreen(),
  // FavouriteScreen.routeName: (context) => FavouriteScreen(),
};
