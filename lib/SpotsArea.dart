import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ones_blog/AboutUs.dart';
import 'package:ones_blog/LoginAccount.dart';
import 'package:ones_blog/SignOutMenu.dart';
import 'Community.dart';
import 'CreateMenu.dart';
import 'HomePage.dart';
import 'Leaderboard.dart';
import 'function/BuildMenuButton.dart';
import 'function/CreateAreaList.dart';

class SpotsArea extends StatefulWidget {
  const SpotsArea({Key? key}) : super(key: key);

  @override
  _SpotsAreaState createState() => _SpotsAreaState();
}

class _SpotsAreaState extends State<SpotsArea> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // endDrawer: CreateMenu(context),
      endDrawer: SignOutMenu(context),
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
                    image: AssetImage('images/text/spots.png'),
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
                        '阿里磅生態休閒農場', '新北市石門區', 'images/element/test.jpeg'),
                    CreateAreaList(
                        '野柳地質公園', '新北市萬里區', 'images/element/test.jpeg'),
                    CreateAreaList(
                        '雲仙樂園', '新北市烏來區', 'images/element/test.jpeg'),
                    CreateAreaList(
                        '鹿角溪人工濕地', '新北市樹林區', 'images/element/test.jpeg'),
                    CreateAreaList(
                        '新北市立十三行博物館', '新北市八里區', 'images/element/test.jpeg'),
                    CreateAreaList(
                        '白沙灣自然中心', '新北市石門區', 'images/element/test.jpeg'),
                    CreateAreaList(
                        '雙溪平林休閒農場', '新北市雙溪區', 'images/element/test.jpeg'),
                    CreateAreaList(
                        '新北市立鶯歌陶瓷博物館', '新北市鶯歌區', 'images/element/test.jpeg'),
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
