import 'package:flutter/material.dart';
import 'package:flutterappdomotica/Widget/gradient_back.dart';
import 'package:flutterappdomotica/Widget/title_header.dart';

class ScenarioScreen extends StatefulWidget {
  @override
  _ScenarioScreenState createState() => _ScenarioScreenState();
}

class _ScenarioScreenState extends State<ScenarioScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          GradientBack(height: null),
          _buildAppBarScenario()
        ],
      ),
    );
  }

  Widget _buildAppBarScenario() {
    return TitleHeader(
      text: "Escenario",
      size: 20.0,
    );
  }
}
