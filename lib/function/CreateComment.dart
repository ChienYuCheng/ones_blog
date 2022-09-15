import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Constant.dart';

Container createComment(
    String name, String comment, String date, BuildContext context) {
  return Container(
    child: Column(
      children: [
        Container(
          // margin: EdgeInsets.only(top: 10.0),
          // decoration: BoxDecoration(
          //   color: Color.fromRGBO(198, 201, 203, 1.0),
          //   borderRadius: new BorderRadius.all(
          //     Radius.circular(5.0),
          //   ),
          // ),
          width: 335,
          padding: EdgeInsets.all(5),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 20,
                          backgroundColor: Colors.white,
                          child: ClipOval(
                            child: Image.asset('images/element/member.png'),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          name,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      comment,
                      style: contextStyle,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 10,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      date,
                      style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                    ),
                  ],
                ),
              ),
              // Spacer(),
            ],
          ),
        ),
        Divider(
          height: 20,
          thickness: 1,
          indent: 20,
          endIndent: 20,
          color: Colors.white,
        ),
      ],
    ),
  );
}
