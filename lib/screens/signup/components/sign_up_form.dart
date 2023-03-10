import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:draemai/components/custom_surfix_icon.dart';
import 'package:draemai/components/default_button.dart';
import 'package:draemai/components/form_error.dart';
import 'package:draemai/services/preferences.dart';
//import 'package:katale_ko_client/components/custom_surfix_icon.dart';
//import 'package:katale_ko_client/components/default_button.dart';
import 'package:draemai/components/form_error.dart';
//import 'package:katale_ko_client/screens/complete_profile/complete_profile_screen.dart';
import 'package:draemai/services/auth_service.dart';
import 'dart:io';
import 'package:draemai/screens/signin/sign_in_screen.dart';

import '../../../constants.dart';
import '../../../size_config.dart';

class SignUpForm extends StatefulWidget {
  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _formKey = GlobalKey<FormState>();
  String? email;
  String? password;
  String? confirm_password;
  bool remember = false;
  bool loading = false;
  final List<String?> errors = [];

  void addError({String? error}) {
    if (!errors.contains(error))
      // ignore: curly_braces_in_flow_control_structures
      setState(() {
        errors.add(error);
      });
  }

  void removeError({String? error}) {
    if (errors.contains(error))
      // ignore: curly_braces_in_flow_control_structures
      setState(() {
        errors.remove(error);
      });
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController EmailFormController = TextEditingController();
    TextEditingController ConfirmPasswordController = TextEditingController();
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
              controller: EmailFormController,
              keyboardType: TextInputType.emailAddress,
              onSaved: (newValue) => email = newValue,
              onChanged: (value) {
                if (value.isNotEmpty) {
                  removeError(error: kEmailNullError);
                } else if (emailValidatorRegExp.hasMatch(value)) {
                  removeError(error: kInvalidEmailError);
                }
                return null;
              },
              validator: (value) {
                if (value!.isEmpty) {
                  addError(error: kEmailNullError);
                  return "";
                } else if (!emailValidatorRegExp.hasMatch(value)) {
                  addError(error: kInvalidEmailError);
                  return "";
                }
                return null;
              },
              decoration: InputDecoration(
                  hintText: " Email",
                  // If  you are using latest version of flutter then lable text and hint text shown like this
                  // if you r using flutter less then 1.20.* then maybe this is not working properly
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  suffixIcon:
                      const CustomSurffixIcon(svgIcon: "assets/icons/Mail.svg"),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                  ))),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildPasswordFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          TextFormField(
              obscureText: true,
              controller: ConfirmPasswordController,
              onSaved: (newValue) => confirm_password = newValue,
              onChanged: (value) {
                if (value.isNotEmpty) {
                  removeError(error: kPassNullError);
                } else if (value.isNotEmpty && password == confirm_password) {
                  removeError(error: kMatchPassError);
                }
                confirm_password = value;
              },
              validator: (value) {
                if (value!.isEmpty) {
                  addError(error: kPassNullError);
                  return "";
                } else if ((password != value)) {
                  addError(error: kMatchPassError);
                  return "";
                }
                return null;
              },
              decoration: InputDecoration(
                  hintText: " Re-enter Password",
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  suffixIcon:
                      const CustomSurffixIcon(svgIcon: "assets/icons/Lock.svg"),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                  ))),
          FormError(errors: errors),
          SizedBox(height: getProportionateScreenHeight(40)),
          loading
              ? const CircularProgressIndicator(
                  color: kPrimaryColor,
                )
              : DefaultButton(
                  text: "Sign up",
                  press: () async {
                    setState(() {
                      loading = true;
                    });

                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      // if all are valid then go to success screen
                      //
                      User? result = await Authentication().register(
                          EmailFormController.text,
                          ConfirmPasswordController.text,
                          context);
                      setState(() {
                        loading = false;
                      });

                      save_to_file('email_key', EmailFormController.text);
                      if (result != null) {
                        // ignore: use_build_context_synchronously
                        Navigator.pushNamed(context, SignInScreen.routeName);
                      }
                    }
                  },
                ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              // ignore: prefer_const_literals_to_create_immutables
              children: [
                const Text("Already have an account?"),
                GestureDetector(
                  // onTap: () => Navigator.pushNamed(
                  //     context, ForgotPasswordScreen.routeName),
                  child: GestureDetector(
                    child: const Text(
                      " Login",
                      style: TextStyle(
                        color: Colors.blue,
                      ),
                    ),
                    onTap: () =>
                        Navigator.pushNamed(context, SignInScreen.routeName),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  TextFormField buildConformPassFormField() {
    TextEditingController ConfirmPasswordController = TextEditingController();
    return TextFormField(
      obscureText: true,
      onSaved: (newValue) => confirm_password = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kPassNullError);
        } else if (value.isNotEmpty && password == confirm_password) {
          removeError(error: kMatchPassError);
        }
        confirm_password = value;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kPassNullError);
          return "";
        } else if ((password != value)) {
          addError(error: kMatchPassError);
          return "";
        }
        return null;
      },
      // ignore: prefer_const_constructors
      decoration: InputDecoration(
        labelText: "Confirm Password",
        hintText: "Re-enter your password",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: const CustomSurffixIcon(svgIcon: "assets/icons/Lock.svg"),
      ),
    );
  }

  TextFormField buildPasswordFormField() {
    TextEditingController PasswordFormController = TextEditingController();
    return TextFormField(
        obscureText: true,
        onSaved: (newValue) => password = newValue,
        onChanged: (value) {
          if (value.isNotEmpty) {
            removeError(error: kPassNullError);
          } else if (value.length >= 8) {
            removeError(error: kShortPassError);
          }
          password = value;
        },
        validator: (value) {
          if (value!.isEmpty) {
            addError(error: kPassNullError);
            return "";
          } else if (value.length < 8) {
            addError(error: kShortPassError);
            return "";
          }
          return null;
        },
        decoration: InputDecoration(
            hintText: " Password",
            // If  you are using latest version of flutter then lable text and hint text shown like this
            // if you r using flutter less then 1.20.* then maybe this is not working properly
            floatingLabelBehavior: FloatingLabelBehavior.always,
            suffixIcon:
                const CustomSurffixIcon(svgIcon: "assets/icons/Lock.svg"),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25),
            )));
  }

  TextFormField buildEmailFormField() {
    TextEditingController EmailFormController = TextEditingController();
    return TextFormField(
        controller: EmailFormController,
        keyboardType: TextInputType.emailAddress,
        onSaved: (newValue) => email = newValue,
        onChanged: (value) {
          if (value.isNotEmpty) {
            removeError(error: kEmailNullError);
          } else if (emailValidatorRegExp.hasMatch(value)) {
            removeError(error: kInvalidEmailError);
          }
          return null;
        },
        validator: (value) {
          if (value!.isEmpty) {
            addError(error: kEmailNullError);
            return "";
          } else if (!emailValidatorRegExp.hasMatch(value)) {
            addError(error: kInvalidEmailError);
            return "";
          }
          return null;
        },
        decoration: InputDecoration(
            hintText: " Password",
            // If  you are using latest version of flutter then lable text and hint text shown like this
            // if you r using flutter less then 1.20.* then maybe this is not working properly
            floatingLabelBehavior: FloatingLabelBehavior.always,
            suffixIcon:
                const CustomSurffixIcon(svgIcon: "assets/icons/Lock.svg"),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25),
            )));
  }
}
