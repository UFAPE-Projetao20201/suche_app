// Flutter imports:
import 'package:flutter/material.dart';
import 'package:mdi/mdi.dart';

// Project imports:
import 'package:suche_app/model/user.dart';
import 'package:suche_app/services/storage.dart';
import 'package:suche_app/util/constants.dart';
import 'package:suche_app/views/components/bottom_navigation_component.dart';
import 'package:suche_app/views/eventsPages/listEventsPage/listEventsPage.dart';
import 'package:suche_app/views/eventsPages/listMyEventsPage/listMyEventsPage.dart';
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
            ListEventsPage(user: widget.user,),

            ListMyEventsPage(user: widget.user,),

            ProfilePage(user: widget.user,),

          ],
        ),
      ),

      floatingActionButton: Visibility(
        visible: widget.user.isPromoter && _currentIndex == 1,
        child: FloatingActionButton.extended(
            onPressed: () => Navigator.of(context).pushNamed(registerEventRoute, arguments: widget.user),
            label: const Text(
              "Criar Evento",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontFamily: 'OpenSans',
                fontSize: 18,
              ),
            ),
            icon: const Icon(Mdi.plus),
        )
      )
    );
  }
}
