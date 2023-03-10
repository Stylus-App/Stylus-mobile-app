import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:draemai/components/custom_surfix_icon.dart';
import 'package:draemai/components/form_error.dart';
//import 'package:dreamai/helper/keyboard.dart';

//import 'package:katale_ko_client/screens/forgot_password/forgot_password_screen.dart';
import 'package:draemai/services/auth_service.dart';
import 'package:draemai/screens/signup/sign_up_screen.dart';
import 'package:draemai/screens/login_success/login_success_screen.dart';

import '../../../components/default_button.dart';
import '../../../constants.dart';
import '../../../size_config.dart';

class SignForm extends StatefulWidget {
  @override
  _SignFormState createState() => _SignFormState();
}

class _SignFormState extends State<SignForm> {
  final _formKey = GlobalKey<FormState>();
  String? email;
  String? password;
  bool? remember = false;
  bool loading = false;
  final List<String?> errors = [];

  void addError({String? error}) {
    if (!errors.contains(error)) {
      setState(() {
        errors.add(error);
      });
    }
  }

  void removeError({String? error}) {
    if (errors.contains(error)) {
      setState(() {
        errors.remove(error);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    //bool loading = false;
    TextEditingController EmailFormController = TextEditingController();
    TextEditingController PasswordFormController = TextEditingController();
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
            // ignore: prefer_const_constructors
            decoration: InputDecoration(
                hintText: "  Email",
                // If  you are using latest version of flutter then lable text and hint text shown like this
                // if you r using flutter less then 1.20.* then maybe this is not working properly
                floatingLabelBehavior: FloatingLabelBehavior.always,
                suffixIcon:
                    const CustomSurffixIcon(svgIcon: "assets/icons/Mail.svg"),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                )),
          ),
          SizedBox(height: getProportionateScreenHeight(30)),
          TextFormField(
            controller: PasswordFormController,
            obscureText: true,
            onSaved: (newValue) => password = newValue,
            onChanged: (value) {
              if (value.isNotEmpty) {
                removeError(error: kPassNullError);
              } else if (value.length >= 8) {
                removeError(error: kShortPassError);
              }
              return null;
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
                )),
          ),
          SizedBox(height: getProportionateScreenHeight(30)),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //Checkbox(
              // value: remember,
              //activeColor: kPrimaryColor,
              //onChanged: (value) {
              // setState(() {
              //  remember = value;
              //});
              //},
              //),
              //Text("Remember me"),
              //Spacer(),
              GestureDetector(
                // onTap: () => Navigator.pushNamed(
                //     context, ForgotPasswordScreen.routeName),
                child: const Text(
                  "Forgot your password?",
                  style: TextStyle(
                    color: Colors.blue,
                  ),
                ),
              )
            ],
          ),
          FormError(errors: errors),
          SizedBox(height: getProportionateScreenHeight(20)),
          loading
              ? const CircularProgressIndicator()
              : DefaultButton(
                  text: "Login",
                  press: () async {
                    //---->Navigator.pushNamed(context, LoginSuccessScreen.routeName);
                    //Navigator.pushNamed(context, LoginSuccessScreen.routeName);

                    setState(() {
                      loading = true;
                    });

                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      // if all are valid then go to success screen
                      // KeyboardUtil.hideKeyboard(context);
                      User? result = await Authentication().login(
                          EmailFormController.text,
                          PasswordFormController.text,
                          context);
                      setState(() {
                        loading = false;
                      });

                      if (result != null) {
                        // ignore: use_build_context_synchronously
                        Navigator.pushNamed(
                            context, LoginSuccessScreen.routeName);
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
                const Text("Dont have an account?"),
                GestureDetector(
                  // onTap: () => Navigator.pushNamed(
                  //     context, ForgotPasswordScreen.routeName),
                  child: GestureDetector(
                    child: const Text(
                      " Sign Up",
                      style: TextStyle(
                        color: Colors.blue,
                      ),
                    ),
                    onTap: () =>
                        Navigator.pushNamed(context, SignUpScreen.routeName),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  TextFormField buildPasswordFormField() {
    TextEditingController PasswordFormController = TextEditingController();
    return TextFormField(
      controller: PasswordFormController,
      obscureText: true,
      onSaved: (newValue) => password = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kPassNullError);
        } else if (value.length >= 8) {
          removeError(error: kShortPassError);
        }
        return null;
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
        labelText: "Password",
        hintText: "Enter your password",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Lock.svg"),
      ),
    );
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
        labelText: "Email",
        hintText: "Enter your email",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Mail.svg"),
      ),
    );
  }
}
