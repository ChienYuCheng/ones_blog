import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'CreateMenu.dart';
import 'SearchLocations.dart';
import 'function/CreateComment.dart';

class EditUserInformation extends StatefulWidget {
  const EditUserInformation({Key? key}) : super(key: key);

  @override
  State<EditUserInformation> createState() => _EditUserInformationState();
}

class _EditUserInformationState extends State<EditUserInformation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      endDrawer: CreateMenu(context),
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxScrolled) => [
          SliverAppBar(
            pinned: true,
            backgroundColor: Color.fromRGBO(222, 215, 209, 1),
            elevation: 0,
            leading: IconButton(
              onPressed: () {
                Navigator.pop(
                  context,
                );
              },
              icon: Icon(
                Icons.arrow_back_rounded,
                color: Colors.black,
                size: 40,
              ),
            ),
            toolbarHeight: 70,
            actions: [
              Builder(
                builder: (context) => IconButton(
                  icon: Image.asset('images/element/menu.png'),
                  iconSize: 70,
                  onPressed: () => Scaffold.of(context).openEndDrawer(),
                ),
              ),
            ],
          ),
        ],
        body: Container(
          width: MediaQuery.of(context).size.width,
          child: Container(
            height: MediaQuery.of(context).size.height,
            color: Color.fromRGBO(222, 215, 209, 1),
            child: SingleChildScrollView(
              padding: EdgeInsets.only(top: 30),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.white,
                    child: ClipOval(
                      child: Image.asset('images/element/member.png'),
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
                          height: 20,
                        ),
                        Row(
                          children: [
                            Row(
                              children: [
                                SizedBox(width: 20.0,),
                                Text("用戶名稱",style: TextStyle(fontSize: 18),),
                              ],
                            ),
                            Column(
                              children: [
                                Row(
                                  children: [
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          '禾豐田食',
                                          style: TextStyle(fontSize: 16),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(top: 10.0),
                                          height: 2.0,
                                          width: 160,
                                          color: Color.fromRGBO(222, 215, 209, 1),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                        // Container(
                        //   margin: EdgeInsets.only(top: 10.0),
                        //   height: 2.0,
                        //   width: 280,
                        //   color: Color.fromRGBO(222, 215, 209, 1),
                        // ),
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
      ),
    );
  }
}
