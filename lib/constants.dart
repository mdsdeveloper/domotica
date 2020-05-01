import 'package:flutter/material.dart';
import 'package:flutterappdomotica/Rooms/model/room.dart';
import 'package:flutterappdomotica/Rooms/ui/widget/card_create_room.dart';
import 'package:flutterappdomotica/custom_icons.dart';
import 'package:flutterappdomotica/utils/key_value.dart';

const String pathLogo = "assets/images/logo1.jpg";
const String pathSofa = "assets/images/sofa.jpg";



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