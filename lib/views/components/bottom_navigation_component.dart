// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:mdi/mdi.dart';

// Project imports:
import 'package:suche_app/util/custom_colors.dart';

class BottomNavigationComponent {
  static bottomNavigation(int _selectedIndex, void Function(int) _functionOnItemSelected){
    return BottomNavyBar(
      selectedIndex: _selectedIndex,
      showElevation: true, // use this to remove appBar's elevation
      onItemSelected: _functionOnItemSelected,
      items: [
        BottomNavyBarItem(
          icon: Icon(Mdi.compass),
          title: Text('Home'),
          activeColor: CustomColors.orangePrimary,
        ),
        BottomNavyBarItem(
            icon: Icon(Mdi.trendingUp),
            title: Text('Em alta'),
            activeColor: CustomColors.orangePrimary,
        ),
        BottomNavyBarItem(
            icon: Icon(Mdi.partyPopper),
            title: Text('Eventos'),
            activeColor: CustomColors.orangePrimary,
        ),
        BottomNavyBarItem(
            icon: Icon(Mdi.account),
            title: Text('Perfil'),
            activeColor: CustomColors.orangePrimary,
        ),
      ],
    );
  }
}
