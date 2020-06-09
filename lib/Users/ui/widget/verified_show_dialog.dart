import 'package:flutter/material.dart';
import 'package:flutterappdomotica/constants.dart';

Future LoginShowDialog(BuildContext context, String title, String message, String goToPage) {
  return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          elevation: 10.0,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0)),
          title: Center(child: Text(title)),
          content: Text(message,
              style:
              TextStyle(fontFamily: fontFamilyText, fontSize: 18.0)),
          actions: [
            FlatButton(
              child: Text("Ok",
                  style: TextStyle(
                      fontFamily: fontFamilyText,
                      fontSize: 18.0,
                      color: Colors.blueAccent)),
              onPressed: () =>
                  Navigator.pushReplacementNamed(context, goToPage),
            )
          ],
        );
      });
}