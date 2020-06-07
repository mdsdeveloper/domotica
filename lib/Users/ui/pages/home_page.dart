import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterappdomotica/Widget/custom_raised_button.dart';
import 'package:flutterappdomotica/Widget/gradient_back.dart';
import 'package:flutterappdomotica/Widget/title_header.dart';
import 'package:flutterappdomotica/constants.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
//      appBar: AppBar(),
      body: Stack(
        children: <Widget>[
          GradientBack(height: null),
          _buildAppBarHome(),
          _createPage()

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

  Widget _createPage() {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.only(top: 200),
      height: 300.0,
      color: Colors.white,
      child: Text("Home page"),
    );
  }

 /* Widget logOut(BuildContext context, LoginBloc loginBloc, UserBloc userBloc) {

    return CustomRaisedButton(
        text: registerAccountText,
        marginTop: 10,
        onPressed: () {
          if (_formKeyCreateAccount.currentState.validate()) {
            _registerUser(context, loginBloc, userBloc);
          } else {
            print("No validado");
          }
        });
  }*/




}
