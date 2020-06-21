import 'dart:convert';

MyRoom roomFromJson(String str) => MyRoom.fromJson(json.decode(str));

String roomToJson(MyRoom data) => json.encode(data.toJson());

class MyRoom {
  String uid;
  String name;
  String nickName;
  String icon;
  String uriImage;

  MyRoom({
    this.uid,
    this.name = "",
    this.nickName = "",
    this.icon = "",
    this.uriImage = "",
  });

  factory MyRoom.fromJson(Map<String, dynamic> json) => MyRoom(
    uid         : json["uid"],
    name        : json["name"],
    nickName    : json["nickName"],
    icon        : json["icon"],
    uriImage    : json["uriImage"],
  );

  Map<String, dynamic> toJson() => {
    "uid"           : uid,
    "name"          : name,
    "nickName"      : nickName,
    "icon"          : icon,
    "uriImage"      : uriImage,
  };

  MyRoom.fromDocumentSnapshot(document) {
    uid         = document["uid"];
    name        = document["name"];
    nickName    = document["nickName"];
    icon        = document["icon"];
    uriImage    = document["uriImage"];
  }
}