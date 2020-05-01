import 'package:flutter/material.dart';
import 'package:flutterappdomotica/Users/ui/widget/item_profile.dart';
import 'package:flutterappdomotica/Widget/gradient_back.dart';
import 'package:flutterappdomotica/Widget/title_header.dart';

class SettingScreen extends StatefulWidget {
  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
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
              margin: EdgeInsets.only(top: 80, right: 20, left: 20, bottom: 10),
              child: ListView(children: _listItem()))
        ],
      ),
    );
  }

  Widget _buildAppBarSetting() {
    return TitleHeader(
      text: "Ajustes",
      size: 20.0,
    );
  }

  List<Widget> _listItem() {
    final List<Widget> listItem = [];

    listItem
      ..add(ItemProfile(
          text: "Escenarions", iconData: Icons.filter_none, onPressed: () {}))
      ..add(Divider(height: 4));
    listItem
      ..add(ItemProfile(
          text: "Tutorial", iconData: Icons.movie_filter, onPressed: () {}))
      ..add(Divider(height: 4));
    listItem
      ..add(ItemProfile(
          text: "Viviendas", iconData: Icons.home, onPressed: () {}))
      ..add(Divider(height: 4));
    listItem
      ..add(ItemProfile(
          text: "Habitaciones", iconData: Icons.input, onPressed: () {}))
      ..add(Divider(height: 4));
    listItem
      ..add(ItemProfile(
          text: "Regiones", iconData: Icons.donut_large, onPressed: () {}))
      ..add(Divider(height: 4));
    listItem
      ..add(ItemProfile(
          text: "Idiomas", iconData: Icons.language, onPressed: () {}))
      ..add(Divider(height: 4));

    listItem
      ..add(ItemProfile(
          text: "Condiciones generales",
          iconData: Icons.info_outline,
          onPressed: () {}))
      ..add(Divider(height: 4));
    listItem
      ..add(ItemProfile(
          text: "Contacto", iconData: Icons.contact_phone, onPressed: () {}))
      ..add(Divider(height: 4));

    return listItem;
  }
}
