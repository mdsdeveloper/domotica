

import 'package:flutterappdomotica/Devices/model/device_model.dart';

const String pathLogo                = "assets/images/logo1.jpg";
const String pathSofa                = "assets/images/sofa.jpg";
const String pathBombillaEncendida   = "assets/images/bombilla-encendida.jpg";
const String pathBombillaEncendida1  = "assets/images/bombilla-encendida-1.png";
const String pathBombillaApagada     = "assets/images/bombilla-apagada.png";





// nombre de páginas

const String registerPage      = 'registerPage';
const String loginPage         = 'loginPage';
const String initPage          = '/';
const String policyPage        = 'policyPage';
const String termsPage         = 'termsPage';
const String homePage          = 'homePage';
const String profilePage       = 'profilePage';
const String roomsPage         = 'roomsPage';
const String settingPage       = 'settingPage';
const String roomDetailsPage   = 'RoomDetailsPage';

// Textos de botones

const String registrarBtn     = 'Registrarse';
const String iniciarSesionBtn = 'Iniciar sesión';

// Textos de páginas
const String tituloInicioApp = 'Bienvenid@';
const String nombreAppText   = 'Tu Domótica';
const loginText              = "LOGIN";
const registerAccountText    = "Crear cuenta";


// Fuente

const String fontFamilyText = 'Lato';

// Textos
const usuarioExiste        = "Este usuario ya está registrado";
const verificarEmail       = "Te hemos enviado un email de verificación";
const resetPassword        = "Te hemos enviado un email para reestablecer la contraseña";
const resetPasswordError   = "Error al enviar el email, el usuario no existe";
const registrarUsuario     = "El usuario no existe, por favor registre el usuario";
const loginError           = "El usuario o la contraseña son incorrectos";
const roomsErrorGetRooms   = "Ha ocurrido un error al traer todas las habitaciones";
const devicesErrorGetDevices   = "Ha ocurrido un error al cargar los dispositivos de la habitación";
const myroomsErrorGetmyrooms   = "Ha ocurrido un error al cargar tus habitaciones";

List<DeviceModel> listDeviceModel = List();
List<String> listaUIDs = List();

