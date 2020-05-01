import 'package:flutter/material.dart';

class CustomRaisedButton extends StatefulWidget {
  String text;
  double marginTop;
  double marginBottom;
  Color color;
  final VoidCallback onPressed;

  CustomRaisedButton({this.text, this.marginTop, this.marginBottom, this.onPressed, this.color});

  @override
  _CustomRaisedButtonState createState() => _CustomRaisedButtonState();
}

class _CustomRaisedButtonState extends State<CustomRaisedButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: widget.marginTop != null ? EdgeInsets.only(top: widget.marginTop) : EdgeInsets.only(bottom: widget.marginBottom),
      child: RaisedButton(
          elevation: 5.0,
          color: widget.color != null? widget.color: null ,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          child: Text(
            widget.text,
            style: TextStyle(
                fontFamily: "Lato",
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Colors.blue),
          ),
          onPressed: widget.onPressed),
    );
  }
}
