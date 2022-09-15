import 'package:flutter/material.dart';
import 'package:ones_blog/HomePage.dart';

Container buildButtion(String buttonName, double width, double height, BuildContext context, Widget pageName) {
  return Container(
    margin: const EdgeInsets.only(top: 15),
    width: width,
    height: height,
    decoration: BoxDecoration(
      color: Color.fromRGBO(184, 197, 181, 1),
      borderRadius: new BorderRadius.all(
        Radius.circular(20.0),
      ),
      border: Border.all(color: Color.fromRGBO(169, 179, 146, 1), width: 3.0),
    ),
    child: TextButton(
      style: TextButton.styleFrom(
        padding: const EdgeInsets.all(10),
        primary: Colors.black,
        textStyle: const TextStyle(fontSize: 15),
      ),
      onPressed: () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => pageName,
            maintainState: false,
          ),
        );
      },
      child: Text(buttonName),
    ),
  );
}
Container buildButtionPush(String buttonName, double width, double height, BuildContext context, Widget pageName) {
  return Container(
    margin: const EdgeInsets.only(top: 15),
    width: width,
    height: height,
    decoration: BoxDecoration(
      color: Color.fromRGBO(184, 197, 181, 1),
      borderRadius: new BorderRadius.all(
        Radius.circular(20.0),
      ),
      border: Border.all(color: Color.fromRGBO(169, 179, 146, 1), width: 3.0),
    ),
    child: TextButton(
      style: TextButton.styleFrom(
        padding: const EdgeInsets.all(10),
        primary: Colors.black,
        textStyle: const TextStyle(fontSize: 15),
      ),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => pageName,
            maintainState: false,
          ),
        );
      },
      child: Text(buttonName),
    ),
  );
}
Container buildButtionPop(String buttonName, double width, double height, BuildContext context, Widget pageName) {
  return Container(
    margin: const EdgeInsets.only(top: 15),
    width: width,
    height: height,
    decoration: BoxDecoration(
      color: Color.fromRGBO(184, 197, 181, 1),
      borderRadius: new BorderRadius.all(
        Radius.circular(20.0),
      ),
      border: Border.all(color: Color.fromRGBO(169, 179, 146, 1), width: 3.0),
    ),
    child: TextButton(
      style: TextButton.styleFrom(
        padding: const EdgeInsets.all(10),
        primary: Colors.black,
        textStyle: const TextStyle(fontSize: 15),
      ),
      onPressed: () {
        Navigator.pop(context);
      },
      child: Text(buttonName),
    ),
  );
}

Container buildButtionPushAndRem(String buttonName, double width, double height, BuildContext context, Widget pageName) {
  return Container(
    margin: const EdgeInsets.only(top: 15),
    width: width,
    height: height,
    decoration: BoxDecoration(
      color: Color.fromRGBO(184, 197, 181, 1),
      borderRadius: new BorderRadius.all(
        Radius.circular(20.0),
      ),
      border: Border.all(color: Color.fromRGBO(169, 179, 146, 1), width: 3.0),
    ),
    child: TextButton(
      style: TextButton.styleFrom(
        padding: const EdgeInsets.all(10),
        primary: Colors.black,
        textStyle: const TextStyle(fontSize: 15),
      ),
      onPressed: () {
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>HomePage()), (route) => false);
      },
      child: Text(buttonName),
    ),
  );
}


Container kbuildButtionPushAndRem(String buttonName, double width, double height, BuildContext context, Function onPressed) {
  return Container(
    margin: const EdgeInsets.only(top: 15),
    width: width,
    height: height,
    decoration: BoxDecoration(
      color: Color.fromRGBO(184, 197, 181, 1),
      borderRadius: new BorderRadius.all(
        Radius.circular(20.0),
      ),
      border: Border.all(color: Color.fromRGBO(169, 179, 146, 1), width: 3.0),
    ),
    child: TextButton(
      style: TextButton.styleFrom(
        padding: const EdgeInsets.all(10),
        primary: Colors.black,
        textStyle: const TextStyle(fontSize: 15),
      ),
      onPressed: () => onPressed(),
      child: Text(buttonName),
    ),
  );
}
