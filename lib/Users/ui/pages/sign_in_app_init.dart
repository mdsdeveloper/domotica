import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterappdomotica/Users/ui/pages/home_page.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SignInAppInit extends StatefulWidget {
  @override
  SignInAppInitState createState() => SignInAppInitState();
}

class SignInAppInitState extends State<SignInAppInit> {
  int _selectedItem = 0;
  var pageController = PageController();
  final navigatorKey = GlobalKey<NavigatorState>();

  var _widgetsChildren = [
    HomePage(),
//    RoomsPage(),
//    ProfilePage(),
//    SettingPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
          key: navigatorKey,
          children: _widgetsChildren,
          controller: pageController,
          onPageChanged: (index) {
            setState(() {
              _selectedItem = index;
            });
          }),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildBottomNavigationBar() {
    return Theme(
      data: Theme.of(context).copyWith(canvasColor: Color(0xFF585DD6)),
      child: BottomNavigationBar(
          iconSize: 30.0,
          unselectedItemColor: Colors.grey,
          selectedItemColor: Colors.blue,
          showSelectedLabels: false,
          showUnselectedLabels: true,
//          onTap: (index) => navigatorKey.currentState.pushNamed('roomScreen'),
          onTap: onTapTapped,
          currentIndex: _selectedItem,
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(
                icon: Icon(FontAwesomeIcons.home), title: Text("Inicio")),
            BottomNavigationBarItem(
                icon: Icon(Icons.apps),
                title: Text(
                  "Habitaciones",
                  textScaleFactor: 0.97,
                )),
            BottomNavigationBarItem(
                icon: Icon(Icons.tag_faces), title: Text("Perfíl")),
            BottomNavigationBarItem(
                icon: Icon(Icons.settings), title: Text("Ajustes")),
          ]),
    );
  }

  void onTapTapped(index) {
    setState(() {
      _selectedItem = index;
      pageController.animateToPage(_selectedItem,
          duration: Duration(milliseconds: 200), curve: Curves.linear);
    });
  }
}
