import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutterappdomotica/Devices/bloc/devices_bloc.dart';
import 'package:flutterappdomotica/Devices/model/device_model.dart';
import 'package:flutterappdomotica/constants.dart';
import 'package:flutterappdomotica/providers/provider.dart';
import 'package:flutterappdomotica/utils/util_icon.dart';

class TileWidget extends StatefulWidget {
  final DeviceModel deviceModel;

  TileWidget(this.deviceModel);

  @override
  _TileWidgetState createState() => _TileWidgetState();
}

class _TileWidgetState extends State<TileWidget> {
  bool _isOn;
  bool isOnOffDevice;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (_isOn == null) {
      _isOn = widget.deviceModel.status;
    }
  }

  @override
  Widget build(BuildContext context) {
    final devicesBloc = Provider.devicesBloc(context);

    return ListTile(
      title: Center(
        child: Text(
          widget.deviceModel.name,
          style: TextStyle(fontFamily: fontFamilyText, color: Colors.black, fontSize: 20.0),
        ),
      ),
      contentPadding: EdgeInsets.only(top: 10.0, bottom: 10.0, right: 10.0, left: 10.0),
//                subtitle:Center(child: Text(deviceModel.uid, style: TextStyle(fontFamily: fontFamilyText, color: Colors.black38))),
      leading: getIcon(),
      trailing: Container(width: 80.0, child: _buildButtonOnOffDevice(widget.deviceModel, devicesBloc, context)),
      dense: false,
      onTap: () {
        setState(() {
          _isOn = !_isOn;
          devicesBloc.changeStatusValue(widget.deviceModel.uid, _isOn);
          if (_isOn) {
            _onPressedFav(context, widget.deviceModel);
          }
        });
      },
    );
  }

  Icon getIcon() {
    if (widget.deviceModel.name.contains("Puerta")) {
      return Icon(
        _isOn ? IconFromIconName("CustomIcons.doorOpen") : IconFromIconName(widget.deviceModel.name),
        color: _isOn ? Colors.green : Colors.red,
        size: 30,
      );
    } else {
      return Icon(
        IconFromIconName(widget.deviceModel.name),
        color: _isOn ? Colors.green : Colors.red,
        size: 30,
      );
    }
  }

  Widget _buildButtonOnOffDevice(DeviceModel deviceModel, DevicesBloc devicesBloc, BuildContext context) {
    return Switch(
      value: _isOn,
      inactiveTrackColor: Colors.grey,
      inactiveThumbColor: Colors.blueAccent,
      activeTrackColor: Colors.green,
      activeColor: Colors.white,
      onChanged: (value) {
        setState(() {
          _isOn = !_isOn;
          devicesBloc.changeStatusValue(deviceModel.uid, _isOn);
          if (_isOn) {
            _onPressedFav(context, deviceModel);
          }
        });
      },
    );
  }

  void _onPressedFav(BuildContext context, DeviceModel deviceModel) {
    Flushbar(
      duration: Duration(milliseconds: 900),
      borderRadius: 10.0,
      /*backgroundGradient: LinearGradient(
        colors: [Color(0xFF4268D3), Color(0xFF584CD1)],
        stops: [1, 0.5],
      ),*/
      boxShadows: [
        BoxShadow(
          color: Colors.black45,
          offset: Offset(3, 3),
          blurRadius: 5,
        ),
      ],
      padding: EdgeInsets.only(left: 30, top: 5.0, bottom: 5.0),
      titleText: Text(
        "Has añadido: " + deviceModel.name,
        style: TextStyle(
          fontSize: 18.0,
          fontFamily: "Lato",
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
//      forwardAnimationCurve: Curves.fastLinearToSlowEaseIn,
      forwardAnimationCurve: Curves.fastOutSlowIn,
      animationDuration: Duration(milliseconds: 900),
      icon: Icon(
        IconFromIconName(deviceModel.name),
        color: Colors.green,
        size: 30,
      ),
      flushbarStyle: FlushbarStyle.FLOATING,
      margin: EdgeInsets.only(bottom: 200, left: 8.0, right: 8.0),
      dismissDirection: FlushbarDismissDirection.HORIZONTAL,
      messageText: Text(
        deviceModel.roomName,
        style: TextStyle(
          fontSize: 18.0,
          fontFamily: "Lato",
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    )..show(context);
  }
}
