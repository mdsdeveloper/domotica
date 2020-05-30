import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutterappdomotica/Widget/custom_raised_button.dart';
import 'package:flutterappdomotica/constants.dart';
import 'package:flutterappdomotica/providers/provider.dart';
import 'package:flutterappdomotica/widget/gradient_back.dart';
import 'package:flutterappdomotica/widget/title_header.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  double _screenWidth;
  double _screenHeight;
  double _formHeight;
  String _emailValidado;
  String _passwordValidado;
  String _confirmarPasswordValidado;
  final _emailController = TextEditingController();
  final _passController = TextEditingController();
  final _confPassController = TextEditingController();
  final _formKeyCreateAccount = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    _screenWidth = MediaQuery.of(context).size.width;
    _screenHeight = MediaQuery.of(context).size.height;
    _formHeight = _screenHeight / 2;
    return Scaffold(
      body: Stack(
        children: <Widget>[
          GradientBack(height: null),
          _buildAppBarRegistration(),
          _formRegistration()

//          MyCustomForm()
        ],
      ),
    );
  }

  Widget _formRegistration() {
    final loginBloc = Provider.loginBloc(context);
    return Container(
      margin: EdgeInsets.only(top: 90.0),
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SafeArea(
              child: Container(
                height: 80.0,
              ),
            ),
            Form(
              key: _formKeyCreateAccount,
              child: Container(
                width: _screenWidth,
                margin: EdgeInsets.symmetric(horizontal: 20.0),
                padding: EdgeInsets.symmetric(vertical: 20.0),
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
                    Divider(),
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                      child: _buildRepeatPasswordInput(),
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
        text: registerAccountText,
        marginTop: 10,
        onPressed: () {
          if (_formKeyCreateAccount.currentState.validate()) {
            _cleanTextField();
          } else {
            print("No validado");
          }
        });
  }

  Widget _buildAppBarRegistration() {
    return TitleHeader(
      text: "Registrarse",
      size: 20.0,
      onPressed: () {},
    );
  }

  Widget _buildUserInput(LoginBloc loginBloc) {
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

  Widget _buildPasswordInput(LoginBloc loginBloc) {
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

  Widget _buildRepeatPasswordInput() {
    return TextFormField(
      controller: _confPassController,
      obscureText: true,
      textCapitalization: TextCapitalization.sentences,
      validator: _validateConfirmationPassword,
      enableInteractiveSelection: true,
      decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
          labelText: 'Confirmar contraseña',
          suffixIcon: Icon(Icons.lock)),
      onChanged: (valor) {},
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
    } else {
      _passwordValidado = null;
    }
    return _passwordValidado;
  }

  String _validateConfirmationPassword(String value) {
    if (value.isEmpty) {
      _confirmarPasswordValidado = "Error debe rellenar el campo";
    } else {
      if (_passController.text == _confPassController.text) {
        _confirmarPasswordValidado = null;
      } else {
        _confirmarPasswordValidado = "Error la contraseña no coincide";
      }
    }
    return _confirmarPasswordValidado;
  }

  void _cleanTextField() {
    _emailController.clear();
    _passController.clear();
    _confPassController.clear();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passController.dispose();
    _confPassController.dispose();
    super.dispose();
  }
}
