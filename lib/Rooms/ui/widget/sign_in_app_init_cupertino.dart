import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterappdomotica/Rooms/ui/screens/room_details_screen.dart';
import 'package:flutterappdomotica/Rooms/ui/screens/rooms_screen.dart';
import 'package:flutterappdomotica/Rooms/ui/screens/home_screen.dart';
import 'package:flutterappdomotica/Rooms/ui/screens/profile_screen.dart';
import 'package:flutterappdomotica/Rooms/ui/screens/scenario_screen.dart';
import 'package:flutterappdomotica/Rooms/ui/screens/setting_screen.dart';
import 'package:flutterappdomotica/Users/ui/widget/button_sign_in.dart';
import 'package:flutterappdomotica/constants.dart';
import 'package:flutterappdomotica/custom_icons.dart';

class SignInAppInitCupertino extends StatefulWidget {
  @override
  SignInAppInitCupertinoState createState() => SignInAppInitCupertinoState();
}

class SignInAppInitCupertinoState extends State<SignInAppInitCupertino> {
  int _selectedItem = 0;
  var pageController = PageController();
  final navigatorKey = GlobalKey<NavigatorState>();

  var _widgetsChildren = [
    HomeScreen(),
    RoomsScreen(),
    ProfileScreen(),
    SettingScreen(),
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
        child: CupertinoTabScaffold(
          tabBar: CupertinoTabBar(
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
            ],
            backgroundColor: Colors.indigoAccent,
            onTap: onTapTapped,
            currentIndex: _selectedItem,
            activeColor: Colors.blue,
            inactiveColor: Colors.grey,
            iconSize: 30.0,
          ),
          tabBuilder: (context, index) {
            switch (index) {
              case 0:
                return CupertinoTabView(builder: (context) => HomeScreen());
                break;
              case 1:
                return CupertinoTabView(builder: (context) => RoomsScreen());
                break;
              case 2:
                return CupertinoTabView(builder: (context) => ProfileScreen());
                break;
              case 3:
                return CupertinoTabView(builder: (context) => SettingScreen());
                break;
              case 4:
                return CupertinoTabView(builder: (context) => RoomsScreen());
                break;
              case 5:
                return CupertinoTabView(builder: (context) => RoomDetailsScreen());
                break;
              default:
                return CupertinoTabView(builder: (context) => HomeScreen());
            }
          },
        )

        /*BottomNavigationBar(
          iconSize: 30.0,
          unselectedItemColor: Colors.grey,
          selectedItemColor: Colors.blue,
          showSelectedLabels: false,
          showUnselectedLabels: true,
//          onTap: (index) => navigatorKey.currentState.pushNamed('roomScreen'),
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
          ]
      ),*/
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
