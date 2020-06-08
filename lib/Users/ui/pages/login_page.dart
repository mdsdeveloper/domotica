import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterappdomotica/Users/bloc/user_bloc.dart';
import 'package:flutterappdomotica/Users/ui/widget/verified_show_dialog.dart';
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
  bool _isVisiblePass = false;
  final _emailController = TextEditingController();
  final _passController = TextEditingController();
  final _formKeyLogin = GlobalKey<FormState>();
  Orientation _orientation;

  @override
  Widget build(BuildContext context) {
    _screenWidth = MediaQuery.of(context).size.width;
    _screenHeight = MediaQuery.of(context).size.height;
    _orientation = MediaQuery.of(context).orientation;

    return Scaffold(
      body: Stack(
        children: <Widget>[
          GradientBack(height: null),
          _buildAppBarLogin(context),
          _loginForm(context),
        ],
      ),
    );
  }

  Widget _buildAppBarLogin(BuildContext context) {
    return TitleHeader(
      text: "Iniciar sesión",
      size: 20.0,
      onPressed: () => Navigator.pushReplacementNamed(context, initPage),
    );
  }

  Widget _loginForm(BuildContext context) {
    final _loginBloc = Provider.loginBloc(context);
    final _userBloc = Provider.userBloc(context);

    return Container(
      margin: EdgeInsets.only(top: 90),
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SafeArea(
              child: Container(
                height: _orientation == Orientation.landscape ? 0.0 : 80.0,
              ),
            ),
            Form(
              key: _formKeyLogin,
              child: Container(
                width: _orientation == Orientation.landscape
                    ? _screenWidth / 2
                    : _screenWidth,
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
                      child: _buildUserInput(_loginBloc),
                    ),
                    Divider(),
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                      child: _buildPasswordInput(_loginBloc),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                      child: _buildForgotPassword(),
                    ),
                    SizedBox(height: 30.0),
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                      child: _submitButton(context, _loginBloc, _userBloc),
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

  Widget _submitButton(
      BuildContext context, LoginBloc loginBloc, UserBloc userBloc) {
    final currentUser = userBloc.currentUser;

    return CustomRaisedButton(
        text: loginText,
        marginTop: 10,
        onPressed: () {
          if (_formKeyLogin.currentState.validate()) {
            userBloc
                .signInWithEmailAndPassword(
                    context, loginBloc.email, loginBloc.password)
                .then((logedUser) {
              if (logedUser.isEmailVerified) {
                print("Validado y verificado");
                _cleanTextField();
                Navigator.pushReplacementNamed(context, homePage);
              } else {
                VerifiedShowDialog(
                    context, "Verificar email", verificarEmail, loginPage);
              }
            }).catchError((onError) {
              VerifiedShowDialog(
                  context, "Usuario no existe", registrarUsuario, registerPage);
            });
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
              prefixIcon: Icon(Icons.email)),
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
          obscureText: !_isVisiblePass,
          textCapitalization: TextCapitalization.none,
          validator: _validatePassword,
          decoration: InputDecoration(
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
              labelText: 'Contraseña',
              prefixIcon: Icon(Icons.lock),
              suffixIcon: IconButton(
                icon: Icon(
                    _isVisiblePass ? Icons.visibility : Icons.visibility_off),
                onPressed: _showPassword,
              )),
          onChanged: loginBloc.changePassword,
        );
      },
    );
  }

  void _showPassword() {
    setState(() {
      _isVisiblePass = !_isVisiblePass;
    });
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
    } else if (value.length < 6) {
      _passwordValidado = "Error, debe tener un tamaño mayor a 5 caracteres";
    } else {
      _passwordValidado = null;
    }
    return _passwordValidado;
  }

  void _cleanTextField() {
    _emailController.clear();
    _passController.clear();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passController.dispose();
    super.dispose();
  }
}
