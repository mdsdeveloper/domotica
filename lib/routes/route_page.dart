import 'package:flutter/material.dart';
import 'package:flutterappdomotica/Rooms/ui/pages/rooms_page.dart';
import 'package:flutterappdomotica/Users/ui/pages/home_page.dart';
import 'package:flutterappdomotica/Users/ui/pages/policy_page.dart';
import 'package:flutterappdomotica/Users/ui/pages/profile_page.dart';
import 'package:flutterappdomotica/Users/ui/pages/register_page.dart';
import 'package:flutterappdomotica/Users/ui/pages/init_page.dart';
import 'package:flutterappdomotica/Users/ui/pages/login_page.dart';
import 'package:flutterappdomotica/Users/ui/pages/setting_page.dart';
import 'package:flutterappdomotica/Users/ui/pages/terms_page.dart';
import 'package:flutterappdomotica/Widget/curved_navigation_bar_init.dart';
import 'package:flutterappdomotica/constants.dart';

Map<String, WidgetBuilder> getApplicationRoutes() {
  return <String, WidgetBuilder>{
    initPage      : (BuildContext context) => InitPage(),
    loginPage     : (BuildContext context) => LoginPage(),
    registerPage  : (BuildContext context) => RegisterPage(),
    policyPage    : (BuildContext context) => PolicyPage(),
    termsPage     : (BuildContext context) => TermsPage(),
    homePage      : (BuildContext context) => CurvedNavigationBarInit(),
    profilePage   : (BuildContext context) => ProfilePage(),
    roomsPage     : (BuildContext context) => RoomsPage(),
    settingPage   : (BuildContext context) => SettingPage(),

//    'forgotPasswordScreen': (BuildContext context) => ForgotPassword(),
//    'homePage': (BuildContext context) => CurvedNavigationBarInit(),
//    'roomDetailsScreen': (BuildContext context) => RoomDetailsScreen(),
  };
}

