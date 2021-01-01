import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:udoit/main/utils/AppConstant.dart';
import 'package:udoit/main/widgets/AppWidget.dart';
import 'package:udoit/main/utils/AppColors.dart';

class Button1 extends StatefulWidget {
  static String tag = '/Button1';
  var textContent;
  VoidCallback onPressed;
  var isStroked = false;
  var height = 50.0;

  Button1(
      {@required this.textContent,
      @required this.onPressed,
      this.isStroked = false,
      this.height = 45.0});

  @override
  ButtonState createState() => ButtonState();
}

class ButtonState extends State<Button1> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onPressed,
      child: Container(
        height: widget.height,
        padding: EdgeInsets.fromLTRB(16, 4, 16, 4),
        alignment: Alignment.center,
        child: text(widget.textContent,
            textColor: widget.isStroked ? t4_colorPrimary : t4_white,
            isCentered: true,
            fontFamily: fontMedium,
            textAllCaps: true),
        decoration: widget.isStroked
            ? boxDecoration(bgColor: Colors.transparent, color: t4_colorPrimary)
            : boxDecoration(bgColor: t4_colorPrimary, radius: 4),
      ),
    );
  }
}
