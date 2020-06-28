class DeviceModel {
  String uid;
  String name;
  String roomName;
  String iconOn;
  String iconOff;
  String pathImageOn;
  String pathImageOff;
  bool status;
  int value;
  int pos;

  DeviceModel({
    this.uid = "",
    this.name = "",
    this.roomName = "",
    this.iconOn = "",
    this.iconOff = "",
    this.pathImageOn = "",
    this.pathImageOff = "",
    this.status = false,
    this.value = 0,
  });

  factory DeviceModel.fromJson(Map<String, dynamic> json) =>
      DeviceModel(
        uid: json["uid"],
        name: json["name"],
        roomName: json["roomName"],
        iconOn: json["iconOn"],
        iconOff: json["iconOff"],
        pathImageOn: json["pathImageOn"],
        pathImageOff: json["pathImageOff"],
        status: json["status"],
        value: json["value"],
      );

  Map<String, dynamic> toJson() =>
      {
        "uid": uid,
        "name": name,
        "roomName": roomName,
        "iconOn": iconOn,
        "iconOff": iconOff,
        "pathImageOn": pathImageOn,
        "pathImageOff": pathImageOff,
        "status": status,
        "value": value,
      };

  DeviceModel.fromDocumentSnapshot(document) {
    uid = document["uid"];
    name = document["name"];
    roomName = document["roomName"];
    iconOn = document["iconOn"];
    iconOff = document["iconOff"];
    pathImageOn = document["pathImageOn"];
    pathImageOff = document["pathImageOff"];
    status = document["status"];
    value = document["value"];
  }
}
