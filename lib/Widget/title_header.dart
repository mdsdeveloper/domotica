import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class TitleHeader extends StatelessWidget {
  final String text;
  final double size;
  final Widget circleAvatar;
  final VoidCallback onPressed;

  TitleHeader(
      {Key key,
      @required this.text,
      @required this.size,
      this.circleAvatar,
      this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topCenter,
      child: Row(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(top: 35.0, left: 5.0),
            child: SizedBox(
              height:  45.0,
              width: 45.0,
              child: onPressed != null ? IconButton(
                  icon: Icon(Icons.arrow_back, color: Colors.white, size: 25),
                  onPressed:  () => Navigator.of(context).pop()): null,
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.only(top: 30.0, right: onPressed != null ? 50.0 : 0),
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
          Container(
            padding: EdgeInsets.only(top: 35.0, left: 5.0),
            child: SizedBox(
              height: 45.0,
              width: 45.0,
              child: onPressed == null ? IconButton(
                  icon: Icon(Icons.clear, color: Colors.white, size: 25),
                  onPressed:  () => Navigator.of(context).pop()): null,
            ),
          ),
//          circleAvatar != null ? _addCircleAvatar() : SizedBox(),
        ],
      ),
    );
  }
  }
