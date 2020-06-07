import 'package:flutter/material.dart';

class UserModel {
  final String uid;
  final String name;
  final String apellidos;
  final String nickName;
  final String email;
  final String photoUrl;
//  final List<Room> myRooms;
//  final List<Room> myFavoriteRooms;

  UserModel(
      {Key key,
        @required this.uid,
        @required this.name,
        @required this.email,
        @required this.photoUrl,
//        this.myRooms,
//        this.myFavoriteRooms
        this.apellidos,
        this.nickName,
      });
}
