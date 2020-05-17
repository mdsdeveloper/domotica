import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutterappdomotica/Rooms/model/device.dart';
import 'package:flutterappdomotica/Rooms/model/room.dart';
import 'package:flutterappdomotica/Rooms/ui/widget/card_room_create.dart';
import 'package:flutterappdomotica/Rooms/ui/widget/room_device_widget.dart';
import 'package:flutterappdomotica/custom_icons.dart';
import 'package:flutterappdomotica/utils/key_value.dart';

const String pathLogo = "assets/images/logo1.jpg";
const String pathSofa = "assets/images/sofa.jpg";
const String pathBombillaEncendida = "assets/images/bombilla-encendida.jpg";
const String pathBombillaEncendida1 = "assets/images/bombilla-encendida-1.png";
const String pathBombillaApagada = "assets/images/bombilla-apagada.png";





// nombre de páginas

const String pantallaRegistrar = 'accountScreen';
const String pantallaLogin = 'loginScreen';


// Textos de botones

const String registrarBtn = 'Registrarse';
const String iniciarSesionBtn = 'Iniciar sesión';

// Textos de páginas
const String tituloInicioApp = 'Bienvenid@';
const String nombreAppText = 'Tu Domotica';


// Fuente

const String fontFamilyText = 'Lato';

// habitaciones
int idRoom = 0;
List<Room> roomList;
int counterRooms = 0;
List<CardRoomCreate> cardList;


// Devices
List<Widget> listDevice;
int idDevice = 0;
//Device device = new Device();

