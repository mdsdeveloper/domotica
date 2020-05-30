import 'package:flutter/material.dart';
import 'package:flutterappdomotica/Users/ui/screen/init_screen.dart';

Map<String, WidgetBuilder> getApplicationRoutes() {
  return <String, WidgetBuilder>{
    '/': (BuildContext context) => InitScreen(),
//    'loginScreen': (BuildContext context) => LoginScreen(),
//    'accountScreen': (BuildContext context) => AccountScreen(),
//    'forgotPasswordScreen': (BuildContext context) => ForgotPassword(),
//    'homeScreen': (BuildContext context) => CurvedNavigationBarInit(),
//    'roomDetailsScreen': (BuildContext context) => RoomDetailsScreen(),
  };
}

