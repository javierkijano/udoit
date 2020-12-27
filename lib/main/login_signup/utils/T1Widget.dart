import 'package:flutter/material.dart';
import 'package:flutter_tags/flutter_tags.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:udoit/main/widgets/AppWidget.dart';

import 'package:udoit/main/utils/AppGlobals.dart';
import 'T1Colors.dart';
import 'T1Constant.dart';
//import 'dart:ui';

//-------------------------------------------Form-------------------------------------------------------------------------
// EditText rounded Style
class EditTextStyle extends StatelessWidget {
  var hintText;
  bool isPassword;
  TextEditingController controller;

  EditTextStyle(this.hintText, {this.isPassword = true, this.controller}) {
    if (controller == null) {
      controller = TextEditingController();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(40, 0, 40, 0),
      child: TextFormField(
        style:
            TextStyle(fontSize: textSizeLargeMedium, fontFamily: fontRegular),
        obscureText: isPassword,
        controller: controller,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(24, 18, 24, 18),
          hintText: hintText,
          filled: true,
          fillColor: t1_edit_text_background,
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(40),
              borderSide:
                  const BorderSide(color: t1_edit_text_background, width: 0.0)),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(40),
            borderSide:
                const BorderSide(color: t1_edit_text_background, width: 0.0),
          ),
        ),
      ),
    );
  }

  getText() {
    return controller.text;
  }
}

// EditText
Padding editTextCard(var hintText) {
  return Padding(
    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
    child: TextFormField(
      style: TextStyle(fontSize: 18),
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(24, 10, 24, 10),
          hintText: hintText),
    ),
  );
}

// Login/SignUp HeadingElement
Text formHeading(var label) {
  return Text(label,
      style: TextStyle(
          color: Globals.appStore.textPrimaryColor,
          fontSize: 30,
          fontFamily: 'Bold'),
      textAlign: TextAlign.center);
}

Text formSubHeadingForm(var label) {
  return Text(label,
      style: TextStyle(
          color: Globals.appStore.textSecondaryColor,
          fontSize: 20,
          fontFamily: 'Bold'),
      textAlign: TextAlign.center);
}

// Other Text
Text formLink(var label) {
  return Text(label,
      style: TextStyle(color: t1_blue, fontSize: 18),
      textAlign: TextAlign.center);
}

//-------------------------------------------Button-------------------------------------------------------------------------

SizedBox buttonStyle(var text) {
  return SizedBox(
    width: double.infinity,
    height: 60,
    child: MaterialButton(
      child: Text(text, style: TextStyle(fontSize: 18)),
      textColor: t1_white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40.0)),
      color: t1_colorPrimary,
      onPressed: () => {},
    ),
  );
}

Widget shadowButton(String name, VoidCallback onPressedCallback) {
  return MaterialButton(
    height: 60,
    minWidth: double.infinity,
    child: text(name,
        fontSize: textSizeLargeMedium,
        textColor: t1_white,
        fontFamily: fontMedium),
    textColor: t1_white,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40.0)),
    color: t1_colorPrimary,
    onPressed: onPressedCallback,
  );
}

//-------------------------------------------Other-------------------------------------------------------------------------
Row rowHeading(var label) {
  return Row(
    children: <Widget>[
      Padding(
        padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
        child: Text(label,
            style: TextStyle(
                color: Globals.appStore.textPrimaryColor,
                fontSize: 18,
                fontFamily: 'Bold'),
            textAlign: TextAlign.left),
      ),
    ],
  );
}

Text Heading(var label) {
  return Text(label,
      style: TextStyle(
          color: Globals.appStore.textPrimaryColor,
          fontSize: 18,
          fontFamily: 'Bold'),
      textAlign: TextAlign.left);
}

Row profileText(var label, {var maxline = 1}) {
  return Row(
    children: <Widget>[
      Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 10, 0),
          child: text(label,
              fontSize: textSizeLargeMedium,
              textColor: Globals.appStore.textPrimaryColor,
              maxLine: maxline)),
    ],
  );
}

Text profile(var label) {
  return Text(label,
      style:
          TextStyle(color: t1_colorPrimary, fontSize: 18, fontFamily: 'Medium'),
      textAlign: TextAlign.center);
}

//-------------------------------------------View-------------------------------------------------------------------------
Divider view() {
  return Divider(color: t1_view_color, height: 0.5);
}
//-----------------------------------------------List------------------------------------------------------------

Text listHeading(var label) {
  return Text(label,
      style: TextStyle(
          color: Globals.appStore.textPrimaryColor,
          fontSize: 20,
          fontFamily: 'Bold'),
      textAlign: TextAlign.left);
}

Text listDesignationHeading(var label) {
  return Text(label,
      style: TextStyle(
          color: Globals.appStore.textPrimaryColor,
          fontSize: 16,
          fontFamily: 'Medium'),
      textAlign: TextAlign.left);
}

Text listOther(var label) {
  return Text(
    label,
    style: TextStyle(color: Globals.appStore.textSecondaryColor, fontSize: 16),
    textAlign: TextAlign.left,
  );
}

Text headerText(var text) {
  return Text(
    text,
    maxLines: 2,
    style: TextStyle(
        fontFamily: fontBold,
        fontSize: 22,
        color: Globals.appStore.textPrimaryColor),
  );
}

Text subHeadingText(var text) {
  return Text(text,
      style: TextStyle(
          fontFamily: fontBold,
          fontSize: 17.5,
          color: Globals.appStore.textSecondaryColor));
}

class AppButton extends StatefulWidget {
  var textContent;
  VoidCallback onPressed;

  AppButton({@required this.textContent, @required this.onPressed});

  @override
  State<StatefulWidget> createState() {
    return AppButtonState();
  }
}

class AppButtonState extends State<AppButton> {
  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      onPressed: widget.onPressed,
      textColor: t1_white,
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(80.0)),
      padding: const EdgeInsets.all(0.0),
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
              colors: <Color>[t1_colorPrimary, t1_colorPrimaryDark]),
          borderRadius: BorderRadius.all(Radius.circular(80.0)),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              widget.textContent,
              style: TextStyle(fontSize: 18),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}

class TopBar extends StatefulWidget {
  var titleName;

  TopBar(var this.titleName);

  @override
  State<StatefulWidget> createState() {
    return TopBarState();
  }
}

class TopBarState extends State<TopBar> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 60,
        child: Row(
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                finish(context);
              },
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
              child: Center(
                child: headerText(widget.titleName),
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  State<StatefulWidget> createState() {
    return null;
  }
}

Widget ring(String description) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      Container(
        width: 100,
        height: 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(150.0),
          border: Border.all(width: 16.0, color: t1_colorPrimary),
        ),
      ),
      SizedBox(height: 16),
      text(description,
          textColor: Globals.appStore.textPrimaryColor,
          fontSize: textSizeNormal,
          fontFamily: fontSemibold,
          isCentered: true,
          maxLine: 2)
    ],
  );
}

Widget shareIcon(String iconPath) {
  return Padding(
    padding: const EdgeInsets.only(left: 20, right: 20),
    child: Image.asset(iconPath, width: 28, height: 28, fit: BoxFit.fill),
  );
}
