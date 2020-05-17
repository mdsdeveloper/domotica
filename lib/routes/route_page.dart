import 'package:flutter/material.dart';
import 'package:flutterappdomotica/Rooms/model/room.dart';
import 'package:flutterappdomotica/Rooms/ui/screens/devices_screen.dart';
import 'package:flutterappdomotica/Rooms/ui/screens/home_screen.dart';
import 'package:flutterappdomotica/Rooms/ui/screens/profile_screen.dart';
import 'package:flutterappdomotica/Rooms/ui/screens/room_details_screen.dart';
import 'package:flutterappdomotica/Rooms/ui/screens/rooms_screen.dart';
import 'package:flutterappdomotica/Rooms/ui/widget/add_room.dart';
import 'package:flutterappdomotica/Rooms/ui/widget/curved_navigation_bar_init.dart';
import 'package:flutterappdomotica/Rooms/ui/widget/sign_in_app_init.dart';
import 'package:flutterappdomotica/Rooms/ui/widget/sign_in_app_init_cupertino.dart';
import 'package:flutterappdomotica/Users/ui/screens/account_screen.dart';
import 'package:flutterappdomotica/Users/ui/screens/forgot_password.dart';
import 'package:flutterappdomotica/Users/ui/screens/init_screen.dart';
import 'package:flutterappdomotica/Users/ui/screens/login_screen.dart';

Map<String, WidgetBuilder> getApplicationRoutes() {
  return <String, WidgetBuilder>{
    '/': (BuildContext context) => InitScreen(),
    'loginScreen': (BuildContext context) => LoginScreen(),
    'accountScreen': (BuildContext context) => AccountScreen(),
    'forgotPasswordScreen': (BuildContext context) => ForgotPassword(),
    'homeScreen': (BuildContext context) => CurvedNavigationBarInit(),
//    'deviceScreen': (BuildContext context) => DevicesScreen(),
  };
}

