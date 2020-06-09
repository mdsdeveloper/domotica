import 'package:firebase_auth/firebase_auth.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterappdomotica/Users/bloc/user_bloc.dart';
import 'package:flutterappdomotica/Users/service/user_service.dart';
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
  String _emailValidado;
  String _passwordValidado;
  String _confirmarPasswordValidado;
  bool _isVisiblePass = false;
  bool _isVisibleRepeatPass = false;
  Orientation _orientation;
  final _emailController = TextEditingController();
  final _passController = TextEditingController();
  final _confPassController = TextEditingController();
  final _formKeyCreateAccount = GlobalKey<FormState>();
  bool _isAccepted = false;
  bool _needAccepted = false;
  double _widthCeck = 20.0;
  double _heigthCheck = 20.0;
  Color _colorCheck = Colors.transparent;
  Color _colorDecoration = Colors.transparent;

  @override
  Widget build(BuildContext context) {
    _screenWidth = MediaQuery.of(context).size.width;
    _screenHeight = MediaQuery.of(context).size.height;
    _orientation = MediaQuery.of(context).orientation;
    return Scaffold(
      body: Stack(
        children: <Widget>[
          GradientBack(height: null),
          _buildAppBarRegistration(),
          _formRegistration(context)

//          MyCustomForm()
        ],
      ),
    );
  }

  Widget _formRegistration(BuildContext context) {
    final loginBloc = Provider.loginBloc(context);
    final userBloc = Provider.userBloc(context);

    return Container(
      margin: EdgeInsets.only(top: 90.0),
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SafeArea(
              child: Container(
                height: _orientation == Orientation.landscape ? 0.0 : 80.0,
              ),
            ),
            Form(
              key: _formKeyCreateAccount,
              child: Container(
                width: _orientation == Orientation.landscape
                    ? _screenWidth / 2
                    : _screenWidth,
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
                    SizedBox(height: 10.0),
                    _acceptConditions(context),
                    SizedBox(height: 30.0),
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                      child: _crearBoton(context, loginBloc, userBloc),
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

  Container _acceptConditions(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          AnimatedContainer(
            decoration: BoxDecoration(
              border: Border.all(color: _colorDecoration, width: 2.0),
              color: _colorCheck,
            ),
            duration: Duration(seconds: 1),
            curve: Curves.fastOutSlowIn,
            width: _widthCeck,
            height: _heigthCheck,
            onEnd: () => _restoreForm(),
            child: Checkbox(
              value: _isAccepted,
              onChanged: _aceptaTerminos,
            ),
          ),
          SizedBox(width: 10.0),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              InkWell(
                  onTap: () => Navigator.pushNamed(context, termsPage),
                  child: Text(
                    "Acepto los términos y condiciones",
                    style: TextStyle(
                        fontFamily: fontFamilyText, color: Colors.blueAccent),
                  )),
              Divider(
                height: 5.0,
              ),
              InkWell(
                  onTap: () => Navigator.pushNamed(context, policyPage),
                  child: Text("He leído la política de privacidad.",
                      style: TextStyle(
                          fontFamily: fontFamilyText,
                          color: Colors.blueAccent))),
            ],
          ),
        ],
      ),
    );
  }

  void _aceptaTerminos(value) {
    setState(() {
      _isAccepted = !_isAccepted;
    });
  }

  Widget _crearBoton(
      BuildContext context, LoginBloc loginBloc, UserBloc userBloc) {
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
  }

  _registerUser(
      BuildContext context, LoginBloc loginBloc, UserBloc userBloc) async {
    if (_isAccepted) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return Container(
              height: _screenHeight / 6,
              width: _screenWidth / 6,
              child: Center(child: CircularProgressIndicator()),
            );
          });
      _cleanTextField();
      await userBloc.createUser(context, loginBloc.email, loginBloc.password);
    } else {
      _needAccepted = !_isAccepted;
      _changeForm();
    }
  }

  void _restoreForm() {
    setState(() {
      _widthCeck = 15.0;
      _heigthCheck = 15.0;
      _colorCheck = Colors.white;
      _colorDecoration = Colors.transparent;
    });
  }

  void _changeForm() {
    setState(() {
      _widthCeck = 40.0;
      _heigthCheck = 40.0;
      _colorDecoration = Colors.black;
      _colorCheck = Colors.redAccent;
    });
  }

  Widget _buildAppBarRegistration() {
    return TitleHeader(
      text: "Registrarse",
      size: 20.0,
      onPressed: () => Navigator.pushReplacementNamed(context, initPage),
    );
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
                onPressed: () => _showPassword(1),
              )),
          onChanged: loginBloc.changePassword,
        );
      },
    );
  }

  void _showPassword(int typePass) {
    if (typePass == 1) {
      _isVisiblePass = !_isVisiblePass;
    } else {
      _isVisibleRepeatPass = !_isVisibleRepeatPass;
    }
    setState(() {});
  }

  Widget _buildRepeatPasswordInput() {
    return TextFormField(
      controller: _confPassController,
      obscureText: !_isVisibleRepeatPass,
      textCapitalization: TextCapitalization.sentences,
      validator: _validateConfirmationPassword,
      enableInteractiveSelection: true,
      decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
          labelText: 'Confirmar contraseña',
          prefixIcon: Icon(Icons.lock),
          suffixIcon: IconButton(
            icon: Icon(
                _isVisibleRepeatPass ? Icons.visibility : Icons.visibility_off),
            onPressed: () => _showPassword(2),
          )),
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
    } else if (value.length < 6) {
      _passwordValidado = "Error, debe tener un tamaño mayor a 5 caracteres";
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
    _isAccepted = false;
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passController.dispose();
    _confPassController.dispose();
    super.dispose();
  }
}
