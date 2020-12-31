import 'package:flutter/material.dart';

import 'package:flutter/cupertino.dart';
import 'package:udoit/main/dashboard/Dashboard.dart';
import 'package:udoit/main/newSmartMob/NewSmartMob_0.dart';
import 'package:udoit/main/profile/Profile.dart';
import 'package:udoit/main/utils/AppColors.dart';
import 'package:udoit/main/utils/AppConstant.dart';
import 'package:udoit/main/showInitiatives/ShowInitiatives.dart';

Widget bottomNavBar(BuildContext context, selectedIndex) {
  void onItemTapped(int index) {
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
          Navigator.pushNamed(context, NewSmartMob.tag);
          break;
        }
      case 3:
        {
          Navigator.pushNamed(context, ShowInitiatives.tag);
          break;
        }
      case 4:
        {
          Navigator.pushNamed(context, Profile.tag);
          break;
        }
    }
  }

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
        onTap: onItemTapped,
        backgroundColor: Colors.grey,
      ));
}
