import 'package:flutter/material.dart';

class Device {
  int _id;
  String _name;
  Icon _iconDeviceOff;
  Icon _iconDeviceOn;
  String _pathImageOn;
  String _pathImageOff;
  VoidCallback _onPressed;
  GestureLongPressCallback _longPressCallback;
  bool _delete;

  bool get delete => _delete;

  set delete(bool value) {
    _delete = value;
  }

  GestureLongPressCallback get longPressCallback => _longPressCallback;

  set longPressCallback(GestureLongPressCallback value) {
    _longPressCallback = value;
  }

  bool _isOn;

  int get id => _id;

  set id(int value) {
    _id = value;
  }

  VoidCallback get onPressed => _onPressed;

  set onPressed(VoidCallback value) {
    _onPressed = value;
  }

  Icon get iconDeviceOff => _iconDeviceOff;

  set iconDeviceOff(Icon value) {
    _iconDeviceOff = value;
  }

  String get name => _name;

  set name(String value) {
    _name = value;
  }

  bool get isOn => _isOn;

  set isOn(bool value) {
    _isOn = value;
  }

  Icon get iconDeviceOn => _iconDeviceOn;

  set iconDeviceOn(Icon value) {
    _iconDeviceOn = value;
  }

  String get pathImageOn => _pathImageOn;

  set pathImageOn(String value) {
    _pathImageOn = value;
  }

  String get pathImageOff => _pathImageOff;

  set pathImageOff(String value) {
    _pathImageOff = value;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Device &&
          runtimeType == other.runtimeType &&
          _name == other._name;

  @override
  int get hashCode => _name.hashCode;
}
