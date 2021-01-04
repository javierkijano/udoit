import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
//import 'package:udoit/login_signup/utils/T1Constant.dart';
import 'package:udoit/utils/AppConstant.dart';
//import 'package:udoit/login_signup/utils/T1Strings.dart';
import 'package:udoit/login/utils/T1Widget.dart';
import 'package:udoit/widgets/AppWidget.dart';

import 'package:udoit/utils/AppGlobals.dart';
import 'package:nb_utils/nb_utils.dart';

import 'package:udoit/login/Signup.dart';
import 'package:udoit/utils/AppImages.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:udoit/login/authentification.dart';
import 'package:udoit/login/old_register_page.dart';
import 'package:udoit/utils/AppColors.dart';

class Login extends StatefulWidget {
  static var tag = "/SignIn";
  //final String afterLoginRoute;

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool rememberMe = false;
  EditTextStyle editTextStyle_fullName;
  EditTextStyle editTextStyle_email;
  EditTextStyle editTextStyle_password;
  SignInUp signInUp;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      editTextStyle_fullName = EditTextStyle("John Villa", isPassword: false);
      editTextStyle_email =
          EditTextStyle("john.villa@gmail.com", isPassword: false);
      editTextStyle_password = EditTextStyle("Password", isPassword: true);
    });
    signInUp = SignInUp();
  }

  VoidCallback OnPressedCallback_createNewAccount() {
    setState(() {});
    //Dashboard().launch(context, isNewTask: true);
    //LoginRoutes loginRoutes = ModalRoute.of(context).settings.arguments;
    //Navigator.pushNamed(context, loginRoutes.nextRoute, arguments: loginRoutes);
    //Navigator.popAndPushNamed(context, T1Signup.tag);
    Navigator.pushNamed(context, Signup.tag);
  }

  void _pushPage(BuildContext context, Widget page) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(builder: (_) => page),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Observer(
            builder: (_) => Container(
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height: 16),
                  Image.asset(t1_ic_ring, height: 100, width: 100),
                  SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      formHeading("Sign In/"),
                      formSubHeadingForm("Sign Up"),
                    ],
                  ),
                  SizedBox(height: 50),
                  editTextStyle_fullName,
                  SizedBox(height: 16),
                  editTextStyle_email,
                  SizedBox(height: 16),
                  editTextStyle_password,
                  SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 0, 0, 0),
                    child: CustomTheme(
                      child: CheckboxListTile(
                        title:
                            text("Remember", textColor: t2_textColorSecondary),
                        value: rememberMe,
                        onChanged: (newValue) {
                          rememberMe = newValue;
                          setState(() {});
                        },
                        controlAffinity: ListTileControlAffinity.leading,
                      ),
                    ),
                  ),
                  SizedBox(height: 8),
                  Padding(
                      padding: EdgeInsets.fromLTRB(40, 16, 40, 16),
                      child: shadowButton("Sign In", () {
                        signInUp
                            .webSignIn(SignInProvider.Own,
                                email: 'javierkijano@gmail.com',
                                password: 'waimea1%')
                            .then((value) {
                          Navigator.pop(context);
                        }).catchError((onError) {
                          print('... error in custom sign in');
                        });
                      })),
                  SizedBox(height: 24),
                  text("Forgot password?",
                      textColor: t2_textColorPrimary, fontFamily: fontMedium),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      text("Don't have an account?",
                          textColor: t2_textColorPrimary,
                          fontSize: textSizeLargeMedium),
                      SizedBox(width: 8),
                      GestureDetector(
                        child: text("Create new account",
                            fontFamily: fontMedium, textColor: t1_blue),
                        onTap: OnPressedCallback_createNewAccount,
                      ),
                    ],
                  ),
                  SizedBox(height: 24),
                  Divider(),
                  SignInButton(
                    Buttons.Google,
                    onPressed: () {
                      signInUp.webSignIn(SignInProvider.Google).then((value) {
                        Navigator.pop(context);
                      }).catchError((onError) {
                        print('... error in Google sign in');
                      });
                    },
                  ),
                  Divider(),
                  SignInButton(
                    Buttons.Facebook,
                    onPressed: () {
                      signInUp.webSignIn(SignInProvider.Facebook).then((value) {
                        Navigator.pop(context);
                      }).catchError((onError) {
                        print('... error in Facebook sign in');
                      });
                    },
                  ),
                  Divider(),
                  SignInButton(
                    Buttons.Twitter,
                    text: "Use Twitter",
                    onPressed: () {
                      signInUp.webSignIn(SignInProvider.Twitter).then((value) {
                        Navigator.pop(context);
                      }).catchError((onError) {
                        print('... error in Twitter sign in');
                      });
                    },
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
