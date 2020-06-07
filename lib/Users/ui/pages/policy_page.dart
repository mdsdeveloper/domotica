import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterappdomotica/Widget/gradient_back.dart';
import 'package:flutterappdomotica/Widget/title_header.dart';
import 'package:flutterappdomotica/constants.dart';

class PolicyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          GradientBack(height: null),
          _buildAppBarPolicy(context),
          _buildContainer(),
        ],
      ),
    );
  }

  Widget _buildContainer() {
    return Container(
      margin: EdgeInsets.only(top: 90.0),
      child: ListView(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(8.0),
            color: Colors.white,
            margin: EdgeInsets.only(left: 10.0, right: 10.0),
            child: Text.rich(
              TextSpan(
                  text: "Lorem Ipsum es simplemente el texto de relleno "
                      "de las imprentas y archivos de texto. "
                      "Lorem Ipsum ha sido el texto de relleno estándar de las industrias desde"
                      " el año 1500, cuando un impresor (N. del T. persona que se dedica a la imprenta) "
                      "desconocido usó una galería de textos y los mezcló de tal manera que logró hacer"
                      " un libro de textos especimen. No sólo sobrevivió 500 años, "
                      "sino que tambien ingresó como texto de relleno en documentos electrónicos, quedando esencialmente igual al original. "
                      "Fue popularizado en los 60s con la creación de las hojas Letraset, "
                      "las cuales contenian pasajes de Lorem Ipsum, y más recientemente con software de "
                      "autoedición, como por ejemplo Aldus PageMaker, el cual incluye versiones de Lorem Ipsum."
                      "Lorem Ipsum es simplemente el texto de relleno "
                      "de las imprentas y archivos de texto. "
                      "Lorem Ipsum ha sido el texto de relleno estándar de las industrias desde"
                      " el año 1500, cuando un impresor (N. del T. persona que se dedica a la imprenta) "
                      "desconocido usó una galería de textos y los mezcló de tal manera que logró hacer"
                      " un libro de textos especimen. No sólo sobrevivió 500 años, "
                      "sino que tambien ingresó como texto de relleno en documentos electrónicos, quedando esencialmente igual al original. "
                      "Fue popularizado en los 60s con la creación de las hojas Letraset, "
                      "las cuales contenian pasajes de Lorem Ipsum, y más recientemente con software de "
                      "autoedición, como por ejemplo Aldus PageMaker, el cual incluye versiones de Lorem Ipsum.",
                  children: [
                    TextSpan(
                        text:
                            "----Lorem Ipsum es simplemente el texto de relleno "
                            "de las imprentas y archivos de texto. "
                            "Lorem Ipsum ha sido el texto de relleno estándar de las industrias desde"
                            " el año 1500, cuando un impresor (N. del T. persona que se dedica a la imprenta) "
                            "desconocido usó una galería de textos y los mezcló de tal manera que logró hacer"
                            " un libro de textos especimen. No sólo sobrevivió 500 años, "
                            "sino que tambien ingresó como texto de relleno en documentos electrónicos, quedando esencialmente igual al original. "
                            "Fue popularizado en los 60s con la creación de las hojas Letraset, "
                            "las cuales contenian pasajes de Lorem Ipsum, y más recientemente con software de "
                            "autoedición, como por ejemplo Aldus PageMaker, el cual incluye versiones de Lorem Ipsum.")
                  ]),
              overflow: TextOverflow.clip,
              style: TextStyle(
                fontFamily: fontFamilyText,
                fontSize: 18.0,
              ),
              textAlign: TextAlign.start,
              softWrap: true,
              textScaleFactor: 1.2,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAppBarPolicy(BuildContext context) {
    return TitleHeader(
      text: "Política de privacidad",
      size: 20.0,
      onPressed: () => Navigator.pop(context),
    );
  }
}
