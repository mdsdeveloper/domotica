import 'package:flutter/cupertino.dart';

class Provider extends InheritedWidget {
  static Provider _instancia;

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

}
