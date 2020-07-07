import 'dart:convert';

MyRoom roomFromJson(String str) => MyRoom.fromJson(json.decode(str));

String roomToJson(MyRoom data) => json.encode(data.toJson());

class MyRoom {
  String uid;
  String name;
  String icon;
  String uriImage;

  MyRoom({
    this.uid,
    this.name = "",
    this.icon = "",
    this.uriImage = "",
  });

  factory MyRoom.fromJson(Map<String, dynamic> json) => MyRoom(
    uid         : json["uid"],
    name        : json["name"],
    icon        : json["icon"],
    uriImage    : json["uriImage"],
  );

  Map<String, dynamic> toJson() => {
    "uid"           : uid,
    "name"          : name,
    "icon"          : icon,
    "uriImage"      : uriImage,
  };

  MyRoom.fromDocumentSnapshot(document) {
    uid         = document["uid"];
    name        = document["name"];
    icon        = document["icon"];
    uriImage    = document["uriImage"];
  }
}