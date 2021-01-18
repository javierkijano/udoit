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

class BottomNavBar extends StatelessWidget {
  int selectedIndex;

  BottomNavBar({Key key, this.selectedIndex = 0});

  void onItemTapped(BuildContext context, int index) async {
    selectedIndex = index;
    switch (selectedIndex) {
      case 0:
        {
          Navigator.pushNamed(context, Dashboard.tag);
          break;
        }
      case 1:
        {
          Navigator.pushNamed(context, Profile.tag);
          break;
        }
      case 2:
        {
          Navigator.pushNamed(context, NewInitiative.tag);
          break;
        }
      case 3:
        {
          Navigator.pushNamed(context, ShowInitiatives.tag);
          break;
        }
      case 4:
        {
          List<Initiative> temp =
              await Dashboard.of(context).trendingInitiatives;
          Navigator.pushNamed(context, Description.tag, arguments: temp[0]);
          break;
        }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
        data: Theme.of(context).copyWith(
            canvasColor: app_primaryColor,
            primaryColor: Colors.white,
            textTheme: Theme.of(context)
                .textTheme
                .copyWith(caption: TextStyle(color: Colors.grey))),
        child: BottomNavigationBar(
          showSelectedLabels: false,
          showUnselectedLabels: false,
          items: [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
                color: selectedIndex == 0
                    ? app_whiteColor
                    : app_whiteColor.withOpacity(0.2),
                size: app_bottomNavBarIconsSize,
              ),
              title: Text(''),
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.people,
                color: selectedIndex == 1
                    ? app_whiteColor
                    : app_whiteColor.withOpacity(0.2),
                size: app_bottomNavBarIconsSize,
              ),
              title: Text(''),
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.chat,
                color: selectedIndex == 2
                    ? app_whiteColor
                    : app_whiteColor.withOpacity(0.2),
                size: app_bottomNavBarIconsSize,
              ),
              title: Text(''),
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.chat,
                color: selectedIndex == 3
                    ? app_whiteColor
                    : app_whiteColor.withOpacity(0.2),
                size: app_bottomNavBarIconsSize,
              ),
              title: Text(''),
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.person,
                color: selectedIndex == 4
                    ? app_whiteColor
                    : app_whiteColor.withOpacity(0.2),
                size: app_bottomNavBarIconsSize,
              ),
              title: Text(''),
            ),
          ],
          onTap: (index) => onItemTapped(context, index),
          backgroundColor: Colors.grey,
        ));
  }
}
