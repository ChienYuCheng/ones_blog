import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ones_blog/LodgingArea.dart';
import 'package:ones_blog/RestaurantArea.dart';
import 'package:ones_blog/SignOutMenu.dart';
import 'package:ones_blog/SpotsArea.dart';
import 'package:ones_blog/StoreInformation.dart';
import 'package:ones_blog/bloc/location_bloc.dart';
import 'package:ones_blog/model/location_model.dart';
import 'package:ones_blog/repository/location_repo.dart';
import 'CreateMenu.dart';
import 'function/BuildButton.dart';
import 'function/PlaceElement.dart';
import 'function/BuildDots.dart';

import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  bool _verticalList = true;
  ScrollController _scrollController = ScrollController();
  int restaurantCurrentPos = 0, spotsCurrentPos = 0, lodgingCurrentPos = 0;
  final List<String> imgList = [
    "https://randomuser.me/api/portraits/med/women/73.jpg",
    "https://randomuser.me/api/portraits/med/men/15.jpg",
    "https://randomuser.me/api/portraits/med/men/80.jpg"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      endDrawer: CreateMenu(context),
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxScrolled) => [
          SliverAppBar(
            backgroundColor: Color.fromRGBO(197, 213, 212, 1),
            elevation: 0,
            toolbarHeight: 70,
            actions: [
              Builder(
                builder: (context) => IconButton(
                  icon: Image.asset("images/element/menu.png"),
                  iconSize: 70,
                  onPressed: () => Scaffold.of(context).openEndDrawer(),
                ),
              ),
            ],
          )
        ],
        body: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    height: (MediaQuery.of(context).size.height) - 160,
                    color: Color.fromRGBO(197, 213, 212, 1),
                  ),
                  placeElement(
                      MediaQuery.of(context).size.height / 40,
                      MediaQuery.of(context).size.width / 10,
                      "images/background/croissant.png",
                      120),
                  placeElement(
                      MediaQuery.of(context).size.height / 4.5,
                      MediaQuery.of(context).size.width / 15,
                      "images/text/titleWord.png",
                      300),
                  placeElement(
                      MediaQuery.of(context).size.height / 20,
                      MediaQuery.of(context).size.width / 1.3,
                      "images/background/strawberry.png",
                      120),
                  placeElement(
                      MediaQuery.of(context).size.height / 2.5,
                      MediaQuery.of(context).size.width / -8,
                      "images/background/donut.png",
                      120),
                  placeElement(
                      MediaQuery.of(context).size.height / 1.8,
                      MediaQuery.of(context).size.width / 1.6,
                      "images/background/matcha.png",
                      120),
                  placeElement(
                      MediaQuery.of(context).size.height / 1.42,
                      MediaQuery.of(context).size.width / 8,
                      "images/background/blueberry.png",
                      130),
                ],
              ),
              Container(
                height: 1600,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("images/background/background_body.png"),
                    alignment: Alignment.topCenter,
                    repeat: ImageRepeat.repeat,
                  ),
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        buildButtionPush('餐廳', 80, 48, context, RestaurantArea()),
                        buildButtionPush('景點', 80, 48, context, SpotsArea()),
                        buildButtionPush('旅宿', 80, 48, context, LodgingArea()),
                      ],
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 32,
                        ),
                        Image(
                          image: AssetImage("images/text/restaurant.png"),
                          width: 100,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    CarouselSlider(
                      options: CarouselOptions(
                          height: 260.0,
                          aspectRatio: 2.0,
                          enlargeCenterPage: true,
                          scrollDirection: Axis.horizontal,
                          onPageChanged: (index, reason) {
                            setState(() {
                              spotsCurrentPos = index;
                            });
                          }),
                      items: imgList.map((i) {
                        return Builder(
                          builder: (BuildContext context) {
                            return Container(
                              width: MediaQuery.of(context).size.width / 1.5,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Color.fromRGBO(198, 201, 203, 1)),
                              child: GestureDetector(
                                child: Center(
                                  child: Image.network(i, fit: BoxFit.cover, width: MediaQuery.of(context).size.width),
                                ),
                                onTap: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>StoreInformation()));
                                },
                              ),
                            );
                          },
                        );
                      }).toList(),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    buildDots(restaurantCurrentPos, [1, 2, 3, 4, 5]),
                    buildButtionPush(
                        "看更多", MediaQuery.of(context).size.width / 2, 48, context, RestaurantArea()),
                    SizedBox(
                      height: 30,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 32,
                        ),
                        Image(
                          image: AssetImage("images/text/spots.png"),
                          width: 100,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    CarouselSlider(
                      options: CarouselOptions(
                          height: 260.0,
                          aspectRatio: 2.0,
                          enlargeCenterPage: true,
                          scrollDirection: Axis.horizontal,
                          onPageChanged: (index, reason) {
                            setState(() {
                              spotsCurrentPos = index;
                            });
                          }),
                      items: [1, 2, 3, 4, 5].map((i) {
                        return Builder(
                          builder: (BuildContext context) {
                            return Container(
                              width: MediaQuery.of(context).size.width / 1.5,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Color.fromRGBO(198, 201, 203, 1)),
                              child: GestureDetector(
                                child: Center(
                                  child: Text(
                                    'text $i',
                                    style: TextStyle(fontSize: 16.0),
                                  ),
                                ),
                                onTap: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>StoreInformation()));
                                },
                              ),
                            );
                          },
                        );
                      }).toList(),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    buildDots(spotsCurrentPos, [1, 2, 3, 4, 5]),
                    buildButtionPush(
                        "看更多", MediaQuery.of(context).size.width / 2, 48, context, SpotsArea()),
                    SizedBox(
                      height: 30,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 32,
                        ),
                        Image(
                          image: AssetImage("images/text/lodging.png"),
                          width: 100,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    CarouselSlider(
                      options: CarouselOptions(
                          height: 260.0,
                          aspectRatio: 2.0,
                          enlargeCenterPage: true,
                          scrollDirection: Axis.horizontal,
                          onPageChanged: (index, reason) {
                            setState(() {
                              lodgingCurrentPos = index;
                            });
                          }),
                      items: [1, 2, 3, 4, 5].map((i) {
                        return Builder(
                          builder: (BuildContext context) {
                            return Container(
                              width: MediaQuery.of(context).size.width / 1.5,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Color.fromRGBO(198, 201, 203, 1)),
                              child: GestureDetector(
                                child: Center(
                                  child: Text(
                                    'text $i',
                                    style: TextStyle(fontSize: 16.0),
                                  ),
                                ),
                                onTap: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>StoreInformation()));
                                },
                              ),
                            );
                          },
                        );
                      }).toList(),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    buildDots(lodgingCurrentPos, [1, 2, 3, 4, 5]),
                    buildButtionPush(
                        "看更多", MediaQuery.of(context).size.width / 2, 48, context, LodgingArea()),
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
