import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'CreateMenu.dart';
import 'HomePage.dart';
import 'function/BuildDots.dart';

class Leaderboard extends StatefulWidget {
  const Leaderboard({Key? key}) : super(key: key);

  @override
  _LeaderboardState createState() => _LeaderboardState();
}

class _LeaderboardState extends State<Leaderboard> {
  int restaurantCurrentPos = 0, spotsCurrentPos = 0, lodgingCurrentPos = 0;

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
            toolbarHeight: 125,
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
              child: Row(
                children: [
                  SizedBox(
                    width: 5,
                  ),
                  Container(
                    child: Image.asset(
                      'images/text/rankWord.png',
                      height: 55,
                    ),
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
                height: MediaQuery.of(context).size.height + 600,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 5,
                        ),
                        Image(
                          image: AssetImage('images/text/restaurant.png'),
                          width: 80,
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
                              restaurantCurrentPos = index;
                            });
                          }),
                      items: [1, 2, 3, 4, 5, 6, 7, 8, 9].map((i) {
                        return Builder(
                          builder: (BuildContext context) {
                            return Container(
                              width: MediaQuery.of(context).size.width / 1.5,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Color.fromRGBO(198, 201, 203, 1)),
                              child: Center(
                                child: Text(
                                  'text $i',
                                  style: TextStyle(fontSize: 16.0),
                                ),
                              ),
                            );
                          },
                        );
                      }).toList(),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    buildDots(restaurantCurrentPos, [1, 2, 3, 4, 5, 6, 7, 8, 9]),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 5,
                        ),
                        Image(
                          image: AssetImage('images/text/spots.png'),
                          width: 80,
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
                      items: [1, 2, 3, 4, 5, 6, 7, 8, 9].map((i) {
                        return Builder(
                          builder: (BuildContext context) {
                            return Container(
                              width: MediaQuery.of(context).size.width / 1.5,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Color.fromRGBO(198, 201, 203, 1)),
                              child: Center(
                                child: Text(
                                  'text $i',
                                  style: TextStyle(fontSize: 16.0),
                                ),
                              ),
                            );
                          },
                        );
                      }).toList(),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    buildDots(spotsCurrentPos, [1, 2, 3, 4, 5, 6, 7, 8, 9]),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 5,
                        ),
                        Image(
                          image: AssetImage('images/text/lodging.png'),
                          width: 80,
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
                      items: [1, 2, 3, 4, 5, 6, 7, 8, 9].map((i) {
                        return Builder(
                          builder: (BuildContext context) {
                            return Container(
                              width: MediaQuery.of(context).size.width / 1.5,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Color.fromRGBO(198, 201, 203, 1)),
                              child: Center(
                                child: Text(
                                  'text $i',
                                  style: TextStyle(fontSize: 16.0),
                                ),
                              ),
                            );
                          },
                        );
                      }).toList(),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    buildDots(lodgingCurrentPos, [1, 2, 3, 4, 5, 6, 7, 8, 9]),
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
