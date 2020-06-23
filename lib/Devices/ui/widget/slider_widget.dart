import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterappdomotica/Devices/model/device_model.dart';
import 'package:flutterappdomotica/constants.dart';
import 'package:flutterappdomotica/providers/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SliderWidget extends StatefulWidget {
  DeviceModel device;

  SliderWidget(this.device);

  @override
  _SliderWidgetState createState() => _SliderWidgetState();
}

class _SliderWidgetState extends State<SliderWidget> {
  @override
  Widget build(BuildContext context) {
    final _devicesBloc = Provider.devicesBloc(context);
    return Container(
      margin: EdgeInsets.only(top: 10.0, right: 5.0, left: 5.0),
//      color: Colors.lightBlueAccent,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: <BoxShadow>[BoxShadow(blurRadius: 3.0, offset: Offset(0.0, 3.0))],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(height: 80, width: 80, child: buildIcon()),
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                widget.device.name,
                style: TextStyle(fontFamily: fontFamilyText, color: Colors.black, fontSize: 20.0),
              ),
            ),
            SizedBox(
              width: 250,
              child: Slider(
                activeColor: Colors.blueAccent,
                inactiveColor: Colors.grey,
                label: widget.device.name + " al " + widget.device.value.toString() + " %",
                divisions: 4,
                onChanged: (valor) {
                  if (this.mounted) {
                    setState(() {
                      widget.device.value = valor.toInt();
                    });
                    _devicesBloc.changeDeviceValue(widget.device.uid, widget.device.value);
                  }
                },
                value: widget.device.value.toDouble(),
                min: 0.0,
                max: 100.0,
              ),
            ),
          ]),
        ],
      ),
    );

    /*Container(
      margin: EdgeInsets.only(top: 10.0, right: 5.0, left: 5.0),
//      color: Colors.lightBlueAccent,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: <BoxShadow>[BoxShadow(blurRadius: 3.0, offset: Offset(0.0, 3.0))],
      ),
      child: ListTile(
        title: Container(
          margin: EdgeInsets.only(left: 52.0),
          child: Text(
            widget.device.name,
            style: TextStyle(fontFamily: fontFamilyText, color: Colors.black, fontSize: 20.0),
          ),
        ),
        subtitle: Container(
          padding: EdgeInsets.only(bottom: 18.0),
          child: Slider(
            activeColor: Colors.blueAccent,
            inactiveColor: Colors.grey,
            label: widget.device.name + " al " + widget.device.value.toString() + " %",
            divisions: 4,
            onChanged: (valor) {
              if (this.mounted) {
                setState(() {
                  widget.device.value = valor.toInt();
                });
                _devicesBloc.changeDeviceValue(widget.device.uid, widget.device.value);
              }
            },
            value: widget.device.value.toDouble(),
            min: 0.0,
            max: 100.0,
          ),
        ),
        leading: Container( height: 100, width: 100, child: buildIcon()),
      ),
    );*/
  }

  Icon buildIcon() {
    return Icon(
      Icons.check_box_outline_blank,
      size: 80,
    );
  }
}
