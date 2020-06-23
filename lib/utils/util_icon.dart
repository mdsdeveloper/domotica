

import 'package:flutter/material.dart';
import 'package:flutterappdomotica/custom_icons.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

IconData IconFromIconName(String roomName){
  switch(roomName){
    case "CustomIcons.sofa"           : return CustomIcons.sofa;
    case "CustomIcons.comedor"        : return CustomIcons.comedor;
    case "CustomIcons.cocina"         : return CustomIcons.cocina;
    case "CustomIcons.cama"           : return CustomIcons.cama;
    case "CustomIcons.bano"           : return CustomIcons.bano;
    case "CustomIcons.ducha"          : return CustomIcons.ducha;
    case "CustomIcons.sala_estar"     : return CustomIcons.sala_estar;
    case "CustomIcons.despacho"       : return CustomIcons.despacho;
    case "CustomIcons.estudio"        : return CustomIcons.estudio;
    case "CustomIcons.sala_juegos"    : return CustomIcons.sala_juegos;
    case "CustomIcons.jardin"         : return CustomIcons.jardin;
    case "CustomIcons.patio_delantero": return CustomIcons.patio_delantero;
    case "CustomIcons.patio_delantero": return CustomIcons.patio_delantero;
    case "CustomIcons.garaje"         : return CustomIcons.garaje;
    case "CustomIcons.balcon"         : return CustomIcons.balcon;
    case "CustomIcons.terraza"        : return CustomIcons.terraza;
    case "CustomIcons.escalera"       : return CustomIcons.escalera;
    case "Luz techo"                  : return FontAwesomeIcons.lightbulb;
    case "Enchufe"                    :
    case "Enchufe pared"              :
    case "Enchufe tv"                 :
      return FontAwesomeIcons.plug;
    case "Persiana"                   : return FontAwesomeIcons.windowClose;
    default: return Icons.linear_scale;
  }
}