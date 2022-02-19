import 'package:flutter/material.dart';

TextButton CreateAreaList(String title, String address, String route) {
  return TextButton(
    onPressed: () {},
    child: Container(
      margin: EdgeInsets.only(top: 10.0),
      decoration: BoxDecoration(
        color: Color.fromRGBO(198, 201, 203, 1),
        borderRadius: new BorderRadius.all(
          Radius.circular(10.0),
        ),
      ),
      width: 220,
      height: 260,
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: Image(
              image: AssetImage(route),
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          Row(
            children: [
              SizedBox(
                width: 10.0,
              ),
              Text(
                title,
                style: TextStyle(fontSize: 18, color: Colors.black),
              ),
            ],
          ),
          SizedBox(
            height: 20.0,
          ),
          Row(
            children: [
              SizedBox(
                width: 10.0,
              ),
              Text(
                address,
                style: TextStyle(fontSize: 16, color: Colors.black),
              ),
              Spacer(),
              Icon(
                Icons.star,
                color: Color.fromRGBO(185, 153, 98, 1.0),
              ),
              Text(
                '4.5',
                style: TextStyle(fontSize: 16, color: Colors.black),
              ),
              SizedBox(
                width: 5.0,
              ),
            ],
          ),
        ],
      ),
    ),
  );
}
