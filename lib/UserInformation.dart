import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'CreateMenu.dart';
import 'HomePage.dart';
import 'function/BuildButton.dart';
import 'function/CreateArticle.dart';

class UserInformation extends StatefulWidget {
  const UserInformation({Key? key}) : super(key: key);

  @override
  _UserInformationState createState() => _UserInformationState();
}

class _UserInformationState extends State<UserInformation> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 1,
      length: 4,
      child: Scaffold(
        endDrawer: CreateMenu(context),
        body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxScrolled) => [
            SliverAppBar(
              pinned: true,
              backgroundColor: Color.fromRGBO(222, 215, 209, 1),
              elevation: 0,
              leading: IconButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HomePage(),
                      maintainState: false,
                    ),
                  );
                },
                icon: Image.asset('images/icon/icon.png'),
              ),
              toolbarHeight: 270,
              leadingWidth: 100,
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: 5,
                        ),
                        CircleAvatar(
                          radius: 45,
                          backgroundColor: Colors.white,
                          child: ClipOval(
                            child: Image.asset('images/element/member.png'),
                          ),
                        ),
                        Column(
                          children: [
                            Text('我的文章'),
                            SizedBox(
                              height: 5,
                            ),
                            Text('2'),
                          ],
                        ),
                        Column(
                          children: [
                            Text('喜好店家'),
                            SizedBox(
                              height: 5,
                            ),
                            Text('9'),
                          ],
                        ),
                        Column(
                          children: [
                            Text('珍藏文章'),
                            SizedBox(
                              height: 5,
                            ),
                            Text('9'),
                          ],
                        ),
                        Column(
                          children: [
                            Text('成就獎章'),
                            SizedBox(
                              height: 5,
                            ),
                            Text('16'),
                          ],
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 180,
                        ),
                        buildButtion('編輯個人檔案', 120, 48, context, HomePage()),
                      ],
                    ),
                    TabBar(
                      labelColor: Colors.black,
                      indicatorColor: Colors.blueGrey,
                      tabs: <Widget>[
                        Tab(
                          child: Image(
                            image: AssetImage('images/element/article.png'),
                          ),
                        ),
                        Tab(
                          child: Image(
                            image: AssetImage('images/element/like.png'),
                          ),
                        ),
                        Tab(
                          child: Image(
                            image: AssetImage('images/element/keep.png'),
                          ),
                        ),
                        Tab(
                          child: Image(
                            image: AssetImage('images/element/medal.png'),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
          body: TabBarView(
            children: <Widget>[
              Center(
                child: SingleChildScrollView(
                  child: Container(
                    height: MediaQuery.of(context).size.height + 350,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: Color.fromRGBO(222, 215, 209, 1), width: 5),
                      color: Color.fromRGBO(222, 215, 209, 1),
                    ),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        CreateArticle(
                            '旅宿', '五百多坪庭園景觀民宿', 'images/element/test.jpeg'),
                        CreateArticle(
                            '旅宿', '超棒五星飯店+高空泳池', 'images/element/test.jpeg'),
                        CreateArticle(
                            '旅宿', '高空泳池、平價五星級酒店', 'images/element/test.jpeg'),
                        CreateArticle(
                            '旅宿', '淡水捷運交通接駁＆禮...', 'images/element/test.jpeg'),
                      ],
                    ),
                  ),
                ),
              ),
              Center(
                child: SingleChildScrollView(
                  child: Container(
                    height: MediaQuery.of(context).size.height + 350,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: Color.fromRGBO(222, 215, 209, 1), width: 5),
                      color: Color.fromRGBO(222, 215, 209, 1),
                    ),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        CreateArticle(
                            '旅宿', '五百多坪庭園景觀民宿', 'images/element/test.jpeg'),
                        CreateArticle(
                            '旅宿', '超棒五星飯店+高空泳池', 'images/element/test.jpeg'),
                        CreateArticle(
                            '旅宿', '高空泳池、平價五星級酒店', 'images/element/test.jpeg'),
                        CreateArticle(
                            '旅宿', '淡水捷運交通接駁＆禮...', 'images/element/test.jpeg'),
                      ],
                    ),
                  ),
                ),
              ),
              Center(
                child: SingleChildScrollView(
                  child: Container(
                    height: MediaQuery.of(context).size.height + 350,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: Color.fromRGBO(222, 215, 209, 1), width: 5),
                      color: Color.fromRGBO(222, 215, 209, 1),
                    ),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        CreateArticle(
                            '旅宿', '五百多坪庭園景觀民宿', 'images/element/test.jpeg'),
                        CreateArticle(
                            '旅宿', '超棒五星飯店+高空泳池', 'images/element/test.jpeg'),
                        CreateArticle(
                            '旅宿', '高空泳池、平價五星級酒店', 'images/element/test.jpeg'),
                        CreateArticle(
                            '旅宿', '淡水捷運交通接駁＆禮...', 'images/element/test.jpeg'),
                      ],
                    ),
                  ),
                ),
              ),
              Center(
                child: SingleChildScrollView(
                  child: Container(
                    height: MediaQuery.of(context).size.height + 350,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: Color.fromRGBO(222, 215, 209, 1), width: 5),
                      color: Color.fromRGBO(222, 215, 209, 1),
                    ),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        CreateArticle(
                            '旅宿', '五百多坪庭園景觀民宿', 'images/element/test.jpeg'),
                        CreateArticle(
                            '旅宿', '超棒五星飯店+高空泳池', 'images/element/test.jpeg'),
                        CreateArticle(
                            '旅宿', '高空泳池、平價五星級酒店', 'images/element/test.jpeg'),
                        CreateArticle(
                            '旅宿', '淡水捷運交通接駁＆禮...', 'images/element/test.jpeg'),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
