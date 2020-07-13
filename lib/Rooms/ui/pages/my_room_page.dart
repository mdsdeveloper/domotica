import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutterappdomotica/Rooms/bloc/rooms_bloc.dart';
import 'package:flutterappdomotica/Rooms/model/my_room.dart';
import 'package:flutterappdomotica/Users/bloc/user_bloc.dart';
import 'package:flutterappdomotica/Users/ui/widget/item_profile.dart';
import 'package:flutterappdomotica/Users/ui/widget/verified_show_dialog.dart';
import 'package:flutterappdomotica/constants.dart';
import 'package:flutterappdomotica/providers/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MyRoomPage extends StatefulWidget {
  @override
  _MyRoomPageState createState() => _MyRoomPageState();
}

class _MyRoomPageState extends State<MyRoomPage> {
  MyRoom _myroom;
  ScrollController _scrollController = ScrollController();
  bool _isSelected = false;
  bool _isEditingText = false;
  TextEditingController _nameMyRoomController;
  TextEditingController _nController;
  TextEditingController _urlController;
  String initialText = "";
  FirebaseUser currentUser;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _userBloc = Provider.userBloc(context);
    final _roomBloc = Provider.roomsBloc(context);
    final roomData = ModalRoute.of(context).settings.arguments;
    if (roomData != null) {
      _userBloc.currentUser.then((value) {
        currentUser = value;
      });

      _myroom = roomData;
      _nameMyRoomController = TextEditingController.fromValue(TextEditingValue(text: _myroom.name));
    }
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            }),
        backgroundColor: Color(0xFF4268D3),
        title: _buildNameRoom(_roomBloc),
      ),
      body: Container(
          color: Colors.white54,
          padding: EdgeInsets.symmetric(horizontal: 10.0),
          margin: EdgeInsets.only(top: 10.0, right: 10.0, left: 10.0, bottom: 10.0),
          child: ListView(controller: _scrollController, children: [_body(context, _roomBloc)])),
    );
  }

   _buildNameRoom(RoomsBloc roomBloc) {
    initialText = _myroom.name;
    StreamBuilder(
      stream: roomBloc.roomsModelStream,
      builder: (context, snapshot){
        if(snapshot.hasData){
          return Container(
              alignment: Alignment.centerLeft,
              child: Text(
                snapshot.data['name'],
              ));
        }else{
          return CircularProgressIndicator();
        }
      },
    );


  }

  _body(BuildContext context, RoomsBloc roomBloc) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          TextField(
              maxLines: 1,
              minLines: 1,
              selectionHeightStyle: BoxHeightStyle.strut,
              onEditingComplete: () {
//              enviar al servidor y cambiar el nombre
//                setState(() {
                  _changeNameMyRoomOnServer(_nameMyRoomController.text, roomBloc);
//                });
              },
              onChanged: roomBloc.changeMyRoom,
              decoration: InputDecoration(
                icon: Icon(FontAwesomeIcons.edit),
                isDense: true,
                helperText: "Cambiar nombre de mi habitación",
//                hintText: _myroom.name,
              ),
              keyboardType: TextInputType.text,
              enableInteractiveSelection: _isSelected,
              style: TextStyle(fontFamily: "Lato", fontSize: 28, fontWeight: FontWeight.w500),
              controller: _nameMyRoomController),
          Divider(
            height: 4,
          ),
          /* TextField(
              maxLines: 1,
              minLines: 1,
              selectionHeightStyle: BoxHeightStyle.strut,
              onEditingComplete: () {
//              enviar al servidor y cambiar el nombre
                print("Completo");
              },
              decoration: InputDecoration(
                icon: Icon(FontAwesomeIcons.edit),
                isDense: true,
                helperText: "Cambiar nickname de habitación",
                hintText: _myroom.nickName,
              ),
              keyboardType: TextInputType.text,
              enableInteractiveSelection: _isSelected,
              onTap: () {
                print(_isSelected);
                _isSelected = !_isSelected;
                setState(() {});
              },
              style: TextStyle(fontFamily: "Lato", fontSize: 28, fontWeight: FontWeight.w500),
              controller: _nameMyRoomController),*/
          Divider(
            height: 4,
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _nameMyRoomController.dispose();
    super.dispose();
  }

  void _changeNameMyRoomOnServer(String text, RoomsBloc roomBloc) {
    _nameShowDialog(context, "Atención", cambiandoNombreMyRoom, roomBloc);
  }

  Future _nameShowDialog(BuildContext context, String title, String message, RoomsBloc roomBloc) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.white,
            elevation: 10.0,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
            title: Center(
                child: Text(
              title,
            )),
            content: Text(message, style: TextStyle(fontFamily: fontFamilyText, fontSize: 18.0)),
            actions: [
              FlatButton(
                child: Text("Cancelar", style: TextStyle(fontFamily: fontFamilyText, fontSize: 18.0, color: Colors.blueAccent)),
                onPressed: () {
                  setState(() {
                    _isSelected = false;
                  });
                  Navigator.pop(context);
                },
              ),
              FlatButton(
                child: Text("Ok", style: TextStyle(fontFamily: fontFamilyText, fontSize: 18.0, color: Colors.blueAccent)),
                onPressed: () {
                 /* setState(() {
                    _isSelected = true;
                  });*/
                  roomBloc.changeNameMyRoomOnServer(_myroom.uid.trim(), _nameMyRoomController.text, currentUser.uid);
                  print(_nameMyRoomController.text);
                  Navigator.pop(context);
                },
              )
            ],
          );
        });
  }
}
