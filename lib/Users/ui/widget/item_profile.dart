import 'package:flutter/material.dart';

class ItemProfile extends StatefulWidget {
  String text;
  IconData iconData;
  final VoidCallback onPressed;

  ItemProfile(
      {@required this.text, @required this.iconData, @required this.onPressed});

  @override
  _ItemProfileState createState() => _ItemProfileState();
}

class _ItemProfileState extends State<ItemProfile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30.0),
            color: Colors.white,
            border: Border.all(color: Colors.indigo)),
        child: ListTile(
          title: Text(widget.text),
          trailing: Icon(Icons.arrow_forward_ios, color: Colors.indigo, size: 15,),
          leading: Icon(widget.iconData, color: Colors.indigo),
          onTap: widget.onPressed,
        ));
  }
}
