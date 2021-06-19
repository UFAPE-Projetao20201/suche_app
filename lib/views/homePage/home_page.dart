import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:mdi/mdi.dart';
import 'package:suche_app/model/user.dart';
import 'package:suche_app/services/storage.dart';
import 'package:suche_app/util/constants.dart';
import 'package:suche_app/util/custom_colors.dart';
import 'package:suche_app/views/components/bottom_navigation_component.dart';
import 'package:suche_app/views/profilePage/profile_page.dart';

class HomePage extends StatefulWidget {
  final User user;

  HomePage({required this.user, Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  late PageController _pageController;
  bool _switchTypeEventValue = true;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('SucheApp'),
        actions: [
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () async {
              // Logout
              final SecureStorage secureStorage = SecureStorage();
              await secureStorage.deleteSecureData('user');

              Navigator.pushNamedAndRemoveUntil(
                context,
                loginRoute,
                (route) => false,
              );
            },
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationComponent.bottomNavigation(
        _currentIndex,
        (index) {
          setState(() => _currentIndex = index);
          _pageController.jumpToPage(index);
        },
      ),
      body: SizedBox.expand(
        child: PageView(
          controller: _pageController,
          onPageChanged: (index) {
            setState(() => _currentIndex = index);
          },
          children: <Widget>[
            Container(
              color: CustomColors.colorLightGray,
              height: double.infinity,
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(height: 20.0),
                    Text(
                      'Eventos',
                      style: TextStyle(
                        color: CustomColors.orangePrimary.shade400,
                        fontFamily: 'OpenSans',
                        fontSize: 30.0,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    SizedBox(height: 20.0),
                    FlutterSwitch(
                      width: 200.0,
                      height: 55.0,
                      toggleSize: 45.0,
                      borderRadius: 30.0,
                      padding: 8.0,
                      valueFontSize: 23,
                      showOnOff: true,
                      toggleColor: CustomColors.colorLightGray,//
                      activeColor: CustomColors.orangePrimary.shade400,
                      activeText: "Prensencial",
                      activeTextColor: CustomColors.colorLightGray,//
                      activeTextFontWeight: FontWeight.w900 ,
                      inactiveColor: CustomColors.orangePrimary.shade400,
                      inactiveText: "Virtual",
                      inactiveTextColor: CustomColors.colorLightGray,//
                      inactiveTextFontWeight: FontWeight.w900,
                      value: _switchTypeEventValue,
                      onToggle: (val) {
                        setState(() {
                          _switchTypeEventValue = val;
                        });
                      },
                    ),
                    SizedBox(height: 20.0),
                    Divider(
                      color: CustomColors.colorOrangeSecondary,
                    ),
                    Expanded(
                      child: ListView(
                        shrinkWrap: true,
                        children: <Widget>[
                          Container(
                            height: 220,
                            padding: EdgeInsets.all(15.0),
                            color: CustomColors.colorLightGray,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[

                                  // Nome do Evento
                                  Text(
                                    'Nome do Evento',
                                    style: TextStyle(
                                      color: CustomColors.orangePrimary.shade400,
                                      fontFamily: 'OpenSans',
                                      fontSize: 30.0,
                                      fontWeight: FontWeight.w900,
                                    ),
                                  ),

                                  // Descrição do evento
                                  Text(
                                    'Descrição do evento aqui',
                                    style: TextStyle(
                                      color: CustomColors.colorOrangeSecondary,
                                      fontFamily: 'OpenSans',
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.w400,
                                      fontStyle: FontStyle.italic
                                    ),
                                  ),
                                  SizedBox(height: 5.0),

                                  //Promotor do evento
                                  Row(
                                      children: <Widget>[
                                        Icon(
                                          Mdi.accountOutline,
                                          color: CustomColors.colorOrangeSecondary,
                                        ),
                                        SizedBox(width: 10.0,),
                                        Text(
                                          'Suche Eventos',
                                          style: TextStyle(
                                            color: CustomColors.colorOrangeSecondary,
                                            fontFamily: 'OpenSans',
                                            fontSize: 15.0,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ]
                                  ),

                                  //Data do evento
                                  Row(
                                      children: <Widget>[
                                        Icon(
                                          Mdi.calendarStar,
                                          color: CustomColors.colorOrangeSecondary,
                                        ),
                                        SizedBox(width: 10.0,),
                                        Text(
                                          '22/22/2222',
                                          style: TextStyle(
                                            color: CustomColors.colorOrangeSecondary,
                                            fontFamily: 'OpenSans',
                                            fontSize: 15.0,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ]
                                  ),

                                  //Valor do evento
                                  Row(
                                      children: <Widget>[
                                        Icon(
                                          Mdi.cash,
                                          color: CustomColors.colorOrangeSecondary,
                                        ),
                                        SizedBox(width: 10.0,),
                                        Text(
                                          'R\$ 22,22',
                                          style: TextStyle(
                                            color: CustomColors.colorOrangeSecondary,
                                            fontFamily: 'OpenSans',
                                            fontSize: 15.0,
                                            fontWeight: FontWeight.w900,
                                          ),
                                        ),
                                      ]
                                  ),

                                  //Local do evento
                                  Row(
                                      children: <Widget>[
                                        Icon(
                                          Mdi.mapMarker,
                                          color: CustomColors.colorOrangeSecondary,
                                        ),
                                        SizedBox(width: 10.0,),
                                        Text(
                                          'Rua da Festança, 10, Festival, Garanhuns-PE',
                                          style: TextStyle(
                                            color: CustomColors.colorOrangeSecondary,
                                            fontFamily: 'OpenSans',
                                            fontSize: 15.0,
                                          ),
                                        ),
                                      ]
                                  ),

                                  //Categoria do evento
                                  Row(
                                      children: <Widget>[
                                        Icon(
                                          Mdi.formatListChecks,
                                          color: CustomColors.colorOrangeSecondary,
                                        ),
                                        SizedBox(width: 10.0,),
                                        Text(
                                          'Show',
                                          style: TextStyle(
                                            color: CustomColors.colorOrangeSecondary,
                                            fontFamily: 'OpenSans',
                                            fontSize: 15.0,
                                          ),
                                        ),
                                      ]
                                  ),

                                ],
                            ),
                          ),
                          Divider(
                            color: CustomColors.colorOrangeSecondary,
                          ),

                          Container(
                            height: 220,
                            padding: EdgeInsets.all(15.0),
                            color: CustomColors.colorLightGray,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[

                                // Nome do Evento
                                Text(
                                  'Nome do Evento',
                                  style: TextStyle(
                                    color: CustomColors.orangePrimary.shade400,
                                    fontFamily: 'OpenSans',
                                    fontSize: 30.0,
                                    fontWeight: FontWeight.w900,
                                  ),
                                ),

                                // Descrição do evento
                                Text(
                                  'Descrição do evento aqui',
                                  style: TextStyle(
                                      color: CustomColors.colorOrangeSecondary,
                                      fontFamily: 'OpenSans',
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.w400,
                                      fontStyle: FontStyle.italic
                                  ),
                                ),
                                SizedBox(height: 5.0),

                                //Promotor do evento
                                Row(
                                    children: <Widget>[
                                      Icon(
                                        Mdi.accountOutline,
                                        color: CustomColors.colorOrangeSecondary,
                                      ),
                                      SizedBox(width: 10.0,),
                                      Text(
                                        'Suche Eventos',
                                        style: TextStyle(
                                          color: CustomColors.colorOrangeSecondary,
                                          fontFamily: 'OpenSans',
                                          fontSize: 15.0,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ]
                                ),

                                //Data do evento
                                Row(
                                    children: <Widget>[
                                      Icon(
                                        Mdi.calendarStar,
                                        color: CustomColors.colorOrangeSecondary,
                                      ),
                                      SizedBox(width: 10.0,),
                                      Text(
                                        '22/22/2222',
                                        style: TextStyle(
                                          color: CustomColors.colorOrangeSecondary,
                                          fontFamily: 'OpenSans',
                                          fontSize: 15.0,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ]
                                ),

                                //Valor do evento
                                Row(
                                    children: <Widget>[
                                      Icon(
                                        Mdi.cash,
                                        color: CustomColors.colorOrangeSecondary,
                                      ),
                                      SizedBox(width: 10.0,),
                                      Text(
                                        'R\$ 22,22',
                                        style: TextStyle(
                                          color: CustomColors.colorOrangeSecondary,
                                          fontFamily: 'OpenSans',
                                          fontSize: 15.0,
                                          fontWeight: FontWeight.w900,
                                        ),
                                      ),
                                    ]
                                ),

                                //Local do evento
                                Row(
                                    children: <Widget>[
                                      Icon(
                                        Mdi.mapMarker,
                                        color: CustomColors.colorOrangeSecondary,
                                      ),
                                      SizedBox(width: 10.0,),
                                      Text(
                                        'Rua da Festança, 10, Festival, Garanhuns-PE',
                                        style: TextStyle(
                                          color: CustomColors.colorOrangeSecondary,
                                          fontFamily: 'OpenSans',
                                          fontSize: 15.0,
                                        ),
                                      ),
                                    ]
                                ),

                                //Categoria do evento
                                Row(
                                    children: <Widget>[
                                      Icon(
                                        Mdi.formatListChecks,
                                        color: CustomColors.colorOrangeSecondary,
                                      ),
                                      SizedBox(width: 10.0,),
                                      Text(
                                        'Show',
                                        style: TextStyle(
                                          color: CustomColors.colorOrangeSecondary,
                                          fontFamily: 'OpenSans',
                                          fontSize: 15.0,
                                        ),
                                      ),
                                    ]
                                ),

                              ],
                            ),
                          ),
                          Divider(
                            color: CustomColors.colorOrangeSecondary,
                          ),

                          Container(
                            height: 220,
                            padding: EdgeInsets.all(15.0),
                            color: CustomColors.colorLightGray,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[

                                // Nome do Evento
                                Text(
                                  'Nome do Evento',
                                  style: TextStyle(
                                    color: CustomColors.orangePrimary.shade400,
                                    fontFamily: 'OpenSans',
                                    fontSize: 30.0,
                                    fontWeight: FontWeight.w900,
                                  ),
                                ),

                                // Descrição do evento
                                Text(
                                  'Descrição do evento aqui',
                                  style: TextStyle(
                                      color: CustomColors.colorOrangeSecondary,
                                      fontFamily: 'OpenSans',
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.w400,
                                      fontStyle: FontStyle.italic
                                  ),
                                ),
                                SizedBox(height: 5.0),

                                //Promotor do evento
                                Row(
                                    children: <Widget>[
                                      Icon(
                                        Mdi.accountOutline,
                                        color: CustomColors.colorOrangeSecondary,
                                      ),
                                      SizedBox(width: 10.0,),
                                      Text(
                                        'Suche Eventos',
                                        style: TextStyle(
                                          color: CustomColors.colorOrangeSecondary,
                                          fontFamily: 'OpenSans',
                                          fontSize: 15.0,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ]
                                ),

                                //Data do evento
                                Row(
                                    children: <Widget>[
                                      Icon(
                                        Mdi.calendarStar,
                                        color: CustomColors.colorOrangeSecondary,
                                      ),
                                      SizedBox(width: 10.0,),
                                      Text(
                                        '22/22/2222',
                                        style: TextStyle(
                                          color: CustomColors.colorOrangeSecondary,
                                          fontFamily: 'OpenSans',
                                          fontSize: 15.0,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ]
                                ),

                                //Valor do evento
                                Row(
                                    children: <Widget>[
                                      Icon(
                                        Mdi.cash,
                                        color: CustomColors.colorOrangeSecondary,
                                      ),
                                      SizedBox(width: 10.0,),
                                      Text(
                                        'R\$ 22,22',
                                        style: TextStyle(
                                          color: CustomColors.colorOrangeSecondary,
                                          fontFamily: 'OpenSans',
                                          fontSize: 15.0,
                                          fontWeight: FontWeight.w900,
                                        ),
                                      ),
                                    ]
                                ),

                                //Local do evento
                                Row(
                                    children: <Widget>[
                                      Icon(
                                        Mdi.mapMarker,
                                        color: CustomColors.colorOrangeSecondary,
                                      ),
                                      SizedBox(width: 10.0,),
                                      Text(
                                        'Rua da Festança, 10, Festival, Garanhuns-PE',
                                        style: TextStyle(
                                          color: CustomColors.colorOrangeSecondary,
                                          fontFamily: 'OpenSans',
                                          fontSize: 15.0,
                                        ),
                                      ),
                                    ]
                                ),

                                //Categoria do evento
                                Row(
                                    children: <Widget>[
                                      Icon(
                                        Mdi.formatListChecks,
                                        color: CustomColors.colorOrangeSecondary,
                                      ),
                                      SizedBox(width: 10.0,),
                                      Text(
                                        'Show',
                                        style: TextStyle(
                                          color: CustomColors.colorOrangeSecondary,
                                          fontFamily: 'OpenSans',
                                          fontSize: 15.0,
                                        ),
                                      ),
                                    ]
                                ),

                              ],
                            ),
                          ),
                          Divider(
                            color: Colors.white,
                          ),

                        ],
                      ),
                    )

                  ],

              )
            ),
            Container(
              color: Colors.red,
            ),
            Container(
              color: Colors.green,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    TextButton(
                      onPressed: () =>
                          Navigator.of(context).pushNamed(registerEventRoute),
                      child: Text(
                        'Cadastrar Evento',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            ProfilePage(
              user: widget.user,
            ),
            // Container(color: Colors.blue,),
          ],
        ),
      ),
    );
  }
}
