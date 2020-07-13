import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutterappdomotica/Rooms/model/my_room.dart';
import 'package:flutterappdomotica/Rooms/model/room_model.dart';
import 'package:flutterappdomotica/Users/repository/cloud_firestore_repository.dart';
import 'package:rxdart/rxdart.dart';
import 'dart:async';

class RoomsBloc {
  final _cloudFirestoreRepository = CloudFirestoreRepository();

  final _roomsUIDController = BehaviorSubject<String>();

  final _myroomNameController = BehaviorSubject<String>();

  final _roomModelController = BehaviorSubject<RoomModel>();

  final _iconController = BehaviorSubject<Icon>();

  Stream<QuerySnapshot> allRoomsListSream() => _cloudFirestoreRepository.getAllRooms();

  Stream<QuerySnapshot> allMyRoomsListStream(FirebaseUser user) => _cloudFirestoreRepository.getAllMyRooms(user);

  Stream<Icon> get iconStream => _iconController.stream;

  Stream<String> get myRoomNameStream => _myroomNameController.stream;

  Function(Icon) get changeIcon => _iconController.sink.add;

  Function(String) get changeMyRoom => _myroomNameController.sink.add;

  Stream<String> get roomsStream => _roomsUIDController.stream;

  Stream<RoomModel> get roomsModelStream => _roomModelController.stream;

  void addRoomToUserFirestore(userId, roomsId, RoomModel roomModel) {
    _cloudFirestoreRepository.addRoomToUserFirestore(userId, roomsId, roomModel);
    _roomsUIDController.sink.add(roomsId);
  }

/*  void changeNameRoomOnFirestore(String roomUID, String value) {
    _cloudFirestoreRepository.changeNameRoomOnFirestore(roomUID, value);
  }*/

  void changeNameMyRoomOnServer(String roomUID, String value, String currentuser) {
    _cloudFirestoreRepository.changeNameMyRoomOnFirestore(roomUID, value, currentuser);
  }

  dispose() {
    _iconController?.close();
    _roomsUIDController?.close();
    _roomModelController?.close();
    _myroomNameController?.close();
  }

  void addRoomModel(RoomModel roomModel) {
    _roomModelController.sink.add(roomModel);
  }
}
