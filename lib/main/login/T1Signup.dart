import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:udoit/main/login/utils/T1Colors.dart';
//import 'package:udoit/main/login_signup/utils/T1Constant.dart';
import 'package:udoit/main/utils/AppConstant.dart';
//import 'package:udoit/main/login_signup/utils/T1Images.dart';
//import 'package:udoit/main/login_signup/utils/T1Strings.dart';
import 'package:udoit/main/login/utils/T1Widget.dart';
import 'package:udoit/main/widgets/AppWidget.dart';

import 'package:udoit/main/utils/AppGlobals.dart';
import 'package:udoit/main/utils/AppImages.dart';
import 'package:udoit/main/login/authentification.dart';

class T1Signup extends StatelessWidget {
  static var tag = "/T1SignUp";
  SignIn signIn = SignIn();

  EditTextStyle editTextStyle_fullName;
  EditTextStyle editTextStyle_emailOrPhone;
  EditTextStyle editTextStyle_password;
  EditTextStyle editTextStyle_repassword;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          alignment: Alignment.center,
          child: Observer(
            builder: (_) => SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height: 30),
                  Image.asset(t1_ic_ring, height: 100, width: 100),
                  SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      formHeading("Sign Up/"),
                      formSubHeadingForm("Sign In"),
                    ],
                  ),
                  SizedBox(height: 40),
                  editTextStyle_fullName =
                      EditTextStyle("Full Name", isPassword: false),
                  SizedBox(height: 16),
                  editTextStyle_emailOrPhone = EditTextStyle(
                      "Email Id / Phone Number",
                      isPassword: false),
                  SizedBox(height: 16),
                  editTextStyle_password =
                      EditTextStyle("Password", isPassword: false),
                  SizedBox(height: 16),
                  editTextStyle_repassword =
                      EditTextStyle("Re-Password", isPassword: false),
                  SizedBox(height: 20),
                  Padding(
                      padding: const EdgeInsets.fromLTRB(40, 0, 40, 0),
                      child: shadowButton("Sign up", () {
                        assert(editTextStyle_password.getText() ==
                            editTextStyle_repassword.getText());
                        signIn
                            .webSignUp(
                          SignInProvider.Own,
                          email: editTextStyle_emailOrPhone.getText(),
                          password: editTextStyle_password.getText(),
                        )
                            .then((value) {
                          //continue to next page
                        }).catchError((onError) {
                          print('... error signing up ');
                        });
                      })),
                  SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      text("Already have an account?",
                          textColor: Globals.appStore.textSecondaryColor,
                          fontSize: textSizeLargeMedium),
                      SizedBox(width: 8),
                      GestureDetector(
                        child: text("Sign In",
                            fontFamily: fontMedium, textColor: t1_blue),
                        onTap: () => Navigator.pop(context),
                      ),
                    ],
                  ),
                  SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
