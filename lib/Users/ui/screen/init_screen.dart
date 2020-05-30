import 'package:flutter/material.dart';
import 'package:flutterappdomotica/Users/ui/widget/button_sign_in.dart';
import 'package:flutterappdomotica/Widget/gradient_back.dart';
import 'package:flutterappdomotica/constants.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class InitScreen extends StatefulWidget {
  @override
  _InitScreenState createState() => _InitScreenState();
}

class _InitScreenState extends State<InitScreen> {
//  UserBloc userBloc;
  double _screenWidth;
  double _screenHeight;



  @override
  Widget build(BuildContext context) {
    _screenWidth = MediaQuery.of(context).size.width;
    _screenHeight = MediaQuery.of(context).size.height;
//    userBloc = BlocProvider.of<UserBloc>(context);
    return _handleCurrentSession();
  }

  Widget _handleCurrentSession() {
    return signIn();
    /*StreamBuilder(
      stream: userBloc.authStatus,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (!snapshot.hasData || snapshot.hasError) {
          return signIn();
        } else {
          return signIn();
        }
      },
    );*/
  }

  Widget signIn() {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          GradientBack(height: null),
          Column(
//            mainAxisAlignment: MainAxisAlignment,
            children: <Widget>[
              _builTitleInitScreen(),
              _buildNameAppInitScreen(),
              _crearLogo(),
              ButtonSignIn(
                text: iniciarSesionBtn,
                onPressed: () {
//                  Navigator.push(context, MaterialPageRoute(
//                    builder: (context) => LoginScreen()
//                  ));
//                  Navigator.pushReplacementNamed(context, pantallaLogin);
                  Navigator.pushNamed(context, 'homeScreen');
                },
                width: 300.0,
                height: 50.0,
              ),
              Container(
                padding: EdgeInsets.only(top: 30.0),
                child: Text(
                  "---- O ----",
                  style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 20.0,
                      fontFamily: fontFamilyText,
                      color: Colors.white
                  ),
                ),
              ),
              ButtonSignIn(
                text: registrarBtn,
                onPressed: () => Navigator.pushNamed(context, pantallaRegistrar),
                width: 300.0,
                height: 50.0,
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _crearLogo() {
    return Container(
      margin: EdgeInsets.only(top: 50.0),
      width: _screenWidth / 2,
      height: _screenHeight / 4,
      decoration: BoxDecoration(
          image:
          DecorationImage(fit: BoxFit.cover, image: AssetImage(pathLogo)),
          borderRadius: BorderRadius.all(Radius.circular(15.0)),
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: Colors.lightBlueAccent,
                blurRadius: 15.0,
                offset: Offset(1.0, 1.0))
          ]),
    );
  }

  Widget _builTitleInitScreen() {
    return Container(
      margin: EdgeInsets.only(top: 50.0),
      alignment: Alignment.topCenter,
      child: Text(
        tituloInicioApp,
        textAlign: TextAlign.center,
        style: TextStyle(
            fontFamily: fontFamilyText,
            fontSize: 37.0,
            fontWeight: FontWeight.w900,
            color: Colors.blueGrey),
      ),
    );
  }

  Widget _buildNameAppInitScreen() {
    return Container(
      margin: EdgeInsets.only(top: 50.0),
      alignment: Alignment.center,
      child: Text(
        nombreAppText,
        textAlign: TextAlign.center,
        style: TextStyle(
            fontFamily: fontFamilyText,
            fontSize: 37.0,
            fontWeight: FontWeight.w900,
            color: Colors.blueGrey),
      ),
    );
  }
}
