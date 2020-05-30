import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterappdomotica/Widget/custom_raised_button.dart';
import 'package:flutterappdomotica/widget/gradient_back.dart';
import 'package:flutterappdomotica/widget/title_header.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LoginScreen();
  }
}

class _LoginScreen extends State<LoginScreen> {
  double screenWidth;
  double screenHeight;
  String emailValidado;
  String passwordValidado;
  final _emailController = TextEditingController();
  final _passController = TextEditingController();
  final _formKeyLogin = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
//      appBar: AppBar(
//        title: Text('Login'),
//        backgroundColor: Color(0xFF4268D3),
//        elevation: 0.0,
//      ),
      body: Stack(
//        alignment: Alignment.center,
        children: <Widget>[
          GradientBack(height: null),
          _buildAppBarLogin(),
          _formLogin()
        ],
      ),
    );
  }

  Widget _formLogin() {
    return Form(
      key: _formKeyLogin,
      child: Container(
        margin: EdgeInsets.only(top: 60.0, bottom: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              width: screenWidth,
              height: screenHeight / 2,
              margin: EdgeInsets.symmetric(horizontal: 20.0),
              padding: EdgeInsets.only(left: 20.0, right: 20.0),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8.0),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black12,
                        offset: Offset(0.0, 15.0),
                        blurRadius: 15.0),
                    BoxShadow(
                        color: Colors.black12,
                        offset: Offset(0.0, -10.0),
                        blurRadius: 10.0)
                  ]),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  _buildUserInput(),
                  Divider(),
                  _buildPasswordInput(),
                  _buildForgotPassword(),
                  CustomRaisedButton(
                      text: "LOGIN",
                      marginTop: 20,
                      onPressed: () {
                        if (_formKeyLogin.currentState.validate()) {
                          print("Validado");
                          _cleanTextField();
                          Navigator.pushReplacementNamed(context, 'homeScreen');
                        } else {
                          print("No validado");
                        }
                      }),
//                _buildSubmitButton(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUserInput() {
    return TextFormField(
      controller: _emailController,
      keyboardType: TextInputType.emailAddress,
      textCapitalization: TextCapitalization.none,
      validator: validateEmail,
      decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
          labelText: 'Email',
          suffixIcon: Icon(Icons.email)),
      onChanged: (valor) {},
    );
  }

  Widget _buildPasswordInput() {
    return TextFormField(
      controller: _passController,
      obscureText: true,
      textCapitalization: TextCapitalization.none,
      validator: _validatePassword,
      decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
          labelText: 'Contraseña',
          suffixIcon: Icon(Icons.lock)),
      onChanged: (valor) {},
    );
  }

  Widget _buildForgotPassword() {
    return Container(
      alignment: Alignment.centerRight,
      child: FlatButton(
        padding: EdgeInsets.only(right: 0.0),
        child: Text(
          "Recuperar contraseña",
          style: TextStyle(color: Colors.blue),
        ),
        onPressed: () {
          Navigator.pushNamed(context, 'forgotPasswordScreen');
        },
      ),
    );
  }

  Widget _buildAppBarLogin() {
    return TitleHeader(
      text: "Iniciar sesión",
      size: 20.0,
    );
  }

  String validateEmail(String value) {
    if (value.isEmpty) {
      emailValidado = "Error debe rellenar el campo";
    } else {
      if (EmailValidator.validate(_emailController.text)) {
        emailValidado = null;
      } else {
        emailValidado = "Formato de email incorrecto";
      }
    }
    return emailValidado;
  }

  String _validatePassword(String value) {
    if (value.isEmpty) {
      passwordValidado = "Error debe rellenar el campo";
    } else {
      passwordValidado = null;
    }
    return passwordValidado;
  }

  void _cleanTextField() {
    _emailController.clear();
    _passController.clear();
  }

  @override
  void dispose() {
    super.dispose();
  }
}
