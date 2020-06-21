import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutterappdomotica/Rooms/bloc/rooms_bloc.dart';
import 'package:flutterappdomotica/Rooms/model/my_room.dart';
import 'package:flutterappdomotica/Rooms/model/room_model.dart';
import 'package:flutterappdomotica/Users/bloc/user_bloc.dart';
import 'package:flutterappdomotica/Users/ui/widget/verified_show_dialog.dart';
import 'package:flutterappdomotica/Widget/custom_raised_button.dart';
import 'package:flutterappdomotica/Widget/gradient_back.dart';
import 'package:flutterappdomotica/Widget/title_header.dart';
import 'package:flutterappdomotica/constants.dart';
import 'package:flutterappdomotica/providers/provider.dart';
import 'package:flutterappdomotica/utils/util_icon.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class RoomsPage extends StatefulWidget {
  @override
  _RoomsPageState createState() => _RoomsPageState();
}

class _RoomsPageState extends State<RoomsPage> {
  final _textFieldRoomController = TextEditingController();
  var _selected;
  String _roomsId;
  Icon _iconSelected;
  bool isCleanning = true;
  FirebaseUser _currentuser;

  var _alertDialogController;

  RoomModel _roomModel;

/*  Rooms rooms;
  Room room;
  RoomModel roomModel;

  RoomBloc roomBloc;
  RoomsBloc roomsBloc;
  List<CardRoomNew> newCardList;*/

