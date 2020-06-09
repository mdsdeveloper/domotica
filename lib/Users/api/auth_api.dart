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
      _verificarEmail(context);
    }).catchError((onError) {
      LoginShowDialog(context, "Error", usuarioExiste, loginPage);
    });
    return authResult;
  }

  void _verificarEmail(BuildContext context) {
    UserBloc userBloc = Provider.userBloc(context);
    var user = userBloc.currentUser;

    user.then((userCurrent) {
      userCurrent.sendEmailVerification().then((value) {
        print("Enviando email");
        LoginShowDialog(context, "Verificar email", verificarEmail, initPage);
      }).catchError((onError) {
        print(
            "Error: ha habido un error en el envío del email para verificar.");
      });
    });
  }

  signOut(BuildContext context) async {
    await _auth.signOut().then((onValue) {
      print("Sesión cerrada");
      Navigator.pushReplacementNamed(context, initPage);
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
      var typeError = onError;
      print(typeError);
      // Handle Errors here.
      var errorMessage = onError.message;
      if (onError.code == 'ERROR_WRONG_PASSWORD') {
        print("Password erroneo" + errorMessage + onError.code);
        LoginShowDialog(context, "Error", loginError, loginPage);
      } else {
        LoginShowDialog(
            context, "Usuario no existe", registrarUsuario, registerPage);
      }
      print("Error al iniciar sessión");
      return onError;
    });

    return authResult.user;
  }

  void sendPasswordReset(BuildContext context, String email) {
    _auth
        .sendPasswordResetEmail(email: email)
        .then((value) => LoginShowDialog(
            context, "Verificar email", resetPassword, initPage))
        .catchError((onError){
      LoginShowDialog(context, "Error", resetPasswordError, loginPage);
    });
  }
}
