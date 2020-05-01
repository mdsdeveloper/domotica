import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterappdomotica/Rooms/model/room.dart';
import 'package:flutterappdomotica/constants.dart';

class CardCreateRoom extends StatefulWidget {
  final Room room;
  final String pathImage;

  CardCreateRoom({this.room, this.pathImage});

  @override
  _CardCreateRoomState createState() => _CardCreateRoomState();
}

class _CardCreateRoomState extends State<CardCreateRoom> {
  @override
  Widget build(BuildContext context) {
    return Card(
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
                child: _showImage(),
              ),
              Container(
//                padding: EdgeInsets.all(10.0),
                child: Text(
                  _addNameRoom(),
                  softWrap: true,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.clip,
                  style: TextStyle(
                      fontSize: 18.0,
                      fontFamily: fontFamilyText,
                      fontWeight: FontWeight.w500),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  String _addNameRoom() => widget.room != null && widget.room.name.isNotEmpty
      ? widget.room.name
      : "Habitación";

  Widget _showImage() {
    Widget dev;
    if (widget.room.iconRoom != null) {
      if (widget.pathImage != null) {
        dev = ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: FadeInImage(
              placeholder: AssetImage(
                  widget.pathImage != null ? widget.pathImage : pathSofa),
              image: AssetImage(
                  widget.pathImage != null ? widget.pathImage : pathSofa),
            ));
      } else {
        dev = widget.room.iconRoom;
      }
    } else {
      print(this.widget.room.id);
      dev = Container(
        padding: EdgeInsets.only(bottom: 10.0),
        child: Text(
          widget.room.id.toString(),
          style: TextStyle(
              fontFamily: "Lato", fontWeight: FontWeight.bold, fontSize: 30.0),
        ),
      );
      counterRooms++;
    }
    return dev;
  }
  @override
  void dispose() {
    super.dispose();
  }
}

List<CardCreateRoom> cardList;

