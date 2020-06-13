

import 'package:flutter/material.dart';
import 'package:flutterappdomotica/custom_icons.dart';

IconData iconFromRoom(String roomName){
  switch(roomName){
    case "Salón"          : return CustomIcons.sofa;
    case "Comedor"        : return CustomIcons.comedor;
    case "Cocina"         : return CustomIcons.cocina;
    case "Dormitorio"     : return CustomIcons.cama;
    case "Baño"           : return CustomIcons.bano;
    case "Lavabo"         : return CustomIcons.ducha;
    case "SalaEstar"      : return CustomIcons.sala_estar;
    case "Despacho"       : return CustomIcons.despacho;
    case "Estudio"        : return CustomIcons.estudio;
    case "SalaJuegos"     : return CustomIcons.sala_juegos;
    case "Jardin"         : return CustomIcons.jardin;
    case "PatioTrasero"   : return CustomIcons.patio_delantero;
    case "PatioDelantero" : return CustomIcons.patio_delantero;
    case "Garage"         : return CustomIcons.garaje;
    case "Balcon"         : return CustomIcons.balcon;
    case "Atico"          : return CustomIcons.terraza;
    case "Escalera"       : return CustomIcons.escalera;
    default: return Icons.linear_scale;
  }
}