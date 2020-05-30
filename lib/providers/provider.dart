import 'package:flutter/cupertino.dart';
import 'package:flutterappdomotica/Users/bloc/login_bloc.dart';
export 'package:flutterappdomotica/Users/bloc/login_bloc.dart';

class Provider extends InheritedWidget {
  static Provider _instancia;
  LoginBloc _loginBloc = LoginBloc();

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

}
