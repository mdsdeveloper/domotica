
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutterappdomotica/Rooms/model/room_model.dart';
import 'package:flutterappdomotica/Users/api/cloud_firestore_api.dart';

import 'package:flutterappdomotica/Users/model/user_model.dart';

class CloudFirestoreRepository {
  final _cloudFirestoreAPI = CloudFirestoreAPI();

  void updateUserDataFirestore(UserModel user) => _cloudFirestoreAPI.updateUserData(user);

  void addRoomToUserFirestore(String userId, String roomsId, RoomModel roomModel) => _cloudFirestoreAPI.addRoomToUser(userId, roomsId, roomModel);

  getAllRooms() => _cloudFirestoreAPI.getAllRooms();

  Stream<QuerySnapshot> getAllMyRooms(FirebaseUser user) => _cloudFirestoreAPI.getAllMyRooms(user);
}
