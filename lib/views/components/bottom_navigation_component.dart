import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:suche_app/util/custom_colors.dart';

class BottomNavigationComponent {
  static bottomNavigation(int _selectedIndex, void Function(int) _functionOnItemSelected){
    return BottomNavyBar(
      selectedIndex: _selectedIndex,
      showElevation: true, // use this to remove appBar's elevation
      onItemSelected: _functionOnItemSelected,
      items: [
        BottomNavyBarItem(
          icon: Icon(Icons.home),
          title: Text('Home'),
          activeColor: CustomColors.orangePrimary,
        ),
        BottomNavyBarItem(
            icon: Icon(Icons.people),
            title: Text('Users'),
            activeColor: CustomColors.orangePrimary,
        ),
        BottomNavyBarItem(
            icon: Icon(Icons.message),
            title: Text('Messages'),
            activeColor: CustomColors.orangePrimary,
        ),
        BottomNavyBarItem(
            icon: Icon(Icons.settings),
            title: Text('Settings'),
            activeColor: CustomColors.orangePrimary,
        ),
      ],
    );
  }
}