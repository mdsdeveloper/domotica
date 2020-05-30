import 'package:flutter/material.dart';
import 'package:flutterappdomotica/providers/provider.dart';
import 'package:flutterappdomotica/routes/route_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Provider(
        child: MaterialApp(
      title: 'Flutter Demo',
      initialRoute: '/',
      routes: getApplicationRoutes(),
    ));
  }
}
