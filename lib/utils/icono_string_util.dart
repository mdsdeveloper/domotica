import 'package:flutter/material.dart';

final _icons = <String, IconData>{
  "lightbulb_outline":Icons.lightbulb_outline,
  "comment": Icons.comment,
  "view_day": Icons.view_day,
};

Icon getIcon({String IconName, Color color, double iconSize}){
  return Icon(_icons[IconName],color: color != null ? color : Colors.blue, size: iconSize);
}