import 'package:flutter/material.dart';
import 'package:flutterappdomotica/Rooms/model/room.dart';
import 'package:flutterappdomotica/Widget/custom_raised_button.dart';
import 'package:flutterappdomotica/Widget/gradient_back.dart';
import 'package:flutterappdomotica/Widget/title_header.dart';

class RoomDetails extends StatefulWidget {
  final Room room;

  RoomDetails({@required this.room});

  @override
  _RoomDetailsState createState() => _RoomDetailsState();
}

class _RoomDetailsState extends State<RoomDetails> {
  @override
  Widget build(BuildContext context) {
//    final Room args = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF4268D3),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
            size: 25,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Container(
          alignment: Alignment.centerLeft,
//          padding: const EdgeInsets.only(left: 30),
          child: Text(
            widget.room != null && widget.room.name.isNotEmpty
                ? widget.room.name
                : "Habitación",
          ),
        ),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.edit), onPressed: () {}),
          IconButton(
              icon: Icon(Icons.menu),
              onPressed: () {
                //
              }),
        ],
      ),
      body:
/*      Hero(
        tag: widget.room != null && widget.room.name.isNotEmpty
            ? widget.room.name
            : "Habitación",
        child: */
          Stack(
        children: <Widget>[
          GradientBack(height: null),
//            _buildAppBarRoomDetails(),
//            _addRoomsBTN(context),
          _buildHero(),
        ],
      ),
//      ),
    );
  }

  Widget _buildAppBarRoomDetails() {
    return TitleHeader(
      text: widget.room != null
          ? widget.room.name
          : "Habitación ${widget.room.id}",
      size: 20.0,
    );
  }

//  Widget _addRoomsBTN(BuildContext context) {
//    return Container(
//        alignment: Alignment.bottomCenter,
//        padding: EdgeInsets.only(
//          right: 10.0,
//          left: 10.0,
//        ),
//        child: CustomRaisedButton(
//          text: "Añadir dispositivo",
//          onPressed: () {},
//          marginBottom: 10.0,
//          color: Colors.grey,
//        ));
//  }

  Widget _buildHero() {
    return Hero(
      tag: widget.room != null && widget.room.name.isNotEmpty
          ? widget.room.name
          : "Habitación",
      child: Container(
//        margin: EdgeInsets.only(top: 80, bottom: 50),
        child: ListView(
/*        mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,*/
          children: _addDevices(),
        ),
      ),
    );
  }

  List<Widget> _addDevices() {
    return <Widget>[
      Container(
        color: Colors.white,
        child: ListTile(
          title: Text('Luz techo'),
          trailing: Icon(Icons.keyboard_arrow_right, color: Colors.blue),
          onTap: () {},
        ),
      ),
    ];
  }
}
