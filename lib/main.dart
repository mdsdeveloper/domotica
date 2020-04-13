import 'package:flutter/material.dart';
import 'package:flutterappdomotica/User/ui/screens/login_screen.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        bloc: null,
        child: MaterialApp(
          title: 'Flutter Demo',
          home: LoginScreen(),
        )
    );
  }
}
