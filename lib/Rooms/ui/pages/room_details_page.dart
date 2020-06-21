import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutterappdomotica/Rooms/bloc/rooms_bloc.dart';
import 'package:flutterappdomotica/Rooms/model/my_room.dart';
import 'package:flutterappdomotica/Rooms/model/room_model.dart';
import 'package:flutterappdomotica/Rooms/ui/widget/card_room.dart';
import 'package:flutterappdomotica/Users/bloc/user_bloc.dart';
import 'package:flutterappdomotica/Widget/custom_raised_button.dart';
import 'package:flutterappdomotica/Widget/gradient_back.dart';
import 'package:flutterappdomotica/Widget/title_header.dart';
import 'package:flutterappdomotica/constants.dart';
import 'package:flutterappdomotica/providers/provider.dart';
import 'package:flutterappdomotica/utils/util_icon.dart';

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
  bool isOn = false;
  bool editClicking = false;
  bool _isPressedDelete = false;
  bool _checkSelected = false;
  double screenWidth;
  double screenHeight;

//  Device device;

  @override
  void initState() {
    super.initState();
    /* _controllerListView.addListener(() {
      if (_controllerListView.position.pixels > 50) {
        setState(() {
          _buildListView();
        });
      }
    });*/
  }

  @override
  Widget build(BuildContext context) {
    final roomData = ModalRoute.of(context).settings.arguments;
    final _roomBloc = Provider.roomsBloc(context);
    final _userBloc = Provider.userBloc(context);

    if (roomData != null) {
      _myroom = roomData;
    }
    double withDrawer = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        leading: _isPressedDelete
            ? IconButton(
                icon: Icon(getCheckIcon(_checkSelected), size: 30.0),
                padding: EdgeInsets.only(right: 50.0, left: 15.0),
                onPressed: () {
                  setState(() {
                    _checkSelected = !_checkSelected;
//                    seleccionar todos los devices.
//                    _buildListView();
                  });
                })
            : IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.pop(context);
                }),
        backgroundColor: Color(0xFF4268D3),
        title: _buildNameRoom(),
        actions: _isPressedDelete
            ? <Widget>[
                IconButton(icon: Icon(Icons.delete, size: 30.0), padding: EdgeInsets.only(right: 20.0), onPressed: () {}),
                IconButton(
                    icon: Icon(Icons.clear, size: 30.0),
                    padding: EdgeInsets.only(right: 10.0),
                    onPressed: () {
                      setState(() {
                        _isPressedDelete = false;
                      });
                    }),
              ]
            : <Widget>[
                /* IconButton(
                    icon: !editClicking ? Icon(Icons.edit) : Icon(Icons.save),
                    onPressed: () {
                      if (editClicking) {
                        _roomModel.name = _nameController.text;
                        print(_roomModel.name);
                      }
                      setState(() {
                        editClicking = !editClicking;
                      });
                    }),*/
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
//          _buildListViewDevices(_roomBloc, _userBloc, context),
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

/*
  FutureBuilder _buildListViewDevices(RoomsBloc _roomsBloc, UserBloc _userBloc, BuildContext context) {
    return FutureBuilder(
      future: _userBloc.currentUser,
      builder: (context, snapshot) {
        if (!snapshot.hasError && snapshot.hasData) {
//          var allMyRoomsListStream = _roomsBloc.allMyRoomsListStream(snapshot.data);
//          _currentuser = snapshot.data;
          return _createListViewDevices(_roomsBloc, _userBloc, allMyRoomsListStream);
        } else if (!snapshot.hasError) {
//          TODO:  mejorar este return
          return CircularProgressIndicator();
        } else {
//          TODO:  mejorar este return
          return null;
        }
      },
    );
  }
*/

/*  _createListViewDevices(DevicesBloc devicesBloc) {
    return StreamBuilder(
      stream: devicesBloc.allDevicesListStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasError) {
//          TODO: mejorar este return
          return null;
        } else {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
            case ConnectionState.none:
              return CircularProgressIndicator();
            case ConnectionState.active:
            case ConnectionState.done:
            default:
              final devices = snapshot.data != null ? snapshot.data.documents : null;
              return ListView.builder(
                  itemCount: devices != null ? devices.length == null ? 0 : devices.length : 0,
                  itemBuilder: (context, index) => _createListItem(devices[index]));
          }
        }
      },
    );
  }*/

  Widget _createListItem(DocumentSnapshot device) {
    return ListTile(
      title: device['name'],
      subtitle: device['uid'],
      onTap: (){
//        var deviceModel = RoomModel.fromDocumentSnapshot(device);
//        Navigator.pushNamed(context, roomDetailsPage, arguments: deviceModel);
      },
    );
  }

/*  Widget _buildListView() {
    return Container(
      margin: EdgeInsets.only(top: 5.0, bottom: 5.0),
      child: Column(
        children: <Widget>[
          Flexible(
            child: ListView(
              controller: _controllerListView,
              children:
                  */ /* _roomModel.lisDevices != null
                  ? _isPressedDelete ? _showDevicesToDelete() :*/ /* _showDevices()
//                  _showEmptyList(),
            ),
          ),
        ],
      ),
    );
  }*/

  List<Widget> _showEmptyList() {
    return [];
  }

/*  List<Widget> _showDevices() {
    _roomModel.lisDevices.forEach((element) {
      setState(() {
        element.isPressedDelete = _isPressedDelete;
      });
    });
    return _roomModel.lisDevices;
  }*/

/*  List<Widget> _showDevicesToDelete() {
    _roomModel.lisDevices.forEach((element) {
      setState(() {
        print("Antes de " + element.isPressedDelete.toString());
        element.isPressedDelete = _isPressedDelete;
        print("Despues de " + element.isPressedDelete.toString());
      });
    });
    return _roomModel.lisDevices;
  }*/

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
                      child: _myroom.uriImage.isEmpty
                          ? Icon(IconFromIconName(_myroom.icon), size: 60.0, color: Colors.white)
                          : null,
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

/*  void _deleteDevice(BuildContext context) {
    setState(() {
      _isPressedDelete = true;
    });
    if (_roomModel.lisDevices.isNotEmpty) {
      print("Elimina dispositivo");
      _roomModel.lisDevices.removeLast();
    }
    _clean();
    Navigator.of(context).pop();
  }*/

  void _clean() {
    _nameController.clear();
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  IconData getCheckIcon(bool checkSelected) {
    return checkSelected ? Icons.check_box : Icons.check_box_outline_blank;
  }
}
