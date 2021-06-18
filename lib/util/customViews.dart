import 'package:flutter/material.dart';

//constantes de colores y cajas de decoracion
final formsTextStyle = TextStyle(
  color: Colors.black,
  fontFamily: 'OpenSans',
);

final kLabelStyle = TextStyle(
  color: Colors.black,
  fontWeight: FontWeight.bold,
  fontFamily: 'OpenSans',
);

final kBoxDecorationStyle = BoxDecoration(
  color: Colors.white,
  boxShadow: [
    BoxShadow(
      color: Colors.black12,
      blurRadius: 10.0,
      offset: Offset(0, 2),
    ),
  ],
);

final kBoxDecorationStyle_input = BoxDecoration(
  color: Colors.white,
  border: Border(
    bottom: BorderSide(color: Colors.black, width: 2),
  ),
  boxShadow: [
    BoxShadow(
      color: Colors.black12,
      blurRadius: 10.0,
      offset: Offset(0, 2),
    ),
  ],
);

//estilos de texto
//
final styleTextUser = TextStyle(
  color: Colors.white,
  fontWeight: FontWeight.bold,
  fontFamily: 'OpenSans',
  fontSize: 15,
);
