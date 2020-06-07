import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutterappdomotica/Users/bloc/user_bloc.dart';
import 'package:flutterappdomotica/Users/ui/widget/verified_show_dialog.dart';

import 'package:flutterappdomotica/constants.dart';
import 'package:flutterappdomotica/providers/provider.dart';

class FirebaseAuthAPI {
  static FirebaseAuth _auth = FirebaseAuth.instance;

  Future<FirebaseUser> createUserWithEmailAndPassword(
      BuildContext context, String email, String password) async {
    FirebaseUser authResult = await _auth
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
      print("Registro ok");
      _verificarEmail(context);
//      return value.user;
    }).catchError((onError) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              backgroundColor: Colors.white,
              elevation: 10.0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0)),
              title: Center(child: Text("Error")),
              content: Text(usuarioExiste,
                  style: TextStyle(fontFamily: fontFamilyText, fontSize: 18.0)),
              actions: [
                FlatButton(
                  child: Text("Ok",
                      style: TextStyle(
                          fontFamily: fontFamilyText,
                          fontSize: 18.0,
                          color: Colors.blueAccent)),
                  onPressed: () =>
                      Navigator.pushReplacementNamed(context, loginPage),
                )
              ],
            );
          });
    });
    return authResult;
  }

  void _verificarEmail(BuildContext context) {
    UserBloc userBloc = Provider.userBloc(context);
    var user = userBloc.currentUser;

    user.then((userCurrent) {
      userCurrent.sendEmailVerification().then((value) {
        print("Enviando email");
        VerifiedShowDialog(context, "Verificar email", verificarEmail, loginPage);
      }).catchError((onError) {
        print(
            "Error: ha habido un error en el envío del email para verificar.");
      });
    });
  }


  signOut() async {
    await _auth.signOut().then((onValue) {
      print("Sesión cerrada");
    }).catchError((onError) {});
    print("Sesiones cerradas");
  }

  Future<FirebaseUser> signInWithEmailAndPassword(
      BuildContext context, String email, String password) async {
    AuthResult authResult = await _auth
        .signInWithEmailAndPassword(email: email, password: password)
        .then((user) {
      print("Iniciando sessión");
      return user;
    }).catchError((onError) {
      print("Error al iniciar sessión");
      return null;
    });

    return authResult.user;
  }
}
