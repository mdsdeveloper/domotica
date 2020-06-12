import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterappdomotica/Users/ui/widget/item_profile.dart';
import 'package:flutterappdomotica/Widget/gradient_back.dart';
import 'package:flutterappdomotica/Widget/title_header.dart';

class SettingPage extends StatefulWidget {
  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  double screenWidth;
  double screenHeight;

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Stack(
        children: <Widget>[
          GradientBack(height: null),
          _buildAppBarSetting(),
          Container(
              color: Colors.transparent,
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              margin: EdgeInsets.only(top: 80, right: 10, left: 10, bottom: 10),
              child: ListView(children: _listItem()))
        ],
      ),
    );
  }

  Widget _buildAppBarSetting() {
    return TitleHeader(
      text: "Ajustes",
      size: 20.0,
      onPressed: (){
//        Navigator.pushNamed(context, 'profileScreen');
//        Navigator.push(context,CupertinoPageRoute(builder: (context) {
//          return ProfileScreen();
//        }));
//        Navigator.of(context).pop();
      },
    );
  }

  List<Widget> _listItem() {
    final List<Widget> listItem = [];

    listItem
      ..add(ItemProfile(
          text: "Escenarios", iconData: Icons.filter_none, onPressed: () {}))
      ..add(Divider(height: 2));
    listItem
      ..add(ItemProfile(
          text: "Tutorial", iconData: Icons.movie_filter, onPressed: () {}))
      ..add(Divider(height: 2));
    listItem
      ..add(ItemProfile(
          text: "Viviendas", iconData: Icons.home, onPressed: () {}))
      ..add(Divider(height: 2));
    listItem
      ..add(ItemProfile(
          text: "Habitaciones", iconData: Icons.input, onPressed: () {}))
      ..add(Divider(height: 2));
    listItem
      ..add(ItemProfile(
          text: "Regiones", iconData: Icons.donut_large, onPressed: () {}))
      ..add(Divider(height: 2));
    listItem
      ..add(ItemProfile(
          text: "Idiomas", iconData: Icons.language, onPressed: () {}))
      ..add(Divider(height: 2));

    listItem
      ..add(ItemProfile(
          text: "Condiciones generales",
          iconData: Icons.info_outline,
          onPressed: () {}))
      ..add(Divider(height: 2));
    listItem
      ..add(ItemProfile(
          text: "Contacto", iconData: Icons.contact_phone, onPressed: () {}))
      ..add(Divider(height: 4));

    return listItem;
  }
}
