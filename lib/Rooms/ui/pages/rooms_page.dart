import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterappdomotica/Widget/custom_raised_button.dart';
import 'package:flutterappdomotica/Widget/gradient_back.dart';
import 'package:flutterappdomotica/Widget/title_header.dart';
import 'package:flutterappdomotica/constants.dart';
import 'package:flutterappdomotica/providers/provider.dart';

class RoomsPage extends StatefulWidget {
  @override
  _RoomsPageState createState() => _RoomsPageState();
}

class _RoomsPageState extends State<RoomsPage> {
  final _textFieldRoomController = TextEditingController();
/*  Rooms rooms;
  Room room;
  RoomModel roomModel;
  var _selected;
  Icon _iconSelected;
  RoomBloc roomBloc;
  RoomsBloc roomsBloc;
  List<CardRoomNew> newCardList;*/

  @override
  Widget build(BuildContext context) {
  /*  roomBloc = Provider.roomBloc(context);
   roomsBloc = Provider.roomsBloc(context);
    if(newCardList == null){
      newCardList = new List<CardRoomNew>();
    }*/

    return Scaffold(
      body: Stack(
        children: <Widget>[
          GradientBack(height: null),
          _buildAppBarRoom(),
          _addGridView(),
//          _addRoomsBTN(context),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blueAccent,
        elevation: 20,
        hoverElevation: 30,
        child: Icon(Icons.add, size: 30),
        onPressed: (){
//          _mostrarAlerta(context);
        },
      ),
    );
  }

  Widget _buildAppBarRoom() {
    return TitleHeader(
      text: "Habitaciones",
      size: 20.0,
      onPressed: (){},
    );
  }

  Widget _addRoomsBTN(BuildContext context) {
    return Container(
        alignment: Alignment.bottomCenter,
        padding: EdgeInsets.only(right: 10.0, left: 10.0),
        child: CustomRaisedButton(
          text: "Añadir habitación",
          onPressed: () {
//            _mostrarAlerta(context);
          },
          marginBottom: 0.0,
          color: Colors.grey,
        ));
  }

  Widget _addGridView() {
    return Container(
      margin: EdgeInsets.only(top: 80, bottom: 10),
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
          children: /*roomList == null ?*/ _gridViewEmpty() /*: _gridViewFiled()*/),
    );
  }

  List<Widget> _gridViewEmpty() {
    return <Widget>[];
  }

/*  void _mostrarAlerta(BuildContext context) {
    showDialog(
      context: context,
      useRootNavigator: true,
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
  }*/

/*  void _addRoomOnList() {
    room = Room();
    roomModel = RoomModel();
    rooms = Rooms();
    roomModel.name = _textFieldRoomController.text;
    room.name = _textFieldRoomController.text;
    room.id = idRoom;
    roomModel.iconRoom = _iconSelected;
    room.iconRoom = _iconSelected;
    if (roomList == null) {

      roomList = List<Room>();
//      room.lisDevices = List<RoomWidget>();
      cardList = List<CardRoom>();
    }
    if(rooms.listRoom == null){
      rooms.listRoom = List<RoomModel>();
      roomModel.listDevices = List<DeviceModel>();
    }
    roomList.add(room);
    rooms.listRoom.add(roomModel);
    var cardRoom = CardRoom(room: room);
    cardList.add(cardRoom);
    var cardRoomNew = CardRoomNew(roomModel: roomModel);
    newCardList.add(cardRoomNew);
    roomsBloc.agregarRoom(roomModel);
    idRoom++;
    clear();
  }*/

/*  Widget _dropDownList() {
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
  }*/



/*  List<Widget> _gridViewFiled() {
    cardList.sort((a, b) => a.room.id.compareTo(b.room.id));
    return cardList != null ? cardList.toList() : [];
  }*/

  void _cleanTextField() {
    _textFieldRoomController.clear();
//    _iconSelected = null;
  }

  void clear() {
    _textFieldRoomController.clear();
//    room = new Room();
  }

  @override
  void dispose() {
    _textFieldRoomController.dispose();
    super.dispose();
  }

}
