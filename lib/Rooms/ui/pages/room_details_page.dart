import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutterappdomotica/Devices/bloc/devices_bloc.dart';
import 'package:flutterappdomotica/Devices/model/device_model.dart';
import 'package:flutterappdomotica/Devices/ui/widget/slider_widget.dart';
import 'package:flutterappdomotica/Devices/ui/widget/tile_widget.dart';
import 'package:flutterappdomotica/Rooms/bloc/rooms_bloc.dart';
import 'package:flutterappdomotica/Rooms/model/my_room.dart';
import 'package:flutterappdomotica/Rooms/model/room_model.dart';
import 'package:flutterappdomotica/Rooms/ui/widget/card_room.dart';
import 'package:flutterappdomotica/Users/bloc/user_bloc.dart';
import 'package:flutterappdomotica/Users/ui/widget/verified_show_dialog.dart';
import 'package:flutterappdomotica/Widget/custom_raised_button.dart';
import 'package:flutterappdomotica/Widget/gradient_back.dart';
import 'package:flutterappdomotica/Widget/title_header.dart';
import 'package:flutterappdomotica/constants.dart';
import 'package:flutterappdomotica/providers/provider.dart';
import 'package:flutterappdomotica/utils/util_icon.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class RoomDetailsPage extends StatefulWidget {
  @override
  _RoomDetailsPageState createState() => _RoomDetailsPageState();
}

