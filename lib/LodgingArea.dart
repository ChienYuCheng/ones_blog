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
                        'Singleinn單人房', '新北市板橋區', 'images/element/test.jpeg'),
                    CreateAreaList(
                        '台北新板希爾頓酒店', '新北市板橋區', 'images/element/test.jpeg'),
                    CreateAreaList(
                        '九份未眠者花園民宿', '新北市瑞芳區', 'images/element/test.jpeg'),
                    CreateAreaList(
                        '板橋凱撒大飯店', '新北市板橋區', 'images/element/test.jpeg'),
                    CreateAreaList(
                        '福容大飯店 台北二館', '新北市深坑區', 'images/element/test.jpeg'),
                    CreateAreaList(
                        '九份第一站背包客青旅', '新北市瑞芳區', 'images/element/test.jpeg'),
                    CreateAreaList(
                        '將捷金鬱金香酒店', '新北市淡水區', 'images/element/test.jpeg'),
                    CreateAreaList(
                        '九份故事樓民宿', '新北市瑞芳區', 'images/element/test.jpeg'),
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
