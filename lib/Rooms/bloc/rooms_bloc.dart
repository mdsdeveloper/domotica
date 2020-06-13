

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutterappdomotica/Users/api/cloud_firestore_api.dart';
import 'package:flutterappdomotica/Users/repository/cloud_firestore_repository.dart';

class RoomsBloc{
  final _cloudFirestoreRepository = CloudFirestoreRepository();

  Stream<QuerySnapshot> allRoomsListSream() => _cloudFirestoreRepository.getAllRooms();


}