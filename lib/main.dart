import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutterappdomotica/Rooms/ui/widget/curved_navigation_bar_init.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:flutterappdomotica/Rooms/model/room.dart';
import 'package:flutterappdomotica/Rooms/ui/screens/home_screen.dart';
import 'package:flutterappdomotica/Rooms/ui/screens/profile_screen.dart';
import 'package:flutterappdomotica/Rooms/ui/screens/room_details_screen.dart';
import 'package:flutterappdomotica/Rooms/ui/screens/rooms_screen.dart';
import 'package:flutterappdomotica/Users/ui/screens/init_screen.dart';
import 'package:flutterappdomotica/routes/route_page.dart';

import 'Rooms/ui/screens/devices_screen.dart';

void main() => runApp(MyApp());
/*{
  SystemChrome.setEnabledSystemUIOverlays([]).then((_){
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then((_){
      runApp(MyApp());
    });
  });

}*/

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        bloc: null,
        child: MaterialApp(
          title: 'Flutter Demo',
          initialRoute: '/',
          routes: getApplicationRoutes(),
       /*   onGenerateRoute: (settings){
            switch(settings.name){
              case 'roomSreem': return MaterialPageRoute(
                builder: (context)=> RoomsScreen()
              );
              break;
              case 'roomDetailsScreen': return MaterialPageRoute(
                builder: (context) => RoomDetailsScreen()
              );
              break;
              case 'profileScreen': return MaterialPageRoute(
                builder: (context) => ProfileScreen()
              );
              break;
              default: return MaterialPageRoute(
                  builder: (context)=> HomeScreen()
              );
            }
          },*/
        ));
  }

}
