import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
//import 'package:udoit/main/login_signup/utils/T1Constant.dart';
import 'package:udoit/main/utils/AppConstant.dart';
//import 'package:udoit/main/login_signup/utils/T1Strings.dart';
import 'package:udoit/main/login_signup/utils/T1Widget.dart';
import 'package:udoit/main/widgets/AppWidget.dart';

import 'package:udoit/main/utils/AppGlobals.dart';
import 'package:nb_utils/nb_utils.dart';

import 'package:udoit/main/login_signup/screens/T1Signup.dart';
import 'package:udoit/main/utils/AppImages.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:udoit/main/login_signup/screens/signin.dart';
import 'package:udoit/main/login_signup/screens/register_page.dart';
import 'package:udoit/main/utils/AppColors.dart';

class T1Login extends StatefulWidget {
  static var tag = "/T1SignIn";
  //final String afterLoginRoute;

  @override
  _T1LoginState createState() => _T1LoginState();
}

class _T1LoginState extends State<T1Login> {
  bool rememberMe = false;
  EditTextStyle editTextStyle_fullName;
  EditTextStyle editTextStyle_email;
  EditTextStyle editTextStyle_password;

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
  }

  VoidCallback OnPressedCallback_signin() {
    setState(() {});
    //Dashboard().launch(context, isNewTask: true);
    //LoginRoutes loginRoutes = ModalRoute.of(context).settings.arguments;
    //Navigator.pushNamed(context, loginRoutes.nextRoute);

    //_pushPage(context, SignIn());
    SignIn signIn = SignIn();
    signIn.webSignIn(SignInProvider.Own,
        email: 'javierkijano@gmail.com', password: 'waimea1%');
    Globals.loggedIn = true;
    Navigator.pop(context);
  }

  VoidCallback OnPressedCallback_createNewAccount() {
    setState(() {});
    //Dashboard().launch(context, isNewTask: true);
    //LoginRoutes loginRoutes = ModalRoute.of(context).settings.arguments;
    //Navigator.pushNamed(context, loginRoutes.nextRoute, arguments: loginRoutes);
    //Navigator.popAndPushNamed(context, T1Signup.tag);
    Navigator.pushNamed(context, T1Signup.tag);
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
                        title: text("Remember",
                            textColor: Globals.appStore.textSecondaryColor),
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
                      child: shadowButton("Sign In", OnPressedCallback_signin)),
                  SizedBox(height: 24),
                  text("Forgot password?",
                      textColor: Globals.appStore.textPrimaryColor,
                      fontFamily: fontMedium),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      text("Don't have an account?",
                          textColor: Globals.appStore.textSecondaryColor,
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
                      //_showButtonPressDialog(context, 'Google');
                      int a = 0;
                      SignIn signIn = SignIn();
                      signIn.webSignIn(SignInProvider.Google);
                    },
                  ),
                  Divider(),
                  SignInButton(
                    Buttons.Facebook,
                    onPressed: () {
                      SignIn signIn = SignIn();
                      signIn.webSignIn(SignInProvider.Facebook);
                    },
                  ),
                  Divider(),
                  SignInButton(
                    Buttons.Twitter,
                    text: "Use Twitter",
                    onPressed: () {
                      SignIn signIn = SignIn();
                      signIn.webSignIn(SignInProvider.Twitter);
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