  @override
  Widget build(BuildContext context) {
    final _roomsBloc = Provider.roomsBloc(context);
    final _userBloc = Provider.userBloc(context);

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
          buildFutureBuilder(_roomsBloc, _userBloc, context),

//          _addRoomsBTN(context),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blueAccent,
        elevation: 20,
        hoverElevation: 30,
        child: Icon(Icons.add, size: 30),
        onPressed: () {
          isCleanning = true;
          _mostrarAlerta(context, _roomsBloc, _userBloc);
        },
      ),
    );
  }

  FutureBuilder buildFutureBuilder(RoomsBloc _roomsBloc, UserBloc _userBloc, BuildContext context) {
    return FutureBuilder(
      future: _userBloc.currentUser,
      builder: (context, snapshot) {
        if (!snapshot.hasError && snapshot.hasData) {
          var allMyRoomsListStream = _roomsBloc.allMyRoomsListStream(snapshot.data);
          _currentuser = snapshot.data;
          return _addGridView(_roomsBloc, _userBloc, allMyRoomsListStream);
        } else if (!snapshot.hasError) {
//          TODO: mejorar este return
          return CircularProgressIndicator();
        } else {
          return null;
        }
      },
    );
  }

  _addGridView(RoomsBloc roomsBloc, UserBloc userBloc, Stream<QuerySnapshot> allMyRoomsListStream) {
    return StreamBuilder<QuerySnapshot>(
      stream: allMyRoomsListStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (!snapshot.hasError) {
          return Container(
            margin: EdgeInsets.only(top: 80, bottom: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Expanded(
                  child: _gridView(snapshot, roomsBloc),
                )
              ],
            ),
          );
        } else {
          return null;
        }
      },
    );
  }

  _buildAppBarRoom() {
    return TitleHeader(
      text: "Habitaciones",
      size: 20.0,
      onPressed: () {},
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

  void _mostrarAlerta(BuildContext context, RoomsBloc roomsBloc, UserBloc userBloc) {
    var allRoomsListSream = roomsBloc.allRoomsListSream();
    showDialog(
      context: context,
      useRootNavigator: true,
      barrierDismissible: false,
      builder: (context) {
        // return alert dialog object
        return AlertDialog(
//          key: _alertDialogController,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          title: Center(child: Text('Añadír Habitación')),
          content: Container(
            height: 120.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Expanded(
                  child: _dropDownList(context, allRoomsListSream, roomsBloc),
                ),
//                SizedBox(height: 10.0,),
                Container(
                  width: 220.0,
                  child: TextField(
                    controller: _textFieldRoomController,
                    keyboardType: TextInputType.text,
                    enabled: false,
                    decoration: InputDecoration(
                      hintText: "Nombre habitación",
                      suffixIcon: _getIcon(roomsBloc),
                    ),
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Cancelar'),
              onPressed: () {
                setState(() {});
                _cleanTextField();
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: Text('Añadir'),
              onPressed: () {
                _addRoomOnList(roomsBloc, userBloc);
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

  Widget _getIcon(RoomsBloc roomsBloc) {
    return Container(
      child: StreamBuilder(
        stream: roomsBloc.iconStream,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return isCleanning ? Icon(null) : snapshot.data;
          } else {
            return Icon(null);
          }
        },
      ),
    );
  }

  void _addRoomOnList(RoomsBloc roomsBloc, UserBloc userBloc) async {
    String userId = _currentuser.uid;
    bool sentRoomToFirestore = true;
    var allMyRoomsListStream = roomsBloc.allMyRoomsListStream(_currentuser);

    allMyRoomsListStream.forEach((element) {
      for (int i = 0; i < element.documents.length; i++) {
        if (element.documents[i].data['uid'].toString().compareTo(_roomsId) == 0) {
          sentRoomToFirestore = false;
          break;
        }
      }

      if (sentRoomToFirestore) {
        roomsBloc.addRoomToUserFirestore(userId, _roomsId, _roomModel);
      }
      return sentRoomToFirestore;
    });
  }

  _dropDownList(BuildContext context, Stream<QuerySnapshot> allRoomsListSream, RoomsBloc roomsBloc) {
    var screenSize = MediaQuery.of(context).size;
    return StreamBuilder<QuerySnapshot>(
        stream: allRoomsListSream,
        builder: (context, snapshot) {
          if (!snapshot.hasData)
            return const Center(
              child: const CupertinoActivityIndicator(),
            );
          return new Container(
            padding: EdgeInsets.only(bottom: 0.0),
            width: screenSize.width * 0.7,
            child: new Row(
              children: <Widget>[
                Expanded(
                  flex: 5,
                  child: InputDecorator(
                    textAlign: TextAlign.left,
                    decoration: const InputDecoration(
                      border: UnderlineInputBorder(borderSide: BorderSide.none),
                      hintText: 'Selecciona habitación',
                      hintStyle: TextStyle(
                        fontSize: 16.0,
                        fontFamily: "Lato",
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    isEmpty: _selected == null,
                    child: DropdownButton<DocumentSnapshot>(
                      underline: Container(
                        height: 1,
                        color: Colors.transparent,
                        margin: EdgeInsets.only(top: 5.0, bottom: 5.0),
                      ),
                      value: _selected,
                      isDense: true,
                      isExpanded: true,
                      iconSize: 50,
                      elevation: 16,
                      iconEnabledColor: Colors.blueAccent,
                      onChanged: (DocumentSnapshot document) {
                        setState(() {
                          isCleanning = false;
                          print(document.data['icon']);
                          _selected = document;
                          _roomsId = document.data['uid'];
                          _textFieldRoomController.text = document.data['name'];
                          _iconSelected = Icon(IconFromIconName(document.data['icon']), size: 50, color: Colors.black);
                          roomsBloc.changeIcon(_iconSelected);
                          _roomModel = _buildRoomModel(document.data, roomsBloc);
                          print(_roomModel);
                        });
                      },
                      items: snapshot.data.documents.map((DocumentSnapshot document) {
                        return DropdownMenuItem<DocumentSnapshot>(
                          value: document,
                          child: Text(document.data['name']),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }

  void _cleanTextField() {
    _textFieldRoomController.clear();
    _iconSelected = null;
    isCleanning = true;
    _selected = null;
//    _roomsId = null;
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

  RoomModel _buildRoomModel(Map<String, dynamic> data, RoomsBloc roomsBloc) {
    RoomModel roomModel = RoomModel.fromJson(data);
    roomsBloc.addRoomModel(roomModel);

    return roomModel;
  }

  Widget _gridView(AsyncSnapshot<dynamic> snapshot, RoomsBloc roomsBloc) {
    if (!snapshot.hasData && snapshot.data == null) {
      return Center(child: CircularProgressIndicator());
    } else {
      return GridView.builder(
        itemCount: snapshot.data != null ? snapshot.data.documents.length == null ? 0 : snapshot.data.documents.length : 0,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (BuildContext context, int index) {
          DocumentSnapshot document = snapshot.data.documents[index];

          if (document['name'] == null) {
//            TODO: arreglar esto
            return Text("ko");
          } else {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: cardRoomWidget(document),
            );
          }
        },
      );
    }
  }

  cardRoomWidget(document) {
    var myRoom = MyRoom.fromDocumentSnapshot(document);
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, roomDetailsPage, arguments: myRoom);
      },
      child: Hero(
        tag: myRoom.uid,
        child: Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
          color: Colors.white,
          child: Container(
            child: Container(
              alignment: Alignment.center,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Flexible(
                    child: _showImage(myRoom),
                  ),
                  Container(
//                padding: EdgeInsets.all(10.0),
                    child: Text(
                      _addNameRoom(myRoom.name),
                      softWrap: true,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.clip,
                      style: TextStyle(fontSize: 18.0, fontFamily: fontFamilyText, fontWeight: FontWeight.w500),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  String _addNameRoom(String name) => name.isNotEmpty ? name : "Habitación";

  Widget _showImage(MyRoom myroom) {
    Widget dev;
    if (myroom.icon.isNotEmpty) {
      if (myroom.uriImage.isNotEmpty) {
        dev = ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: FadeInImage(
              placeholder: AssetImage(getAssetImage(myroom)),
              image: AssetImage(getAssetImage(myroom)),
            ));
      } else {
        dev = getIconRoom(myroom);
      }
    } else {
      dev = Container(
        padding: EdgeInsets.only(bottom: 10.0),
        child: Text(
          "Sin habitacion",
          style: TextStyle(fontFamily: "Lato", fontWeight: FontWeight.bold, fontSize: 30.0),
        ),
      );
    }
    return dev;
  }

  Icon getIconRoom(MyRoom myroom) {
    return Icon(
      IconFromIconName(myroom.icon),
      size: 50,
      color: Colors.black,
    );
  }

  getAssetImage(MyRoom myroom) {
    return myroom.uriImage.isNotEmpty ? myroom.uriImage : pathSofa;
  }
}
