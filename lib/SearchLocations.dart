import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'AddArticle.dart';

class SearchLocations extends StatefulWidget {
  const SearchLocations({Key? key}) : super(key: key);

  @override
  _SearchLocationsState createState() => _SearchLocationsState();
}

class _SearchLocationsState extends State<SearchLocations> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: Container(
          height: MediaQuery.of(context).size.height,
          color: Color.fromRGBO(222, 215, 209, 1),
          child: SingleChildScrollView(
            padding: EdgeInsets.only(top: 30),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      padding: EdgeInsets.only(top: 10, left: 160),
                      child: Text(
                        '地點',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                    Spacer(),
                    IconButton(
                      padding: EdgeInsets.only(top: 10, right: 20),
                      onPressed: () {
                        Navigator.of(context).pop(context);
                      },
                      icon: Icon(
                        Icons.clear,
                        size: 40,
                      ),
                    ),
                  ],
                ),
                Container(
                  margin: EdgeInsets.only(top: 20.0),
                  height: 2.0,
                  width: MediaQuery.of(context).size.width,
                  color: Colors.white,
                ),
                Container(
                  margin: EdgeInsets.only(top: 20.0, bottom: 10.0),
                  width: 300,
                  height: 45,
                  child: TextField(
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      prefixIcon: Icon(
                        FontAwesomeIcons.search,
                        color: Color.fromRGBO(198, 201, 203, 1.0),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 20.0, bottom: 10.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    color: Colors.white,
                  ),
                  width: 300,
                  height: 500,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 20,
                          ),
                          Text(
                            '禾豐田食',
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 20,
                          ),
                          Text(
                            '台中市西區模範街40巷12號',
                            style: TextStyle(
                                fontSize: 14,
                                color: Color.fromRGBO(123, 123, 123, 1.0)),
                          ),
                        ],
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 10.0),
                        height: 2.0,
                        width: 280,
                        color: Color.fromRGBO(222, 215, 209, 1),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 20,
                          ),
                          Text(
                            '禾田野',
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 20,
                          ),
                          Text(
                            '花蓮縣壽豐鄉中山路121巷2號',
                            style: TextStyle(
                                fontSize: 14,
                                color: Color.fromRGBO(123, 123, 123, 1.0)),
                          ),
                        ],
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 10.0),
                        height: 2.0,
                        width: 280,
                        color: Color.fromRGBO(222, 215, 209, 1),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
