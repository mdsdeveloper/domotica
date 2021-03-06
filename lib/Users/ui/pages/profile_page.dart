import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutterappdomotica/Users/api/auth_api.dart';
import 'package:flutterappdomotica/Users/ui/widget/item_profile.dart';
import 'package:flutterappdomotica/Widget/gradient_back.dart';
import 'package:flutterappdomotica/Widget/title_header.dart';
import 'package:flutterappdomotica/providers/provider.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  double screenWidth;
  double screenHeight;
  String _pathLogo = 'assets/images/neo.jpg';
  String _nameProfile = 'Nombre';
  String _nameScreenProfile = "";

  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels > 60) {
        _nameScreenProfile = _nameProfile;
      } else {
        _nameScreenProfile = "";
      }
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        children: <Widget>[
          GradientBack(height: null),
          _buildAppBarProfile(),
          Container(
              color: Colors.transparent,
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              margin: EdgeInsets.only(top: 80, right: 10, left: 10, bottom: 10),
              child: ListView(
                  controller: _scrollController, children: _listItem(context)))
        ],
      ),
    );
  }

  Widget _buildAppBarProfile() {
    return TitleHeader(
      text: _nameScreenProfile,
      size: 20.0,
      onPressed: () {},
    );
  }

  List<Widget> _listItem(BuildContext context) {
    final _userBloc = Provider.userBloc(context);
    final List<Widget> listItem = [];
    listItem..add(_photoItem())..add(Divider());
    listItem..add(ItemProfile(
        text: "Editar perfil", iconData: Icons.edit, onPressed: () {}))..add(
        Divider(height: 2));
    listItem..add(ItemProfile(
        text: "Notificaciones",
        iconData: Icons.notifications,
        onPressed: () {}))..add(Divider(height: 2));
    listItem..add(ItemProfile(
        text: "Seguridad", iconData: Icons.security, onPressed: () {}))..add(
        Divider(height: 2));
    listItem..add(ItemProfile(
        text: "Ayuda", iconData: Icons.help_outline, onPressed: () {}))..add(
        Divider(height: 2));
    listItem..add(ItemProfile(
        text: "Cerrar sesión",
        iconData: Icons.exit_to_app,
        onPressed: () => _userBloc.cerrarSesion(context)

      /*() {
            Navigator.pushNamed(context, '/');
          }*/

    ))..add(Divider(height: 2));

    return listItem;
  }

  Widget _photoItem() {
    return InkWell(
      onTap: () {},
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(bottom: 40),
            child: CircleAvatar(
              backgroundImage: AssetImage(_pathLogo),
              radius: 35.0,
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 10, bottom: 40),
            child: Text(
              _nameProfile,
              style: TextStyle(
                  color: Colors.white,
                  fontFamily: "Lato",
                  fontSize: 20.0,
                  fontWeight: FontWeight.w900),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

}
