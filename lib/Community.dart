import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ones_blog/CreateMenu.dart';
import 'package:ones_blog/bloc/post_bloc.dart';
import 'package:ones_blog/model/post_model.dart';
import 'package:ones_blog/services/post_service.dart';
import 'AddArticle.dart';
import 'HomePage.dart';
import 'function/CreateArticle.dart';

class Community extends StatefulWidget {
  const Community({Key? key}) : super(key: key);

  @override
  _CommunityState createState() => _CommunityState();
}

class _CommunityState extends State<Community> {

  // String category(int c){
  //   String category = "";
  //   if(c == 1){
  //     category = "餐廳";
  //   }else if(c == 2){
  //     category = "景點";
  //   }else{
  //     category = "旅宿";
  //   }
  //   return category;
  // }

  @override
  Widget build(BuildContext context) {

    return DefaultTabController(
      initialIndex: 0,
      length: 3,
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
                  Navigator.of(context).pop(context);
                },
                icon: Icon(
                  Icons.arrow_back_rounded,
                  color: Colors.black,
                  size: 40,
                ),
              ),
              toolbarHeight: 175,
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
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          width: 5,
                        ),
                        Container(
                          child: Image.asset(
                            'images/text/communityWord.png',
                            height: 55,
                          ),
                        ),
                      ],
                    ),
                    TabBar(
                      labelColor: Colors.black,
                      indicatorColor: Colors.blueGrey,
                      tabs: <Widget>[
                        Tab(
                          child: Text(
                            '餐廳',
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                        Tab(
                          child: Text(
                            '景點',
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                        Tab(
                          child: Text(
                            '旅宿',
                            style: TextStyle(fontSize: 18),
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
                child: Container(
                  height: MediaQuery.of(context).size.height + 350,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: Color.fromRGBO(222, 215, 209, 1),width: 5),
                    color: Color.fromRGBO(222, 215, 209, 1),
                  ),
                  child: FutureBuilder(
                    builder: (context, snapshot){
                      var showData = jsonDecode(snapshot.data.toString());
                      return ListView.builder(
                        itemBuilder: (BuildContext context, int index){
                          return new Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              CreateArticle((showData['data'][index]['user']['name']).toString(), showData['data'][index]['title'].toString(), 'images/element/test.jpeg', context)
                            ],
                          );
                        },
                        itemCount: showData == null ? 0 : showData["data"].length,
                      );
                    },future: DefaultAssetBundle.of(context).loadString("assets/raw/posts.json"),
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
                            '景點', '到野柳一訪課本中的女...', 'images/element/test.jpeg', context),
                        CreateArticle(
                            '景點', '考古親子體驗一日遊', 'images/element/test.jpeg', context),
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
                            '旅宿', '五百多坪庭園景觀民宿', 'images/element/test.jpeg', context),
                        CreateArticle(
                            '旅宿', '超棒五星飯店+高空泳池', 'images/element/test.jpeg', context),
                        CreateArticle(
                            '旅宿', '高空泳池、平價五星級酒店', 'images/element/test.jpeg', context),
                        CreateArticle(
                            '旅宿', '淡水捷運交通接駁＆禮...', 'images/element/test.jpeg', context),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          elevation: 4,
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => AddArticle(),
                maintainState: false,
              ),
            );
          },
          backgroundColor: Colors.white,
          child: const Icon(
            FontAwesomeIcons.plus,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}