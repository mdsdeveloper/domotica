import 'package:flutter/material.dart';
import 'package:flutterappdomotica/constants.dart';

class CardDeviceCreate extends StatefulWidget {
  final VoidCallback onPressed;
  final String deviceName;

  const CardDeviceCreate(
      {Key key, @required this.onPressed, @required this.deviceName})
      : super(key: key);

  @override
  _CardDeviceCreateState createState() => _CardDeviceCreateState();
}

class _CardDeviceCreateState extends State<CardDeviceCreate> {
  bool _value = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onPressed,
      child: Container(
//        width: 60,
//        height: 60,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          image: DecorationImage(
              image: AssetImage(pathBombillaEncendida1), fit: BoxFit.fill),
        ),
        child: Text(
          widget.deviceName != null ? widget.deviceName : "Dispositivo",
          style: TextStyle(
              fontFamily: "Lato", fontSize: 18, fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}
