import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class TitleHeader extends StatelessWidget {
  final String text;
  final double size;

  TitleHeader({Key key, @required this.text, @required this.size});

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
          Expanded(child: SizedBox()),
          Container(
            padding: EdgeInsets.only(top: 30.0, right: 50.0),
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
          Expanded(child: SizedBox()),
        ],
      ),
    );
  }
}

