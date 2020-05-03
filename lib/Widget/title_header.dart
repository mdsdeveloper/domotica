import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class TitleHeader extends StatelessWidget {
  final String text;
  final double size;
  final Widget circleAvatar;

  TitleHeader(
      {Key key,
      @required this.text,
      @required this.size,
      @required this.circleAvatar});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topCenter,
      child: Row(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(top: 35.0, left: 5.0),
            child: SizedBox(
              height: 45.0,
              width: 45.0,
              child: IconButton(
                  icon: Icon(Icons.arrow_back, color: Colors.white, size: 25),
                  onPressed: () => Navigator.pop(context)),
            ),
          ),
//          Expanded(child: SizedBox()),
          Expanded(
            child: Container(
              padding: EdgeInsets.only(top: 30.0, right: 0.0),
              child: Text(
                text,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontFamily: "Lato",
                    fontSize: size,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
          ),
          _addCircleAvatar(),
        ],
      ),
    );
  }

  Widget _addCircleAvatar() {
    return Container(
      padding: EdgeInsets.only(top: 30.0, right: 10.0),
      child: CircleAvatar(
        backgroundImage: NetworkImage(
            'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcR0AwFd9jyAXxAC3w5HoMhD-HrxMoLE5SMx4FrcNAiWClgy42D1&usqp=CAU'),
        radius: 25.0,
      ),
    );
  }
}
