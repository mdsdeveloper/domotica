import 'package:flutter/cupertino.dart';
import 'package:flutterappdomotica/Devices/bloc/devices_bloc.dart';
import 'package:flutterappdomotica/Rooms/bloc/rooms_bloc.dart';
import 'package:flutterappdomotica/Users/bloc/login_bloc.dart';
import 'package:flutterappdomotica/Users/bloc/user_bloc.dart';
export 'package:flutterappdomotica/Users/bloc/login_bloc.dart';

class Provider extends InheritedWidget {
  static Provider _instancia;
  LoginBloc _loginBloc      = LoginBloc();
  UserBloc _userBloc        = UserBloc();
  RoomsBloc _roomsBloc      = RoomsBloc();
  DevicesBloc _devicesBloc  = DevicesBloc();

  Provider._internal({Key key, Widget child})
  :super(key: key,child: child);

  factory Provider({Key key, Widget child}) {
    if(_instancia == null){
      _instancia = Provider._internal(key: key, child: child);
    }
    return _instancia;
  }


  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  static LoginBloc loginBloc(BuildContext context){
    return context.dependOnInheritedWidgetOfExactType<Provider>()._loginBloc;
  }
  static UserBloc userBloc(BuildContext context){
    return context.dependOnInheritedWidgetOfExactType<Provider>()._userBloc;
  }
  static RoomsBloc roomsBloc(BuildContext context){
    return context.dependOnInheritedWidgetOfExactType<Provider>()._roomsBloc;
  }

  static DevicesBloc devicesBloc(BuildContext context){
    return context.dependOnInheritedWidgetOfExactType<Provider>()._devicesBloc;
  }

}
