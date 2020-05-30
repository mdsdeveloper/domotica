import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterappdomotica/Widget/custom_raised_button.dart';
import 'package:flutterappdomotica/constants.dart';
import 'package:flutterappdomotica/providers/provider.dart';
import 'package:flutterappdomotica/widget/gradient_back.dart';
import 'package:flutterappdomotica/widget/title_header.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LoginScreen();
  }
}

class _LoginScreen extends State<LoginPage> {
  double _screenWidth;
  double _screenHeight;
  String _emailValidado;
  String _passwordValidado;
  final _emailController = TextEditingController();
  final _passController = TextEditingController();
  final _formKeyLogin = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    _screenWidth = MediaQuery.of(context).size.width;
    _screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Stack(
        children: <Widget>[
          GradientBack(height: null),
          _buildAppBarLogin(),
          _loginForm(context),
        ],
      ),
    );
  }

  Widget _buildAppBarLogin() {
    return TitleHeader(
      text: "Iniciar sesión",
      size: 20.0,
      onPressed: () {},
    );
  }

  Widget _loginForm(BuildContext context) {
    final loginBloc = Provider.loginBloc(context);

    return Container(
      margin: EdgeInsets.only(top: 90),
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SafeArea(
              child: Container(
                height: 80.0,
              ),
            ),
            Form(
              key: _formKeyLogin,
              child: Container(
                width: _screenWidth,
                margin: EdgeInsets.symmetric(horizontal: 20.0),
                padding: EdgeInsets.symmetric(vertical: 20.0),
//              padding: EdgeInsets.only(left: 20.0, right: 20.0),
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
                  children: <Widget>[
                    SizedBox(height: 30.0),
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                      child: _buildUserInput(loginBloc),
                    ),
                    Divider(),
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                      child: _buildPasswordInput(loginBloc),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                      child: _buildForgotPassword(),
                    ),
                    SizedBox(height: 30.0),
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                      child: _crearBoton(loginBloc),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(height: 100.0)
          ],
        ),
      ),
    );
  }

  Widget _crearBoton(LoginBloc loginBloc) {
    return CustomRaisedButton(
        text: loginText,
        marginTop: 10,
        onPressed: () {
          if (_formKeyLogin.currentState.validate()) {
            print("Validado");
            _cleanTextField();
//            Navigator.pushReplacementNamed(context, 'homeScreen');
          } else {
            print("No validado");
          }
        });
  }

  Widget _buildUserInput(LoginBloc loginBloc) {
    return StreamBuilder(
      stream: loginBloc.emailStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return TextFormField(
          controller: _emailController,
          keyboardType: TextInputType.emailAddress,
          textCapitalization: TextCapitalization.none,
          validator: validateEmail,
          decoration: InputDecoration(
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
              labelText: 'Email',
              suffixIcon: Icon(Icons.email)),
          onChanged: loginBloc.changeEmail,
        );
      },
    );
  }

  Widget _buildPasswordInput(LoginBloc loginBloc) {
    return StreamBuilder(
      stream: loginBloc.passwordStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return TextFormField(
          controller: _passController,
          obscureText: true,
          textCapitalization: TextCapitalization.none,
          validator: _validatePassword,
          decoration: InputDecoration(
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
              labelText: 'Contraseña',
              suffixIcon: Icon(Icons.lock)),
          onChanged: loginBloc.changePassword,
        );
      },
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

  String validateEmail(String value) {
    if (value.isEmpty) {
      _emailValidado = "Error debe rellenar el campo";
    } else {
      if (EmailValidator.validate(_emailController.text)) {
        _emailValidado = null;
      } else {
        _emailValidado = "Formato de email incorrecto";
      }
    }
    return _emailValidado;
  }

  String _validatePassword(String value) {
    if (value.isEmpty) {
      _passwordValidado = "Error debe rellenar el campo";
    } else if (value.length < 6){
      _passwordValidado = "Error, debe tener un tamaño mayor a 5 caracteres";
    }else{
      _passwordValidado = null;
    }
    return _passwordValidado;
  }

  void _cleanTextField() {
    _emailController?.clear();
    _passController?.clear();
  }

  @override
  void dispose() {
    super.dispose();
  }
}
