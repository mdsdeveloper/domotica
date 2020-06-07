import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterappdomotica/Users/api/auth_api.dart';
import 'package:flutterappdomotica/Users/model/user_model.dart';


class CloudFirestoreAPI {

  final String USERS = "users";

  final Firestore _db = Firestore.instance;
  static FirebaseAuth _auth = FirebaseAuth.instance;


  void updateUserData(UserModel userModel) async {
    DocumentReference ref = _db.collection(USERS).document(userModel.uid);
    return await ref.setData({
      'uid': userModel.uid,
      'name': userModel.name,
      'apellidos' : userModel.apellidos,
      'nickName' : userModel.nickName,
      'email': userModel.email,
      'photoUrl': userModel.photoUrl,
      'lastSignIn': DateTime.now()
    }, merge: true);
  }
}