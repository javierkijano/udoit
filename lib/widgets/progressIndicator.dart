import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UdoitProgressIndicator extends StatelessWidget {
  double widthFactor;
  UdoitProgressIndicator({Key key, this.widthFactor = 0.2});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: MediaQuery.of(context).size.width * widthFactor,
        width: MediaQuery.of(context).size.width * widthFactor,
        child: CircularProgressIndicator(),
      ),
    );
  }
}
