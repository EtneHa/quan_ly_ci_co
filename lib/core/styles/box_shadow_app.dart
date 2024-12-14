import 'package:flutter/material.dart';

class BoxShadowApp{
  static const List<BoxShadow> elevation1 = [
    BoxShadow(
      offset: Offset(0, 1),
      blurRadius: 3,
      color: Color.fromRGBO(0, 0, 0, 0.12),
    ),
    BoxShadow(
      offset: Offset(0, 1),
      blurRadius: 1,
      color: Color.fromRGBO(0, 0, 0, 0.14),
    ),
    BoxShadow(
      offset: Offset(0, 2),
      blurRadius: 1,
      spreadRadius: -1,
      color: Color.fromRGBO(0, 0, 0, 0.20),
    )
  ];
}