class _RoomDetailsPageState extends State<RoomDetailsPage> {
  MyRoom _myroom;
  FirebaseUser _currentuser;
  final TextEditingController _nameController = TextEditingController();
  final ScrollController _controllerListView = ScrollController();
  final FocusNode focusNode = FocusNode();
  final FocusScopeNode focusScopeNode = FocusScopeNode();
  final TextStyle textStyle = TextStyle();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  bool editClicking = false;
  bool _isPressedDelete = false;
  bool _checkSelected = false;
  bool _isOn;
  bool isOnOffDevice;
  double screenWidth;
  double screenHeight;
  double _valorSlider = 0.0;
  List<Widget> lista = new List();

//  Device device;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final roomData = ModalRoute.of(context).settings.arguments;
//    final _roomBloc = Provider.roomsBloc(context);
//    final _userBloc = Provider.userBloc(context);
    final _devicesBloc = Provider.devicesBloc(context);
    double withDrawer = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    if (roomData != null) {
      _myroom = roomData;
    }

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            }),
        backgroundColor: Color(0xFF4268D3),
        title: _buildNameRoom(),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.menu, size: 30.0), onPressed: () => _scaffoldKey.currentState.openEndDrawer()),
        ],
      ),
      endDrawer: Container(
        margin: EdgeInsets.only(top: 31, bottom: 15.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15.0),
          child: _buildDrawer(withDrawer, height, context),
        ),
      ),
      body: Stack(
        children: <Widget>[
          Hero(tag: _myroom.uid, child: GradientBack(height: null)),
          _createListViewDevices(_devicesBloc),
        ],
      ),
    );
  }

  Container _buildNameRoom() {
    return Container(
      alignment: _isPressedDelete ? Alignment.center : Alignment.centerLeft,
      child: !editClicking
          ? Text(
              _myroom.nickName != null && _myroom.nickName.isNotEmpty ? _myroom.nickName : _myroom.name,
            )
          : EditableText(
              textInputAction: TextInputAction.newline,
              controller: _nameController,
              backgroundCursorColor: Colors.white,
              focusNode: focusNode,
              style: TextStyle(color: Colors.white, fontFamily: "Lato", fontSize: 18, fontWeight: FontWeight.w500),
              cursorColor: Colors.white,
              autofocus: editClicking,
              textScaleFactor: 1,
              textAlign: TextAlign.start,
              keyboardType: TextInputType.text,
              autocorrect: true,
              cursorOpacityAnimates: true,
              enableSuggestions: true,
            ),
    );
  }

  Drawer _buildDrawer(double withDrawer, double height, BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          DrawerHeader(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.0),
                color: Color(0xFF4268D3),
              ),
              child: Stack(
                children: <Widget>[
                  Align(
                    alignment: Alignment.centerLeft,
                    child: CircleAvatar(
                      backgroundColor: Colors.grey,
                      child:
                          _myroom.uriImage.isEmpty ? Icon(IconFromIconName(_myroom.icon), size: 60.0, color: Colors.white) : null,
                      radius: 50.0,
                      backgroundImage: _myroom.uriImage.isNotEmpty ? AssetImage(_myroom.uriImage) : null,
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      _myroom.name,
                      style: TextStyle(fontSize: 30.0, fontFamily: "Lato", color: Colors.white),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight + Alignment(0, .3),
                    child: Text(
                      "Alguna descripción",
                      style: TextStyle(fontSize: 10.0, fontFamily: "Lato", color: Colors.white),
                    ),
                  ),
                ],
              )),
          ListTile(
            contentPadding: EdgeInsets.symmetric(horizontal: withDrawer / 6),
            title: Text("Añadir dispositivo"),
            onTap: () {
//              var route = new MaterialPageRoute(builder: (BuildContext context) =>DevicesScreen(_roomModel: _roomModel));
//              Navigator.pop(context);
//              Navigator.of(context).push(route);
//              Navigator.of(context).push(
//                  FadePageRoute(widget: DevicesScreen(room: room)));
            },
            leading: Icon(Icons.add_box),
          ),
          Divider(),
          ListTile(
            contentPadding: EdgeInsets.symmetric(horizontal: withDrawer / 6),
            title: Text("Eliminar dispositivo"),
            onTap: () {
//              _deleteDevice(context);
            },
            leading: Icon(Icons.delete_forever),
          ),
          Divider(),
          ListTile(
            contentPadding: EdgeInsets.symmetric(horizontal: withDrawer / 6),
            title: Text("Editar " + _myroom.name),
            onTap: () {},
            leading: Icon(Icons.edit),
          ),
          Divider(),
          ListTile(
            contentPadding: EdgeInsets.symmetric(horizontal: withDrawer / 6),
            title: Text("Una acción"),
            onTap: () {},
            leading: Icon(Icons.settings),
          ),
          Divider(),
          Container(
            margin: EdgeInsets.only(top: 50.0),
            width: withDrawer / 3,
            height: withDrawer / 3,
            child: Image(
              image: AssetImage(pathLogo),
            ),
          )
        ],
      ),
    );
  }

  _createListViewDevices(DevicesBloc devicesBloc) {
    return StreamBuilder(
      stream: devicesBloc.allDevicesListStreamByRoomName(_myroom.name),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasError) {
          return ErrorShowDialog(context, "Error", devicesErrorGetDevices, roomsPage);
        } else {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
            case ConnectionState.none:
              return Center(child: CircularProgressIndicator());
            case ConnectionState.active:
            case ConnectionState.done:
            default:
              final document = snapshot.data != null ? snapshot.data.documents : 0;
              for (int i = 0; i < document.length; i++) {
                var deviceModel = DeviceModel.fromDocumentSnapshot(document[i]);
                if (lista.isNotEmpty && lista.length == document.length) {
                  if (!listaUIDs.contains(deviceModel.uid)) {
                    lista.add(_createListItem(deviceModel, devicesBloc, context));
                  }
                } else {
                  listaUIDs.add(deviceModel.uid);
                  lista.add(_createListItem(deviceModel, devicesBloc, context));
                }
              }
              return ReorderableListView(
                header: SizedBox(height: 5.0,),
                onReorder: _onReorder,
                children: lista,
              );
            /* return ListView.builder(
                  itemCount: document != null ? document.length == null ? 0 : document.length : 0,
                  itemBuilder: (context, index) => _createListItem(document[index], devicesBloc, context));*/
          }
        }
      },
    );
  }

  void _onReorder(int oldIndex, int newIndex) {
    setState(
      () {
        if (newIndex > oldIndex) {
          newIndex -= 1;
        }
        final Widget item = lista.removeAt(oldIndex);
        lista.insert(newIndex, item);
      },
    );
  }

  Widget _createListItem(DeviceModel deviceModel, DevicesBloc devicesBloc, BuildContext context) {
//    var deviceModel = DeviceModel.fromDocumentSnapshot(document);
    _isOn = deviceModel.status;
    if (deviceModel.name.contains("Persiana")) {
      isOnOffDevice = false;
    } else {
      isOnOffDevice = true;
    }
    return isOnOffDevice
        ? Container(
            height: 80.0,
            key: UniqueKey(),
            margin: EdgeInsets.only(top: 5.0, right: 5.0, left: 5.0, bottom: 5.0),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: <BoxShadow>[BoxShadow(blurRadius: 3.0, offset: Offset(0.0, 3.0))],
            ),
            child: TileWidget(deviceModel))
        /*ListTile(
              title: Center(
                child: Text(
                  deviceModel.name,
                  style: TextStyle(fontFamily: fontFamilyText, color: Colors.black, fontSize: 20.0),
                ),
              ),
              contentPadding: EdgeInsets.only(top: 10.0, bottom: 10.0, right: 10.0, left: 10.0),
//                subtitle:Center(child: Text(deviceModel.uid, style: TextStyle(fontFamily: fontFamilyText, color: Colors.black38))),
              leading: Icon(
                IconFromIconName(deviceModel.name),
                color: deviceModel.status ? Colors.green : Colors.red,
                size: 30,
              ),
              trailing: Container(width: 80.0, child: _buildButtonOnOffDevice(deviceModel, devicesBloc, context)),
              dense: false,
              onTap: () {
                _isOn = !deviceModel.status;
                devicesBloc.changeStatusValue(deviceModel.uid, _isOn);
                if (_isOn) {
                  _onPressedFav(context, deviceModel);
                }
              },
            ),
          )*/
        : Container(
            height: 80.0,
            key: UniqueKey(),
            margin: EdgeInsets.only(top: 5.0, right: 5.0, left: 5.0, bottom: 5.0),
//      color: Colors.lightBlueAccent,
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: <BoxShadow>[BoxShadow(blurRadius: 3.0, offset: Offset(0.0, 3.0))],
            ),
            child: SliderWidget(deviceModel));
  }

  Widget _buildButtonOnOffDevice(DeviceModel deviceModel, DevicesBloc devicesBloc, BuildContext context) {
    return Switch(
      value: deviceModel.status,
      inactiveTrackColor: Colors.grey,
      inactiveThumbColor: Colors.blueAccent,
      activeTrackColor: Colors.green,
      activeColor: Colors.white,
      onChanged: (value) {
        _isOn = !deviceModel.status;
        devicesBloc.changeStatusValue(deviceModel.uid, _isOn);
        if (_isOn) {
          _onPressedFav(context, deviceModel);
        }
      },
    );
  }

  IconData getCheckIcon(bool checkSelected) {
    return checkSelected ? Icons.check_box : Icons.check_box_outline_blank;
  }

  void _onPressedFav(BuildContext context, DeviceModel deviceModel) {
    Flushbar(
      duration: Duration(milliseconds: 900),
      borderRadius: 10.0,
      /*backgroundGradient: LinearGradient(
        colors: [Color(0xFF4268D3), Color(0xFF584CD1)],
        stops: [1, 0.5],
      ),*/
      boxShadows: [
        BoxShadow(
          color: Colors.black45,
          offset: Offset(3, 3),
          blurRadius: 5,
        ),
      ],
      padding: EdgeInsets.only(left: 30, top: 5.0, bottom: 5.0),
      titleText: Text(
        "Has añadido: " + deviceModel.name,
        style: TextStyle(
          fontSize: 18.0,
          fontFamily: "Lato",
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
//      forwardAnimationCurve: Curves.fastLinearToSlowEaseIn,
      forwardAnimationCurve: Curves.fastOutSlowIn,
      animationDuration: Duration(milliseconds: 900),
      icon: Icon(
        IconFromIconName(deviceModel.name),
        color: Colors.green,
        size: 30,
      ),
      flushbarStyle: FlushbarStyle.FLOATING,
      margin: EdgeInsets.only(bottom: 200, left: 8.0, right: 8.0),
      dismissDirection: FlushbarDismissDirection.HORIZONTAL,
      messageText: Text(
        deviceModel.roomName,
        style: TextStyle(
          fontSize: 18.0,
          fontFamily: "Lato",
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    )..show(context);
  }

  @override
  void dispose() {
    _nameController?.dispose();
    super.dispose();
  }
}
