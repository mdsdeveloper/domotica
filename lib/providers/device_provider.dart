import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutterappdomotica/Rooms/model/device.dart';

class _DeviceProvider {
  List<dynamic> opcionesDevice = [];

  _DeviceProvider();

  Future<List<dynamic>> cargarData() async {
    final resp = await rootBundle.loadString('assets/data/devices.json');
    Map dataMap = json.decode(resp);
    opcionesDevice = dataMap['devices'];
    return opcionesDevice;
  }
}

final deviceProvider = new _DeviceProvider();