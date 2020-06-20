class Myroom {
  Myroom({
    this.uid,
    this.name,
    this.icon,
    this.urlImage,
  });

  String uid;
  String name;
  String icon;
  String urlImage;

  factory Myroom.fromJson(Map<String, dynamic> json) => Myroom(
    uid       : json["uid"],
    name      : json["name"],
    icon      : json["icon"],
    urlImage  : json["urlImage"],
  );

  Map<String, dynamic> toJson() => {
    "uid"       : uid,
    "name"      : name,
    "icon"      : icon,
    "urlImage"  : urlImage,
  };
}