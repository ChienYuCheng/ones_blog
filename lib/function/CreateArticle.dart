import 'package:flutter/material.dart';
import 'package:ones_blog/ArticleContent.dart';
import 'package:ones_blog/Constant.dart';

TextButton CreateArticle(String type, String title, String route, BuildContext context) {
  return TextButton(
    onPressed: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ArticleContent(),
          maintainState: false,
        ),
      );
    },
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
                type,
                style: titleStyle,
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
