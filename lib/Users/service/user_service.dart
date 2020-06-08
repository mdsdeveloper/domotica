import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutterappdomotica/Users/api/auth_api.dart';

class UserService {
  FirebaseAuthAPI _firebaseAuthAPI = FirebaseAuthAPI();

  Future<FirebaseUser> createUser(
      BuildContext context, String email, String password) async {
    FirebaseUser firebaseUser = await _firebaseAuthAPI
        .createUserWithEmailAndPassword(context, email, password);

    return firebaseUser;
  }

  Future<FirebaseUser> signInWithEmailAndPassword(
      BuildContext context, String email, String password) async {
    FirebaseUser firebaseUser = await _firebaseAuthAPI
        .signInWithEmailAndPassword(context, email, password);
    return firebaseUser;
  }

  void signOut(BuildContext context) {
    _firebaseAuthAPI.signOut(context);
  }
}
