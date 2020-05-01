import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutterappdomotica/Widget/custom_raised_button.dart';

import 'package:flutterappdomotica/widget/gradient_back.dart';
import 'package:flutterappdomotica/widget/title_header.dart';

class ForgotPassword extends StatefulWidget {

  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  double screenWidth;
  double screenHeight;
  String emailValidado;
  final _emailController = TextEditingController();
  final _formKeyforgotPass = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Stack(
        children: <Widget>[
          GradientBack(height: null),
          TitleHeader(
            text: "Recuperar contraseña",
            size: 20,
          ),
          _formForgotPass()
        ],
      ),
    );
  }


  Widget _formForgotPass() {
    return Form(
      key: _formKeyforgotPass,
      child: Container(
        margin: EdgeInsets.only(top: 60.0, bottom: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              width: screenWidth,
              height: screenHeight / 3,
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
                  CustomRaisedButton(
                      text: "Restablecer contraseña",
                      marginTop: 20,
                      onPressed: () {
                        if (_formKeyforgotPass.currentState.validate()) {
                          print("Validado");
                          _cleanTextField();
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

  void _cleanTextField() {
    _emailController.clear();
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }
}
