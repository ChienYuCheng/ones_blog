import 'package:flutter/material.dart';
import 'package:ones_blog/HomePage.dart';
import 'package:ones_blog/RestaurantArea.dart';

Container buildMenuButton(IconData icon, String buttonName, BuildContext context, Widget pageName) {
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10.0),
      color: Colors.white,
    ),
    margin: EdgeInsets.only(top: 30),
    width: 120,
    height: 80,
    child: TextButton(
      onPressed: () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => pageName,
            maintainState: false,
          ),
        );
      },
      child: Column(
        children: [
          Icon(
            icon,
            size: 28,
            color: Colors.black,
          ),
          Padding(padding: const EdgeInsets.only(top: 5)),
          Text(
            buttonName,
            style: TextStyle(color: Colors.black, fontSize: 18),
          ),
        ],
      ),
    ),
  );
}
