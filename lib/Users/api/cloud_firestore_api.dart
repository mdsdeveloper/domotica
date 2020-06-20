import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterappdomotica/Rooms/model/room_model.dart';
import 'package:flutterappdomotica/Users/api/auth_api.dart';
import 'package:flutterappdomotica/Users/bloc/user_bloc.dart';
import 'package:flutterappdomotica/Users/model/user_model.dart';
import 'package:flutterappdomotica/providers/provider.dart';

class CloudFirestoreAPI {
  final String USERS = "users";
  final String ROOMS = "rooms";

  final Firestore _db = Firestore.instance;
  static FirebaseAuth _auth = FirebaseAuth.instance;

  void updateUserData(UserModel userModel) async {
    DocumentReference ref = _db.collection(USERS).document(userModel.uid);
    return await ref.setData({
      'uid': userModel.uid,
      'name': userModel.name,
      'apellidos': userModel.apellidos,
      'nickName': userModel.nickName,
      'email': userModel.email,
      'photoUrl': userModel.photoUrl,
      'lastSignIn': DateTime.now(),
    }, merge: true);
  }

  Stream<QuerySnapshot> getAllRooms() {
    var snapshots = _db.collection(CloudFirestoreAPI().ROOMS).snapshots();
    return snapshots;
  }

  UserBloc userBloc;

  Stream<QuerySnapshot> getAllMyRooms(FirebaseUser user) {
    var snapshots = _db.collection(CloudFirestoreAPI().USERS).document(user.uid).collection("myrooms").snapshots();
    return snapshots;
  }

  void addRoomToUser(String userId, String roomsId, RoomModel roomModel) {
    bool add = true;
    DocumentReference refUsers = _db.collection(USERS).document(userId);
    refUsers.updateData({
      'rooms': FieldValue.arrayUnion([_db.document("$ROOMS/$roomsId")])
    });

    refUsers.collection('myrooms').document(roomsId).setData(
        {'uid': roomModel.uid, 'name': roomModel.name, 'icon': roomModel.icon, 'uriImage': roomModel.uriImage},
        merge: true);
  }
}
