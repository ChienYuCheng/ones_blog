import 'package:flutter/material.dart';
import 'package:ones_blog/Constant.dart';

TextButton ShareArticle(String userName, String title, String route) {
  return TextButton(
    onPressed: () {},
    child: Container(
      // margin: EdgeInsets.only(top: 10.0),
      decoration: BoxDecoration(
        color: Color.fromRGBO(198, 201, 203, 1.0),
        borderRadius: new BorderRadius.all(
          Radius.circular(5.0),
        ),
      ),
      width: 335,
      height: 85,
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                userName,
                style: contextStyle,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                title,
                style: contextStyle,
              ),
            ],
          ),
          Spacer(),
          ClipRRect(
            borderRadius: BorderRadius.circular(5.0),
            child: Image(
              image: AssetImage(route),
            ),
          ),
        ],
      ),
    ),
  );
}