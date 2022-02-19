import 'package:flutter/material.dart';

Positioned placeElement(double top, double left, String route, double width) {
  return Positioned(
    top: top,
    left: left,
    child: Image(
      image: AssetImage(route),
      width: width,
    ),
  );
}