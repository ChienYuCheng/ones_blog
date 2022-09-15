import 'package:flutter/material.dart';
import 'package:ones_blog/Constant.dart';

import '../model/post_model.dart';

Container buildMenuButton(String route, String buttonName, BuildContext context, Widget pageName, double width) {
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
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => pageName,
            maintainState: false,
          ),
        );
      },
      child: Column(
        children: [
          Image(image: AssetImage(route), width: width,),
          Text(
            buttonName,
            style: titleStyle,
          ),
        ],
      ),
    ),
  );
}
Container buildMenuButtonPop(String route, String buttonName, BuildContext context, Widget pageName, double width) {
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
        Navigator.pop(context);
      },
      child: Column(
        children: [
          Image(image: AssetImage(route), width: width,),
          Text(
            buttonName,
            style: titleStyle,
          ),
        ],
      ),
    ),
  );
}

Container kbuildMenuButtonPop(String route, String buttonName, BuildContext context, Function onPressed, double width) {
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
        // Navigator.pop(context);
        onPressed();
      },
      child: Column(
        children: [
          Image(image: AssetImage(route), width: width,),
          Text(
            buttonName,
            style: titleStyle,
          ),
        ],
      ),
    ),
  );
}