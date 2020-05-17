import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutterappdomotica/Rooms/model/device.dart';
import 'package:flutterappdomotica/Rooms/model/room.dart';
import 'package:flutterappdomotica/Rooms/ui/screens/devices_screen.dart';
import 'package:flutterappdomotica/Rooms/ui/screens/home_screen.dart';
import 'package:flutterappdomotica/Rooms/ui/screens/rooms_screen.dart';
import 'package:flutterappdomotica/Rooms/ui/widget/card_device_create.dart';
import 'package:flutterappdomotica/Rooms/ui/widget/card_room_create.dart';
import 'package:flutterappdomotica/Rooms/ui/widget/room_device_widget.dart';
import 'package:flutterappdomotica/Rooms/ui/widget/sign_in_app_init.dart';
import 'package:flutterappdomotica/Users/ui/screens/init_screen.dart';
import 'package:flutterappdomotica/Widget/custom_raised_button.dart';
import 'package:flutterappdomotica/Widget/gradient_back.dart';
import 'package:flutterappdomotica/Widget/title_header.dart';
import 'package:flutterappdomotica/constants.dart';
import 'package:flutterappdomotica/enumRoom.dart';
import 'package:flutterappdomotica/providers/device_provider.dart';
import 'package:flutterappdomotica/routes/fade_page_route.dart';
import 'package:flutterappdomotica/routes/route_page.dart';
import 'package:flutterappdomotica/utils/icono_string_util.dart';

class RoomDetailsScreen extends StatefulWidget {
  final Room room;

  RoomDetailsScreen({this.room});

  @override
  _RoomDetailsScreenState createState() => _RoomDetailsScreenState();
}

class _RoomDetailsScreenState extends State<RoomDetailsScreen> {
  final TextEditingController _nameController = TextEditingController();
  final ScrollController _controllerListView = ScrollController();
  final FocusNode focusNode = FocusNode();
  final FocusScopeNode focusScopeNode = FocusScopeNode();
  TextStyle textStyle = TextStyle();

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  bool isOn = false;
  bool editClicking = false;
  double screenWidth;
  double screenHeight;
  Device device;
  var _isPressedDelete = false;
  var _checkSelected = false;

  @override
  Widget build(BuildContext context) {
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
                IconButton(
                    icon: Icon(Icons.delete, size: 30.0),
                    padding: EdgeInsets.only(right: 20.0),
                    onPressed: () {}),
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
                IconButton(
                    icon: !editClicking ? Icon(Icons.edit) : Icon(Icons.save),
                    onPressed: () {
                      if (editClicking) {
                        widget.room.name = _nameController.text;
                      }
                      setState(() {
                        editClicking = !editClicking;
                      });
                    }),
                IconButton(
                    icon: Icon(Icons.menu, size: 30.0),
                    onPressed: () => _scaffoldKey.currentState.openEndDrawer()),
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
          Hero(tag: widget.room.id, child: GradientBack(height: null)),
          _buildListView(),
        ],
      ),
    );
  }

  Container _buildNameRoom() {
    return Container(
      alignment: _isPressedDelete ? Alignment.center : Alignment.centerLeft,
      child: !editClicking
          ? Text(
              widget.room != null && widget.room.name.isNotEmpty
                  ? widget.room.name
                  : "Habitación",
            )
          : EditableText(
              textInputAction: TextInputAction.newline,
              controller: _nameController,
              backgroundCursorColor: Colors.white,
              focusNode: focusNode,
              style: TextStyle(
                  color: Colors.white,
                  fontFamily: "Lato",
                  fontSize: 18,
                  fontWeight: FontWeight.w500),
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

  Widget _buildListView() {
    return Container(
      margin: EdgeInsets.only(top: 5.0, bottom: 5.0),
      child: Column(
        children: <Widget>[
          Flexible(
            child: ListView(
              controller: _controllerListView,
              children: widget.room.lisDevices != null
                  ? _isPressedDelete ? _showDevicesToDelete() : _showDevices()
                  : _showEmptyList(),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _showEmptyList() {
    return [];
  }

  List<Widget> _showDevices() {
    widget.room.lisDevices.forEach((element) {
      setState(() {
        element.isPressedDelete = _isPressedDelete;
      });
    });
    return widget.room.lisDevices;
  }

  List<Widget> _showDevicesToDelete() {
    widget.room.lisDevices.forEach((element) {
      setState(() {
        print("Antes de " + element.isPressedDelete.toString());
        element.isPressedDelete = _isPressedDelete;
        print("Despues de " + element.isPressedDelete.toString());
      });
    });
    return widget.room.lisDevices;
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
                      radius: 50.0,
                      backgroundImage: AssetImage(pathSofa),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      widget.room.name,
                      style: TextStyle(
                          fontSize: 30.0,
                          fontFamily: "Lato",
                          color: Colors.white),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight + Alignment(0, .3),
                    child: Text(
                      "Alguna descripción",
                      style: TextStyle(
                          fontSize: 10.0,
                          fontFamily: "Lato",
                          color: Colors.white),
                    ),
                  ),
                ],
              )),
          ListTile(
            contentPadding: EdgeInsets.symmetric(horizontal: withDrawer / 6),
            title: Text("Añadir dispositivo"),
            onTap: () {
              var route = new MaterialPageRoute(
                  builder: (BuildContext context) =>
                      DevicesScreen(room: widget.room));
              Navigator.pop(context);
              Navigator.of(context).push(route);
//              Navigator.of(context).push(
//                  FadePageRoute(widget: DevicesScreen(room: widget.room)));
            },
            leading: Icon(Icons.add_box),
          ),
          Divider(),
          ListTile(
            contentPadding: EdgeInsets.symmetric(horizontal: withDrawer / 6),
            title: Text("Eliminar dispositivo"),
            onTap: () {
              _deleteDevice(context);
            },
            leading: Icon(Icons.delete_forever),
          ),
          Divider(),
          ListTile(
            contentPadding: EdgeInsets.symmetric(horizontal: withDrawer / 6),
            title: Text("Editar " + widget.room.name),
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

  void _deleteDevice(BuildContext context) {
    setState(() {
      _isPressedDelete = true;
    });
    if (widget.room.lisDevices.isNotEmpty) {
      print("Elimina dispositivo");
      widget.room.lisDevices.removeLast();
    }
    _clean();
    Navigator.of(context).pop();
  }

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
