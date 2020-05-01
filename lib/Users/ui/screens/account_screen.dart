import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutterappdomotica/Widget/custom_raised_button.dart';
import 'package:flutterappdomotica/widget/gradient_back.dart';
import 'package:flutterappdomotica/widget/title_header.dart';

class AccountScreen extends StatefulWidget {
  @override
  _AccountScreenState createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  double screenWidth;
  double screenHeight;
  double formHeight;
  String emailValidado;
  String passwordValidado;
  String confirmarPasswordValidado;
  final _emailController = TextEditingController();
  final _passController = TextEditingController();
  final _confPassController = TextEditingController();

  // Nota: Esto es un GlobalKey<FormState>, no un GlobalKey<MyCustomFormState>!
  final _formKeyCreateAccount = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    formHeight = screenHeight / 2;
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
    return Form(
      key: _formKeyCreateAccount,
      child: Padding(
        padding: EdgeInsets.only(top: 60.0, bottom: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              width: screenWidth,
              height: formHeight,
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
                  Divider(),
                  _buildRepeatPasswordInput(),
//             Divider(),
                  CustomRaisedButton(
                      text: "Crear cuenta",
                      marginTop: 20,
                      onPressed: () {
                        if (_formKeyCreateAccount.currentState.validate()) {
                          _cleanTextField();
                        }
                      }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAppBarRegistration() {
    return TitleHeader(
      text: "Registrarse",
      size: 20.0,
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
      emailValidado = "Error debe rellenar el campo";
    } else {
      if(EmailValidator.validate(_emailController.text)){
        emailValidado = null;
      }else{
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

  String _validateConfirmationPassword(String value) {
    if (value.isEmpty) {
      confirmarPasswordValidado = "Error debe rellenar el campo";
    } else {
      if (_passController.text == _confPassController.text) {
        confirmarPasswordValidado = null;
      } else {
        confirmarPasswordValidado = "Error la contraseña no coincide";
      }
    }
    return confirmarPasswordValidado;
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
