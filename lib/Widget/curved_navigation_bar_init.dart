import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutterappdomotica/Rooms/ui/pages/rooms_page.dart';
import 'package:flutterappdomotica/Users/ui/pages/home_page.dart';
import 'package:flutterappdomotica/Users/ui/pages/profile_page.dart';
import 'package:flutterappdomotica/Users/ui/pages/setting_page.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
    HomePage(),
    RoomsPage(),
    ProfilePage(),
    SettingPage(),
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
      height: 65.0,
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
        FontAwesomeIcons.home,
//        CustomIcons.casa,
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
