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
import 'package:flutterappdomotica/Users/api/cloud_firestore_api.dart';
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
  final String DEVICES = "devices";

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
    final devicesBloc = Provider.devicesBloc(context);
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
          ReorderableFirebaseList(
            roomName: _myroom.name,
            collection: devicesBloc.allDevicesListStreamByRoomName(_myroom.uid),/*Firestore.instance.collection(CloudFirestoreAPI().DEVICES).where("roomName" , isEqualTo: _myroom.name).snapshots()*//*Firestore.instance.collection("rooms"),*/
            indexKey: 'pos',
            itemBuilder: (BuildContext context, int index, DocumentSnapshot doc) {
              var deviceModel = DeviceModel.fromDocumentSnapshot(doc);
              return _createListItem(deviceModel, devicesBloc,context);

               /*
                ListTile(
                key: Key(doc.documentID),
                title: Text(doc.data['name']),
              );*/
            },
          )
        ],
      ),
    );
  }

  Container _buildNameRoom() {
    return Container(
      alignment: _isPressedDelete ? Alignment.center : Alignment.centerLeft,
      child: !editClicking
          ? Text(
             _myroom.name,
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
            onTap: () {
              Navigator.pushNamed(context, myRoomPage, arguments: _myroom);
            },
            leading: Icon(Icons.edit),
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

  Widget _createListItem(DeviceModel deviceModel, DevicesBloc devicesBloc, BuildContext context) {
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

  IconData getCheckIcon(bool checkSelected) {
    return checkSelected ? Icons.check_box : Icons.check_box_outline_blank;
  }

  @override
  void dispose() {
    _nameController?.dispose();
    super.dispose();
  }
}

typedef ReorderableWidgetBuilder = Widget Function(BuildContext context, int index, DocumentSnapshot doc);

class ReorderableFirebaseList extends StatefulWidget {
  const ReorderableFirebaseList({
    Key key,
    @required this.collection,
    @required this.indexKey,
    @required this.itemBuilder,
    @required this.roomName,
    this.descending = false,
  }) : super(key: key);

  final Stream<QuerySnapshot> collection;
  final String indexKey;
  final bool descending;
  final ReorderableWidgetBuilder itemBuilder;
  final String roomName;

  @override
  _ReorderableFirebaseListState createState() => _ReorderableFirebaseListState();
}

class _ReorderableFirebaseListState extends State<ReorderableFirebaseList> {
  List<DocumentSnapshot> _docs;
  Future _saving;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _saving,
      builder: (BuildContext context, AsyncSnapshot snapshotfuture) {
        if (snapshotfuture.connectionState == ConnectionState.none || snapshotfuture.connectionState == ConnectionState.done) {
          return StreamBuilder<QuerySnapshot>(
            stream: widget.collection/*.where("roomName" , isEqualTo: widget.roomName)*//*.orderBy(widget.indexKey, descending: widget.descending).snapshots()*/,
            builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasData) {
                _docs = snapshot.data.documents;
                return ReorderableListView(
                  onReorder: _onReorder,
                  children: List.generate(_docs.length, (int index) {
                    return widget.itemBuilder(context, index, _docs[index]);
                  }),
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  void _onReorder(int oldIndex, int newIndex) {
    if (oldIndex < newIndex) newIndex -= 1;
    _docs.insert(newIndex, _docs.removeAt(oldIndex));
    final batch = Firestore.instance.batch();
    for (int pos = 0; pos < _docs.length; pos++) {
      batch.updateData(_docs[pos].reference, {widget.indexKey: pos});
    }
    batch.commit();
  }
}
