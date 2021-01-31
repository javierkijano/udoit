import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:percent_indicator/percent_indicator.dart';

class GamificationSummary extends StatelessWidget {
  GamificationSummary() {}

  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      margin: EdgeInsets.all(30),
      child: Container(
        padding: EdgeInsets.all(30),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  flex: 4,
                  child: LayoutBuilder(builder: (context, constraints) {
                    return CachedNetworkImage(
                        width: constraints.maxWidth * 0.8,
                        imageUrl:
                            'https://firebasestorage.googleapis.com/v0/b/smartmobs-8bebb.appspot.com/o/gamification_levels%2Flevels%2Fprotester.png?alt=media&token=45d5791b-b614-4026-bf5c-4e3340c1e8dc');
                  }),
                ),
                VerticalDivider(thickness: 0.5),
                Expanded(
                  flex: 4,
                  child: LayoutBuilder(builder: (context, constraints) {
                    return CircularPercentIndicator(
                      radius: constraints.maxWidth * 1,
                      lineWidth: 25.0,
                      animation: true,
                      percent: 0.7,
                      center: new Text(
                        "70.0%",
                        style: new TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 40.0),
                      ),
                      /*footer: new Text(
                                  "Sales this week",
                                  style: new TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17.0),
                                ),*/
                      circularStrokeCap: CircularStrokeCap.round,
                      progressColor: Colors.purple,
                    );
                  }),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  flex: 4,
                  child: Container(
                      padding: EdgeInsets.only(top: 15),
                      child: Text(
                        'Level: Rookie',
                        textAlign: TextAlign.center,
                        style: new TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20.0),
                      )),
                ),
                Expanded(
                  flex: 4,
                  child: Container(
                      padding: EdgeInsets.only(top: 15),
                      child: Text(
                        'Level Achievements',
                        textAlign: TextAlign.center,
                        style: new TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20.0),
                      )),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
