import 'dart:collection';
import 'dart:io';

import 'package:flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutterappdomotica/Rooms/model/device.dart';
import 'package:flutterappdomotica/Rooms/model/room.dart';
import 'package:flutterappdomotica/Rooms/ui/screens/room_details_screen.dart';
import 'package:flutterappdomotica/Rooms/ui/widget/card_device_create.dart';
import 'package:flutterappdomotica/Rooms/ui/widget/room_device_widget.dart';
import 'package:flutterappdomotica/Users/ui/widget/item_profile.dart';
import 'package:flutterappdomotica/Widget/gradient_back.dart';
import 'package:flutterappdomotica/Widget/title_header.dart';
import 'package:flutterappdomotica/constants.dart';
import 'package:flutterappdomotica/enumDevice.dart';
import 'package:flutterappdomotica/providers/device_provider.dart';
import 'package:flutterappdomotica/routes/fade_page_route.dart';
import 'package:flutterappdomotica/utils/icono_string_util.dart';

class DevicesScreen extends StatefulWidget {
  final Room room;

  DevicesScreen({this.room});

  @override
  _DevicesScreenState createState() => _DevicesScreenState();
}

class _DevicesScreenState extends State<DevicesScreen> {
  var titleTextStyle = TextStyle(fontSize: 22, color: Colors.black);
  final _textFieldRoomController = TextEditingController();
  Icon _iconSelected;
  double screenWidth;
  double screenHeight;
  bool isOn = false;
  Device device;
  var _selected;


  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
        body: Stack(
          children: <Widget>[
            GradientBack(height: null),
            _buildAppBarSetting(),
            Container(
                color: Colors.transparent,
                padding: EdgeInsets.symmetric(horizontal: 10.0),
                margin:
                    EdgeInsets.only(top: 80, right: 10, left: 10, bottom: 10),
                child: _listDevices())
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButton: FloatingActionButton(
          elevation: 20,
          hoverElevation: 30,
          child: Icon(Icons.add, size: 30),
          onPressed: () {
            _mostrarAlerta(context);
//            showAlertDialog(context);
          },
        ));
  }

  Widget _buildAppBarSetting() {
    return TitleHeader(
      text: "Dispositivos",
      size: 20.0,
      onPressed: null,
//          () {
//        Navigator.of(context).push(FadePageRoute(widget: RoomDetailsScreen(room: widget.room)));
//        Navigator.push(context,CupertinoPageRoute(builder: (context) {
//              return RoomDetailsScreen(room: widget.room);
//            }));
//        Navigator.of(context).pop();
//      },
    );
  }

