import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutterappdomotica/Rooms/model/room_model.dart';
import 'package:flutterappdomotica/Users/repository/cloud_firestore_repository.dart';
import 'package:rxdart/rxdart.dart';
import 'dart:async';

class RoomsBloc {
  final _cloudFirestoreRepository = CloudFirestoreRepository();

  final _roomsController = BehaviorSubject<String>();

  final _roomsModelController = BehaviorSubject<RoomModel>();

  final _iconController = BehaviorSubject<Icon>();

  Stream<QuerySnapshot> allRoomsListSream() => _cloudFirestoreRepository.getAllRooms();

  Stream<QuerySnapshot> allMyRoomsListStream(FirebaseUser user) => _cloudFirestoreRepository.getAllMyRooms(user);

  Stream<Icon> get iconStream => _iconController.stream;

  Function(Icon) get changeIcon => _iconController.sink.add;

  Stream<String> get roomsStream => _roomsController.stream;

  Stream<RoomModel> get roomsModelStream => _roomsModelController.stream;

  void addRoomToUserFirestore(userId, roomsId, RoomModel roomModel) {
    _cloudFirestoreRepository.addRoomToUserFirestore(userId, roomsId, roomModel);
    _roomsController.sink.add(roomsId);
  }

  dispose() {
    _iconController?.close();
    _roomsController?.close();
    _roomsModelController?.close();
  }

  void addRoomModel(RoomModel roomModel) {
    _roomsModelController.sink.add(roomModel);
  }
}
