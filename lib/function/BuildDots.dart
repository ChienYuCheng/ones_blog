import 'package:flutter/material.dart';

Row buildDots(int currentPos, List list) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: list.map((url) {
      int index = list.indexOf(url);
      return Container(
        width: 8.0,
        height: 8.0,
        margin: EdgeInsets.symmetric(
            vertical: 10.0, horizontal: 2.0),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: currentPos == index
              ? Color.fromRGBO(0, 0, 0, 0.9)
              : Color.fromRGBO(0, 0, 0, 0.4),
        ),
      );
    }).toList(),
  );
}