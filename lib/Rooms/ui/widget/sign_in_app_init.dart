import 'package:flutter/material.dart';
import 'package:flutterappdomotica/Rooms/ui/screens/room_screen.dart';
import 'package:flutterappdomotica/Rooms/ui/screens/home_screen.dart';
import 'package:flutterappdomotica/Rooms/ui/screens/profile_screen.dart';
import 'package:flutterappdomotica/Rooms/ui/screens/scenario_screen.dart';
import 'package:flutterappdomotica/Rooms/ui/screens/setting_screen.dart';
import 'package:flutterappdomotica/custom_icons.dart';

class SignInAppInit extends StatefulWidget {
  @override
  _SignInAppInitState createState() => _SignInAppInitState();
}

class _SignInAppInitState extends State<SignInAppInit> {
  int _selectedItem = 0;
  var _widgetsChildren = [HomeScreen(),RoomScreen(),ProfileScreen(),
    SettingScreen(),];
  var _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
          children: _widgetsChildren,
          controller: _pageController,
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
          onTap: onTapTapped,
          currentIndex: _selectedItem,
          items: [
            BottomNavigationBarItem(
                icon: Icon(CustomIcons.casa), title: Text("Inicio")),
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
      _pageController.animateToPage(_selectedItem, duration: Duration(milliseconds: 200), curve: Curves.linear);
    });
  }
}
