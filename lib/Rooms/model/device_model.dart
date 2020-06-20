class DeviceModel {
  DeviceModel({
    this.id,
    this.name,
    this.iconDeviceOn,
    this.iconDeviceOff,
    this.pathImageOn,
    this.pathImageOff,
    this.onPressed,
    this.longPressCallback,
    this.delete,
  });

  String id;
  String name;
  String iconDeviceOn;
  String iconDeviceOff;
  String pathImageOn;
  String pathImageOff;
  String onPressed;
  String longPressCallback;
  bool delete;

  factory DeviceModel.fromJson(Map<String, dynamic> json) => DeviceModel(
    id: json["id"],
    name: json["name"],
    iconDeviceOn: json["iconDeviceOn"],
    iconDeviceOff: json["iconDeviceOff"],
    pathImageOn: json["pathImageOn"],
    pathImageOff: json["pathImageOff"],
    onPressed: json["onPressed"],
    longPressCallback: json["longPressCallback"],
    delete: json["delete"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "iconDeviceOn": iconDeviceOn,
    "iconDeviceOff": iconDeviceOff,
    "pathImageOn": pathImageOn,
    "pathImageOff": pathImageOff,
    "onPressed": onPressed,
    "longPressCallback": longPressCallback,
    "delete": delete,
  };
}