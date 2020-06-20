// To parse this JSON data, do
//
//     final room = roomFromJson(jsonString);

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutterappdomotica/Rooms/model/my_room.dart';

RoomModel roomFromJson(String str) => RoomModel.fromJson(json.decode(str));

String roomToJson(RoomModel data) => json.encode(data.toJson());

class RoomModel {
  String uid;
  String name;
  String nickName;
  String icon;
  String uriImage;
  List<Myroom> myrooms;
//  List<Device> device;
  RoomModel({
    this.uid,
    this.name,
    this.icon,
    this.uriImage,
    this.nickName,
//    this.myrooms,
//    this.device,
  });

  factory RoomModel.fromJson(Map<String, dynamic> json) => RoomModel(
    uid         : json["uid"],
    name        : json["name"],
    nickName    : json["nickName"],
    icon        : json["icon"],
    uriImage    : json["uriImage"],
//    myrooms: List<Myroom>.from(json["myrooms"].map((x) => Myroom.fromJson(x))),
//    device: List<Device>.from(json["Device"].map((x) => Device.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "uid"         : uid,
    "name"        : name,
    "nickName"    : nickName,
    "icon"        : icon,
    "uriImage"    : uriImage,
//    "myrooms": List<dynamic>.from(myrooms.map((x) => x.toJson())),
//    "Device": List<dynamic>.from(device.map((x) => x.toJson())),
  };

   RoomModel.fromDocumentSnapshot(document) {
    uid         = document["uid"];
    name        = document["name"];
    nickName    = document["nickName"];
    icon        = document["icon"];
    uriImage    = document["uriImage"];
  }
}
