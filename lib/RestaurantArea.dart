import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ones_blog/Leaderboard.dart';
import 'package:ones_blog/LoginAccount.dart';
import 'package:ones_blog/SignOutMenu.dart';
import 'AboutUs.dart';
import 'Community.dart';
import 'CreateMenu.dart';
import 'HomePage.dart';
import 'function/BuildMenuButton.dart';
import 'function/CreateAreaList.dart';

class RestaurantArea extends StatefulWidget {
  const RestaurantArea({Key? key}) : super(key: key);

  @override
  _RestaurantAreaState createState() => _RestaurantAreaState();
}

class _RestaurantAreaState extends State<RestaurantArea> {
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
                    image: AssetImage('images/text/restaurant.png'),
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
                        '阿妃餃子館', '新北市永和區', 'images/element/test.jpeg'),
                    CreateAreaList('SKYLARK加州風洋食館-\n新店家樂福店', '新北市新店區',
                        'images/element/test.jpeg'),
                    CreateAreaList(
                        'TINA廚房-鶯歌店', '新北市鶯歌區', 'images/element/test.jpeg'),
                    CreateAreaList(
                        '心伝的家', '新北市林口區', 'images/element/test.jpeg'),
                    CreateAreaList(
                        '哩賀涼麵', '新北市永和區', 'images/element/test.jpeg'),
                    CreateAreaList(
                        '粩泰泰泰式料理', '新北市板橋區', 'images/element/test.jpeg'),
                    CreateAreaList(
                        '田中芳園養生食坊', '新北市金山區', 'images/element/test.jpeg'),
                    CreateAreaList(
                        '原粹蔬食作', '新北市新店區', 'images/element/test.jpeg'),
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
