import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ones_blog/AboutUs.dart';
import 'package:ones_blog/LoginAccount.dart';
import 'Community.dart';
import 'CreateMenu.dart';
import 'HomePage.dart';
import 'Leaderboard.dart';
import 'function/BuildMenuButton.dart';
import 'function/CreateAreaList.dart';

class LodgingArea extends StatefulWidget {
  const LodgingArea({Key? key}) : super(key: key);

  @override
  _LodgingAreaState createState() => _LodgingAreaState();
}

class _LodgingAreaState extends State<LodgingArea> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: CreateMenu(context),
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxScrolled) => [
          SliverAppBar(
            pinned: true,
            backgroundColor: Color.fromRGBO(222, 215, 209, 1),
            elevation: 0,
            leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop(context);
              },
              icon: Icon(
                Icons.arrow_back_rounded,
                color: Colors.black,
                size: 40,
              ),
            ),
            toolbarHeight: 125,
            actions: [
              Builder(
                builder: (context) => IconButton(
                  icon: Image.asset('images/element/menu.png'),
                  iconSize: 70,
                  onPressed: () => Scaffold.of(context).openEndDrawer(),
                ),
              ),
            ],
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(0.0),
              child: Row(
                children: [
                  SizedBox(
                    width: 5,
                  ),
                  Image(
                    image: AssetImage('images/text/lodging.png'),
                    height: 55,
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Image(
                    image: AssetImage('images/text/newTaipeiCity.png'),
                    height: 55,
                  ),
                ],
              ),
            ),
          ),
        ],
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                color: Color.fromRGBO(222, 215, 209, 1),
                height: MediaQuery.of(context).size.height + 1700,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    CreateAreaList(
                        'Singleinn?????????', '??????????????????', 'images/element/test.jpeg'),
                    CreateAreaList(
                        '???????????????????????????', '??????????????????', 'images/element/test.jpeg'),
                    CreateAreaList(
                        '???????????????????????????', '??????????????????', 'images/element/test.jpeg'),
                    CreateAreaList(
                        '?????????????????????', '??????????????????', 'images/element/test.jpeg'),
                    CreateAreaList(
                        '??????????????? ????????????', '??????????????????', 'images/element/test.jpeg'),
                    CreateAreaList(
                        '??????????????????????????????', '??????????????????', 'images/element/test.jpeg'),
                    CreateAreaList(
                        '????????????????????????', '??????????????????', 'images/element/test.jpeg'),
                    CreateAreaList(
                        '?????????????????????', '??????????????????', 'images/element/test.jpeg'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
