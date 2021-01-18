import 'package:flutter/material.dart';

import 'package:flutter/cupertino.dart';
import 'package:udoit/dashboard/Dashboard.dart';
import 'package:udoit/models/initiative.dart';
import 'package:udoit/newInitiative/NewInitiative.dart';
import 'package:udoit/profile/Profile.dart';
import 'package:udoit/utils/AppColors.dart';
import 'package:udoit/utils/AppConstant.dart';
import 'package:udoit/showInitiatives/ShowInitiativesList.dart';
import 'package:udoit/description/description.dart';
import 'package:udoit/widgets/AppWidget.dart';

class UpNavBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => Size.fromHeight(100.0);

  UpNavBar({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      //backgroundColor: grocery_colorPrimary,
      title: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              children: <Widget>[
                IconButton(
                    icon: Icon(Icons.menu),
                    onPressed: () async {
                      await Scaffold.of(context).openDrawer();
                    }),
                SizedBox(width: spacing_large),
                text("udoit.org",
                    textColor: appWhite,
                    fontFamily: fontBold,
                    fontSize: textSizeLargeMedium),
              ],
            ),
            Row(
              children: <Widget>[
                GestureDetector(
                  child: Icon(Icons.add),
                  onTap: () {
                    Navigator.pushNamed(context, NewInitiative.tag);
                  },
                ),
                SizedBox(width: spacing_standard_new),
                GestureDetector(
                  child: Icon(Icons.search),
                  onTap: () {
                    //NewInitiativePage1.dart
                  },
                ),
                SizedBox(width: spacing_standard_new),
                GestureDetector(
                  child: Icon(Icons.notifications),
                  onTap: () {
                    //GroceryNotification().launch(context);
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
