import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterappdomotica/Widget/gradient_back.dart';
import 'package:flutterappdomotica/Widget/title_header.dart';
import 'package:flutterappdomotica/constants.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
//      appBar: AppBar(),
      body: Stack(
        children: <Widget>[
          GradientBack(height: null),
          _buildAppBarHome(),

        ],
      ),
    );
  }

  Widget _buildAppBarHome() {
    return TitleHeader(
      text: "Inicio",
      size: 20.0,
      onPressed: (){
//        Navigator.pushNamed(context, 'homeScreen');
//        Navigator.of(context).pop();
      },
    );
  }




}
