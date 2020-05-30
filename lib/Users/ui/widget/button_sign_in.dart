import 'package:flutter/material.dart';

class ButtonSignIn extends StatefulWidget {
  final double height;
  final double width;
  final String text;
  final VoidCallback onPressed;

  ButtonSignIn(
      {Key key, this.width, this.height, @required this.text, this.onPressed});

  @override
  State<StatefulWidget> createState() {
    return _ButtonSignIn();
  }
}

class _ButtonSignIn extends State<ButtonSignIn> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onPressed,
      child: Container(
        margin: EdgeInsets.only(top: 30.0, left: 20.0, right: 20.0),
        height: widget.height,
        width: widget.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: Colors.white,
        ),
        child: Center(
          child: Text(
            widget.text,
            style: TextStyle(
                fontFamily: "Lato",
                fontSize: 28.0,
                color: Colors.blue
            ),
          ),
        ),
      ),
    );
  }
}
