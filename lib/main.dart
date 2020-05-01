import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutterappdomotica/routes/route_page.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';

void main() =>  runApp(MyApp());/*{
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
//          home: InitScreen(),
        ));
  }
}
