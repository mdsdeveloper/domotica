import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterappdomotica/Users/bloc/user_bloc.dart';
import 'package:flutterappdomotica/Users/ui/widget/button_sign_in.dart';
import 'package:flutterappdomotica/Widget/curved_navigation_bar_init.dart';
import 'package:flutterappdomotica/Widget/gradient_back.dart';
import 'package:flutterappdomotica/constants.dart';
import 'package:flutterappdomotica/providers/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class InitPage extends StatefulWidget {
  @override
  _InitPageState createState() => _InitPageState();
}

class _InitPageState extends State<InitPage> {
  double _screenWidth;
  double _screenHeight;
  Orientation _orientation;
  UserBloc _userBloc;

  @override
  Widget build(BuildContext context) {
    _screenWidth = MediaQuery.of(context).size.width;
    _screenHeight = MediaQuery.of(context).size.height;
    _orientation = MediaQuery.of(context).orientation;
    _userBloc = Provider.userBloc(context);
    return _handleCurrentSession(context, _userBloc);
  }

  Widget _handleCurrentSession(BuildContext context, UserBloc userBloc) {
    var isVerified = false;
   return FutureBuilder(
      future: userBloc.currentUser,
      builder: (context, snapshot) {
        if (!snapshot.hasError) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
            case ConnectionState.none:
              return Center(child: CircularProgressIndicator());
            case ConnectionState.active:
            case ConnectionState.done:
            default:
              return StreamBuilder(
                stream: userBloc.authStatus,
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  // snapshot contiene los datos del usuario
                  if (!snapshot.hasData || snapshot.hasError || !isVerified) {
                    return signIn(context);
                  } else {
                    return CurvedNavigationBarInit();
                  }
                },
              );
          }
        } else {
          return null;
        }
      },
    );
/*    userBloc.currentUser.then((user) {
      if (mounted) {
        isVerified = user.isEmailVerified;
      }
    });*/
  }

  Widget signIn(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          GradientBack(height: null),
          SingleChildScrollView(
            child: Column(
//            mainAxisAlignment: MainAxisAlignment,
              children: <Widget>[
                _builTitleInitScreen(),
                _buildNameAppInitScreen(),
                _crearLogo(),
                ButtonSignIn(
                  text: iniciarSesionBtn,
                  onPressed: () => Navigator.pushReplacementNamed(context, loginPage),
                  width: _orientation == Orientation.landscape ? _screenWidth / 2 : _screenWidth / 1.2,
                  height: _orientation == Orientation.landscape ? _screenHeight / 10 : _screenHeight / 15,
                ),
                Container(
                  padding: EdgeInsets.only(top: _screenHeight / 20),
                  child: Text(
                    "---- O ----",
                    style:
                        TextStyle(fontWeight: FontWeight.w900, fontSize: 20.0, fontFamily: fontFamilyText, color: Colors.white),
                  ),
                ),
                ButtonSignIn(
                  text: registrarBtn,
                  onPressed: () => Navigator.pushReplacementNamed(context, registerPage),
                  width: _orientation == Orientation.landscape ? _screenWidth / 2 : _screenWidth / 1.2,
                  height: _orientation == Orientation.landscape ? _screenHeight / 10 : _screenHeight / 15,
                ),
                SizedBox(height: 15.0)
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _crearLogo() {
    return Container(
      margin: EdgeInsets.only(top: _screenHeight / 20),
      width: _screenWidth / 2,
      height: _screenHeight / 4,
      decoration: BoxDecoration(
          image: DecorationImage(fit: BoxFit.cover, image: AssetImage(pathLogo)),
          borderRadius: BorderRadius.all(Radius.circular(15.0)),
          boxShadow: <BoxShadow>[BoxShadow(color: Colors.lightBlueAccent, blurRadius: 15.0, offset: Offset(1.0, 1.0))]),
    );
  }

  Widget _builTitleInitScreen() {
    return Container(
      margin: EdgeInsets.only(top: _screenHeight / 10),
      alignment: Alignment.topCenter,
      child: Text(
        tituloInicioApp,
        textAlign: TextAlign.center,
        style: TextStyle(fontFamily: fontFamilyText, fontSize: 37.0, fontWeight: FontWeight.w900, color: Colors.blueGrey),
      ),
    );
  }

  Widget _buildNameAppInitScreen() {
    return Container(
      margin: EdgeInsets.only(top: _screenHeight / 15),
      alignment: Alignment.center,
      child: Text(
        nombreAppText,
        textAlign: TextAlign.center,
        style: TextStyle(fontFamily: fontFamilyText, fontSize: 37.0, fontWeight: FontWeight.w900, color: Colors.blueGrey),
      ),
    );
  }
}
