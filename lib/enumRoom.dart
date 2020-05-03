import 'package:flutter/material.dart';
import 'package:flutterappdomotica/custom_icons.dart';

enum EnumRoom {
  salon, comedor, cocina, dormitorio, bano, lavabo, cuarto, despacho, estudio
  ,sala, jardin, patioTrasero, patioDelantero, garage, balcon, atico, escalera }

  String typesOfRoom(EnumRoom room){
    switch(room){
      case EnumRoom.salon: return "Salón";
      case EnumRoom.comedor: return "Comedor";
      case EnumRoom.cocina: return "Cocina";
      case EnumRoom.dormitorio: return "Dormitorio";
      case EnumRoom.bano: return "Baño";
      case EnumRoom.lavabo: return "Lavabo";
      case EnumRoom.cuarto: return "Cuarto de estar";
      case EnumRoom.despacho: return "Despacho";
      case EnumRoom.estudio: return "Estudio";
      case EnumRoom.sala: return "Sala de juegos";
      case EnumRoom.jardin: return "Jardín";
      case EnumRoom.patioTrasero: return "Patio trasero";
      case EnumRoom.patioDelantero: return "Patio delantero";
      case EnumRoom.garage: return "Garage";
      case EnumRoom.balcon: return "Balcón";
      case EnumRoom.atico: return "Ático";
      case EnumRoom.escalera: return "Escalera";
    }
  }

  IconData iconFromRoom(EnumRoom room){
      switch(room){
        case EnumRoom.salon: return CustomIcons.sofa;
        case EnumRoom.comedor: return CustomIcons.comedor;
        case EnumRoom.cocina: return CustomIcons.cocina;
        case EnumRoom.dormitorio: return CustomIcons.cama;
        case EnumRoom.bano: return CustomIcons.bano;
        case EnumRoom.lavabo: return CustomIcons.ducha;
        case EnumRoom.cuarto: return CustomIcons.sala_estar;
        case EnumRoom.despacho: return CustomIcons.despacho;
        case EnumRoom.estudio: return CustomIcons.estudio;
        case EnumRoom.sala: return CustomIcons.sala_juegos;
        case EnumRoom.jardin: return CustomIcons.jardin;
        case EnumRoom.patioTrasero: return CustomIcons.patio_delantero;
        case EnumRoom.patioDelantero: return CustomIcons.patio_delantero;
        case EnumRoom.garage: return CustomIcons.garaje;
        case EnumRoom.balcon: return CustomIcons.balcon;
        case EnumRoom.atico: return CustomIcons.terraza;
        case EnumRoom.escalera: return CustomIcons.escalera;

      }
  }