  Widget _listDevices() {
    return FutureBuilder(
      future: deviceProvider.cargarData(),
      initialData: [],
      builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
        if (snapshot.hasData) {
          return _gridViewList(snapshot.data, context);
        } else {
          print("Error");
        }
        return Container();
      },
    );
  }

  Widget _gridViewList(List<dynamic> data, BuildContext context) {
    return GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3, crossAxisSpacing: 8, mainAxisSpacing: 5),
        itemCount: data.length,
        itemBuilder: (BuildContext context, int index) {
          return CardDeviceCreate(
            onPressed: () {
              _addDeviceByDefault(data, index);
//              Navigator.of(context).push(
//                  FadePageRoute(widget: RoomDetailsScreen(room: widget.room)));
              _onPressedFav(context, device.iconDeviceOff, false);
            },
            deviceName: data[index]['name'],
          );
        });
  }

  void _mostrarAlerta(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          title: Center(child: Text('Añadír Dispositivo')),
          content: Container(
            height: 100,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Expanded(
                  child: _dropDownList(),
                ),
                Container(
                  width: 220.0,
                  child: TextField(
                    controller: _textFieldRoomController,
                    keyboardType: TextInputType.text,
                    style: TextStyle(
                      fontFamily: "Lato",
                      fontWeight: FontWeight.w600
                    ),
                    textCapitalization: TextCapitalization.words,
                    decoration: InputDecoration(
                      hintText: "Modifique nombre dispositivo",
                      suffixIcon: _iconSelected,
                    ),
                    onChanged: (valor) {
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),
          ),
          elevation: 50.0,
          actions: <Widget>[
            FlatButton(
              child: Text('Cancelar'),
              onPressed: () {
                _clean();
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: Text('Añadir'),
              onPressed: () {
                _addCustomDevice();
                _clean();
//                Navigator.of(context).pop();
//                _clean();
//                setState(() {});
//                Navigator.of(context).pop();
                _onPressedFav(context, device.iconDeviceOff, true);

              },
            )
          ],
        );
      },
    );
  }

  Widget _dropDownList() {
    return DropdownButton<EnumDevice>(
      icon: Container(
        child: Icon(Icons.arrow_drop_down),
      ),
      hint: Padding(
        padding: const EdgeInsets.only(bottom: 5.0),
        child: Text(
          "Selecciona dispositivo",
          style: TextStyle(fontSize: 18, fontFamily: "Lato"),
        ),
      ),
      underline: Container(
        height: 1,
        color: Colors.black54,
        margin: EdgeInsets.only(top: 5.0, bottom: 5.0),
      ),
      iconSize: 50,
      elevation: 16,
      iconEnabledColor: Colors.blue,
      onChanged: (EnumDevice selected) {
        setState(() {
          _selected = selected;
          _textFieldRoomController.text = typesOfRoom(selected);
          _iconSelected =
              Icon(iconFromRoom(selected), size: 50, color: Colors.black);
          Navigator.of(context).pop();
          _mostrarAlerta(context);
        });
      },
      items: EnumDevice.values.map((EnumDevice enumRoom) {
        return DropdownMenuItem<EnumDevice>(
          value: enumRoom,
          child: Text(typesOfRoom(enumRoom)),
        );
      }).toList(),
    );
  }

  void _addDeviceByDefault(List data, int index) {
    device = new Device();
    device.id = idDevice;
    device.name = data[index]['name'];
    device.iconDeviceOff = getIcon(
        IconName: data[index]['iconOn'], color: Colors.white, iconSize: 80);
    device.iconDeviceOn =
        getIcon(IconName: data[index]['iconOff'], color: null, iconSize: 0);
    device.pathImageOn = pathBombillaEncendida1;
    device.pathImageOff = pathBombillaApagada;
    device.isOn = isOn;
    device.longPressCallback = null;
    device.delete = false;
    device.onPressed = () {
      setState(() {
        isOn = !isOn;
      });
    };
  }

  void _addCustomDevice() {
    device = new Device();
    device.id = idDevice;
    device.name = _textFieldRoomController.text;
    device.iconDeviceOff = Icon(
      Icons.power_settings_new,
      color: Colors.red,
      size: 80.0,
    );
    device.iconDeviceOn =
        Icon(Icons.power_settings_new, color: Colors.green, size: 50.0);
    device.pathImageOn = pathBombillaEncendida1;
    device.pathImageOff = pathBombillaApagada;
    device.isOn = isOn;
    device.onPressed = () {
      setState(() {
        isOn = !isOn;
      });
    };
  }

  void _onPressedFav(BuildContext context, Icon iconDeviceOff, bool isCustom) {
    _addDeviceOnList(isCustom);
    Flushbar(
      duration: Duration(milliseconds: 900),
      borderRadius: 10.0,
      backgroundGradient: LinearGradient(
        colors: [Color(0xFF4268D3), Color(0xFF584CD1)],
        stops: [1, 0.5],
      ),
      boxShadows: [
        BoxShadow(
          color: Colors.black45,
          offset: Offset(3, 3),
          blurRadius: 5,
        ),
      ],
      padding: EdgeInsets.only(left: 60),
      titleText: Text(
        device.name + " añadid@ en ",
        style: TextStyle(
          fontSize: 15.0,
          fontFamily: "Lato",
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
//      forwardAnimationCurve: Curves.fastLinearToSlowEaseIn,
      forwardAnimationCurve: Curves.fastOutSlowIn,
      animationDuration: Duration(milliseconds: 900),
      icon: iconDeviceOff,
      flushbarStyle: FlushbarStyle.FLOATING,
      margin: EdgeInsets.only(bottom: screenHeight / 3, left: 8.0, right: 8.0),
      dismissDirection: FlushbarDismissDirection.HORIZONTAL,
      message: widget.room.name,
    )..show(context);
  }

  _addDeviceOnList(bool isCustom) {
    if (widget.room.lisDevices == null) {
      widget.room.lisDevices = List();
    }
    var deviceWidget = RoomDeviceWidget(device: device);
    widget.room.lisDevices.add(deviceWidget);
    idDevice++;
    print(idDevice);
    if(isCustom){
      Navigator.of(context).pop();
    }
  }

  void _clean() {
    _textFieldRoomController.clear();
    _iconSelected = null;
  }

  @override
  void dispose() {
    super.dispose();
  }
}
