class DeviceModel {
  DeviceModel({
    this.id,
    this.name,
    this.iconOn,
    this.iconOff,
    this.pathImageOn,
    this.pathImageOff,
  });

  String id;
  String name;
  String iconOn;
  String iconOff;
  String pathImageOn;
  String pathImageOff;

  factory DeviceModel.fromJson(Map<String, dynamic> json) => DeviceModel(
    id: json["id"],
    name: json["name"],
    iconOn: json["iconOn"],
    iconOff: json["iconOff"],
    pathImageOn: json["pathImageOn"],
    pathImageOff: json["pathImageOff"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "iconOn": iconOn,
    "iconOff": iconOff,
    "pathImageOn": pathImageOn,
    "pathImageOff": pathImageOff,
  };
}