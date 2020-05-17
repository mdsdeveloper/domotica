import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterappdomotica/Rooms/ui/screens/rooms_screen.dart';
import 'package:flutterappdomotica/Rooms/ui/screens/home_screen.dart';
import 'package:flutterappdomotica/Rooms/ui/screens/profile_screen.dart';
import 'package:flutterappdomotica/Rooms/ui/screens/scenario_screen.dart';
import 'package:flutterappdomotica/Rooms/ui/screens/setting_screen.dart';
import 'package:flutterappdomotica/Users/ui/widget/button_sign_in.dart';
import 'package:flutterappdomotica/constants.dart';
import 'package:flutterappdomotica/custom_icons.dart';

class CurvedNavigationBarInit extends StatefulWidget {

  @override
  CurvedNavigationBarInitState createState() => CurvedNavigationBarInitState();
}

class CurvedNavigationBarInitState extends State<CurvedNavigationBarInit> {
  int _selectedItem = 0;
  var pageController = PageController();
  final navigatorKey = GlobalKey();
  final pagekey = GlobalKey<CurvedNavigationBarState>();

  var _widgetsChildren = [
    HomeScreen(),
    RoomsScreen(),
    ProfileScreen(),
    SettingScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: _buildCurvedNavigationBar(),
      body: PageView(
          key: pagekey,
          children: _widgetsChildren,
          controller: pageController,
          onPageChanged: (index) {
            setState(() {
              _selectedItem = index;
            });
          }),
    );
  }

  Widget _buildCurvedNavigationBar() {
    return Container(
      height: 60.0,
      child: CurvedNavigationBar(
        key: navigatorKey,
        index: _selectedItem,
        height: 50.0,
        items: items(),
        color: Color(0xFF4268D3),
        buttonBackgroundColor: Color(0xFF4268D3),
        backgroundColor: Colors.blueAccent,
        animationCurve: Curves.easeInOut,
        animationDuration: Duration(milliseconds: 200),
        onTap: onTapTapped,
      ),
    );
  }

  List<Widget> items() {
    return <Widget>[
      Icon(
        CustomIcons.casa,
        size: 30,
        color: Colors.white,
      ),
      Icon(
        Icons.apps,
        size: 30,
        color: Colors.white,
      ),
      Icon(
        Icons.tag_faces,
        size: 30,
        color: Colors.white,
      ),
      Icon(
        Icons.settings,
        size: 30,
        color: Colors.white,
      ),
//        Icon(Icons.perm_identity, size: 30),
    ];
  }

  void onTapTapped(index) {
    setState(() {
      _selectedItem = index;
      pageController.animateToPage(_selectedItem,
          duration: Duration(milliseconds: 200), curve: Curves.linear);
    });
  }
}
