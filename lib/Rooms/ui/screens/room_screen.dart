import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterappdomotica/Rooms/model/room.dart';
import 'package:flutterappdomotica/Rooms/ui/widget/card_create_room.dart';
import 'package:flutterappdomotica/Widget/custom_raised_button.dart';
import 'package:flutterappdomotica/Widget/gradient_back.dart';
import 'package:flutterappdomotica/Widget/title_header.dart';
import 'package:flutterappdomotica/constants.dart';
import 'package:flutterappdomotica/enumRoom.dart';
import 'package:flutterappdomotica/utils/key_value.dart';

class RoomScreen extends StatefulWidget {
  @override
  _RoomScreenState createState() => _RoomScreenState();
}

class _RoomScreenState extends State<RoomScreen> {
  final _textFieldRoomController = TextEditingController();
  Room room = Room();
  var _selected;
  Icon _iconSelected;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          GradientBack(height: null),
          _buildAppBarRoom(),
          _addGridView(),
          _addRoomsBTN(context),
        ],
      ),
    );
  }

  Widget _buildAppBarRoom() {
    return TitleHeader(
      text: "Habitaciones",
      size: 20.0,
    );
  }

  Widget _addRoomsBTN(BuildContext context) {
    return Container(
        alignment: Alignment.bottomCenter,
        padding: EdgeInsets.only(right: 10.0, left: 10.0),
        child: CustomRaisedButton(
          text: "Añadir habitación",
          onPressed: () {
            _mostrarAlerta(context);
          },
          marginBottom: 0.0,
          color: Colors.grey,
        ));
  }

  Widget _addGridView() {
    return Container(
      margin: EdgeInsets.only(top: 80, bottom: 50),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Flexible(
            child: _gridView(),
          )
        ],
      ),
    );
  }

  Widget _gridView() {
    return Padding(
      padding: EdgeInsets.only(top: 5.0, left: 5.0, right: 5.0),
      child: GridView.count(
          crossAxisCount: 3,
          children: roomList == null ? _gridViewEmpty() : _gridViewFiled()),
    );
  }

  void _mostrarAlerta(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        // return alert dialog object
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          title: Center(child: Text('Añadír Habitación')),
          content: Container(
            height: 100.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Expanded(
                  child: _dropDownList(),
                ),
//                SizedBox(height: 10.0,),
                Container(
                  width: 220.0,
                  child: TextField(
                    controller: _textFieldRoomController,
                    keyboardType: TextInputType.text,
                    textCapitalization: TextCapitalization.words,
                    decoration: InputDecoration(
                      hintText: "Añade nombre habitación",
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
          actions: <Widget>[
            FlatButton(
              child: Text('Cancelar'),
              onPressed: () {
                _cleanTextField();
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: Text('Añadir'),
              onPressed: () {
                _addRoomOnList();
                setState(() {});
                _cleanTextField();
                Navigator.of(context).pop();
              },
            )
          ],
        );
      },
    );
  }

  void _addRoomOnList() {
    room.name = _textFieldRoomController.text;
    room.id = idRoom;
    room.iconRoom = _iconSelected;
    if (roomList == null) {
      roomList = List<Room>();
      cardList = List<CardCreateRoom>();
    }
    roomList.add(room);
    var cardCreateRoom = CardCreateRoom(room: room);
    cardList.add(cardCreateRoom);
    idRoom++;
    clear();
  }

  Widget _dropDownList() {
    return DropdownButton<EnumRoom>(
      icon: Container(
        child: Icon(Icons.arrow_drop_down),
      ),
      hint: Padding(
        padding: const EdgeInsets.only(bottom: 5.0),
        child: Text(
          "Selecciona habitación",
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
      onChanged: (EnumRoom selected) {
        setState(() {
          _selected = selected;
          _textFieldRoomController.text = typesOfRoom(selected);
          _iconSelected =
              Icon(iconFromRoom(selected), size: 50, color: Colors.black);
          Navigator.of(context).pop();
          _mostrarAlerta(context);
        });
      },
      items: EnumRoom.values.map((EnumRoom enumRoom) {
        return DropdownMenuItem<EnumRoom>(
          value: enumRoom,
          child: Text(typesOfRoom(enumRoom)),
        );
      }).toList(),
    );
  }

  List<Widget> _gridViewEmpty() {
    return <Widget>[];
  }

  List<Widget> _gridViewFiled() {
    cardList.sort((a, b) => a.room.id.compareTo(b.room.id));
    return cardList != null ? cardList.toList() : [];
  }

  void _cleanTextField() {
    _textFieldRoomController.clear();
    _iconSelected = null;
  }

  @override
  void dispose() {
    _textFieldRoomController.dispose();
    super.dispose();
  }

  void clear() {
    _textFieldRoomController.clear();
    room = new Room();
  }
}
