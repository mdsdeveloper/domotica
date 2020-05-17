import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutterappdomotica/Rooms/model/device.dart';
import 'package:flutterappdomotica/constants.dart';

class RoomDeviceWidget extends StatefulWidget {
  static _RoomDeviceWidgetState of(BuildContext context) =>
      context.findAncestorRenderObjectOfType();
  final Device device;
  var _isPressedDelete;

  bool get isPressedDelete => _isPressedDelete;

  set isPressedDelete(dynamic value) {
    _isPressedDelete = value;
  }

  RoomDeviceWidget({@required this.device});

  @override
  _RoomDeviceWidgetState createState() => _RoomDeviceWidgetState();
}

class _RoomDeviceWidgetState extends State<RoomDeviceWidget> {
  bool isOn = false;
  bool _checkSelected = false;

  @override
  void initState() {
    super.initState();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 10, top: 10.0),
      margin: EdgeInsets.only(bottom: 5.0, left: 5.0, right: 5.0),
      color: Colors.indigo,
      child: Row(children: <Widget>[
        widget._isPressedDelete ? _addCheck() : SizedBox(),
        Expanded(
          child: SwitchListTile(
            value: isOn,
            title: Center(
                child: Text(
              widget.device.name,
              style: TextStyle(
                  fontFamily: "Lato", fontSize: 20.0, color: Colors.white),
            )),
            secondary: Container(
              child: CircleAvatar(
                backgroundImage: AssetImage(isOn
                    ? widget.device.pathImageOn
                    : widget.device.pathImageOff),
                radius: 30.0,
              ),
            ),
            onChanged: onSwichtToChange,
            dense: true,
            inactiveTrackColor: Colors.grey,
            inactiveThumbColor: Colors.white,
            activeTrackColor: Colors.green,
            activeColor: Colors.white,
            selected: isOn,
            activeThumbImage: AssetImage(pathBombillaEncendida1),
            inactiveThumbImage: AssetImage(pathBombillaApagada),
          ),
        ),
      ]),
    );
  }

  void onSwichtToChange(value) {
    setState(() {
      isOn = value;
    });
  }

  Widget _addCheck() {
    return Container(
        child: IconButton(
            icon: Icon(getCheckIcon(_checkSelected)),
            onPressed: () {
              setState(() {
                _checkSelected = !_checkSelected;
                widget.device.delete = _checkSelected;
                print(_checkSelected);
              });
            }));
  }

  IconData getCheckIcon(bool checkSelected) {
    return checkSelected ? Icons.check_box : Icons.check_box_outline_blank;
  }
}
