import 'package:flutter/material.dart';
//import 'package:share_plus/share_plus.dart';
import 'package:share_plus_linux/share_plus_linux.dart';

class ShareApp extends StatelessWidget {
  ShareApp({Key key}) : super(key: key) {}

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Icon(Icons.share),
      onTap: () {
        ShareLinux().share('check out my website https://smartmobs.org');
      },
    );
  }
}
