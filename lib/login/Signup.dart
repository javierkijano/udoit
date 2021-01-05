import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:udoit/login/utils/T1Colors.dart';
//import 'package:udoit/login_signup/utils/T1Constant.dart';
import 'package:udoit/utils/AppConstant.dart';
//import 'package:udoit/login_signup/utils/T1Images.dart';
//import 'package:udoit/login_signup/utils/T1Strings.dart';
import 'package:udoit/login/utils/T1Widget.dart';
import 'package:udoit/widgets/AppWidget.dart';

import 'package:udoit/models/AppGlobals.dart';
import 'package:udoit/utils/AppImages.dart';
import 'package:udoit/login/authentification.dart';
import 'package:udoit/utils/AppColors.dart';
import 'package:udoit/utils/AppConstant.dart';

class Signup extends StatelessWidget {
  Signup() {
    int a = 0;
  }
  static var tag = "/SignUp";
  SignInUp signIn = SignInUp();

  EditTextStyle editTextStylFullName;
  EditTextStyle editTextStyleEmailOrPhone;
  EditTextStyle editTextStylePassword;
  EditTextStyle editTextStyleRepassword;

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
                  editTextStylFullName =
                      EditTextStyle("Full Name", isPassword: false),
                  SizedBox(height: 16),
                  editTextStyleEmailOrPhone = EditTextStyle(
                      "Email Id / Phone Number",
                      isPassword: false),
                  SizedBox(height: 16),
                  editTextStylePassword =
                      EditTextStyle("Password", isPassword: false),
                  SizedBox(height: 16),
                  editTextStyleRepassword =
                      EditTextStyle("Re-Password", isPassword: false),
                  SizedBox(height: 20),
                  Padding(
                      padding: const EdgeInsets.fromLTRB(40, 0, 40, 0),
                      child: shadowButton("Sign up", () {
                        assert(editTextStylePassword.getText() ==
                            editTextStyleRepassword.getText());
                        /*signIn
                            .webSignUp(
                          SignInProvider.Own,
                          email: editTextStyleEmailOrPhone.getText(),
                          password: editTextStylePassword.getText(),
                        */
                        Future.delayed(new Duration(milliseconds: 1))
                            .then((value) {
                          Navigator.pop(context);
                        }).catchError((onError) {
                          print('... error signing up ');
                        });
                      })),
                  SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      text("Already have an account?",
                          textColor: t2_textColorSecondary,
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
