import 'package:flutter/material.dart';
import 'package:flutterappdomotica/Users/ui/pages/register_page.dart';
import 'package:flutterappdomotica/Users/ui/pages/init_page.dart';
import 'package:flutterappdomotica/Users/ui/pages/login_page.dart';
import 'package:flutterappdomotica/constants.dart';

Map<String, WidgetBuilder> getApplicationRoutes() {
  return <String, WidgetBuilder>{
    '/'                : (BuildContext context) => InitPage(),
    loginPage      : (BuildContext context) => LoginPage(),
    registerPage  : (BuildContext context) => RegisterPage(),
//    'forgotPasswordScreen': (BuildContext context) => ForgotPassword(),
//    'homeScreen': (BuildContext context) => CurvedNavigationBarInit(),
//    'roomDetailsScreen': (BuildContext context) => RoomDetailsScreen(),
  };
}

