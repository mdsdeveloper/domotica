import 'package:flutter/material.dart';
import 'package:flutterappdomotica/custom_icons.dart';

enum EnumDevice {
    luz, persiana, ventana, cortina, puerta, porton, portillo, farola, dimmer
  ,humo, agua, enchufe, cristal, gas, temperatura, humedad, fotoElectrico }

  String typesOfRoom(EnumDevice device){
    switch(device){
      case EnumDevice.luz: return "Luz";
      case EnumDevice.persiana: return "Persiana";
      case EnumDevice.ventana: return "Ventana";
      case EnumDevice.cortina: return "Cortina";
      case EnumDevice.puerta: return "Puerta";
      case EnumDevice.porton: return "Porton";
      case EnumDevice.portillo: return "Portilla";
      case EnumDevice.farola: return "Farola";
      case EnumDevice.dimmer: return "Dimmer";
      case EnumDevice.humo: return "Humo";
      case EnumDevice.agua: return "Agua";
      case EnumDevice.enchufe: return "Enchufe";
      case EnumDevice.cristal: return "Cristal";
      case EnumDevice.gas: return "Gas";
      case EnumDevice.temperatura: return "Temperatura";
      case EnumDevice.humedad: return "Humedad";
      case EnumDevice.fotoElectrico: return "Foto eléctico";
    }
  }

  IconData iconFromRoom(EnumDevice device){
      switch(device){
        case EnumDevice.luz: return CustomIcons.sofa;
        case EnumDevice.persiana: return CustomIcons.comedor;
        case EnumDevice.ventana: return CustomIcons.cocina;
        case EnumDevice.cortina: return CustomIcons.cama;
        case EnumDevice.puerta: return CustomIcons.bano;
        case EnumDevice.porton: return CustomIcons.ducha;
        case EnumDevice.portillo: return CustomIcons.sala_estar;
        case EnumDevice.farola: return CustomIcons.despacho;
        case EnumDevice.dimmer: return CustomIcons.estudio;
        case EnumDevice.humo: return CustomIcons.sala_juegos;
        case EnumDevice.agua: return CustomIcons.jardin;
        case EnumDevice.enchufe: return CustomIcons.patio_delantero;
        case EnumDevice.cristal: return CustomIcons.patio_delantero;
        case EnumDevice.gas: return CustomIcons.garaje;
        case EnumDevice.temperatura: return CustomIcons.balcon;
        case EnumDevice.humedad: return CustomIcons.terraza;
        case EnumDevice.fotoElectrico: return CustomIcons.escalera;

      }
  }


