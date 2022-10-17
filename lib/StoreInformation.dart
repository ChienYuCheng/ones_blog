import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ones_blog/SignOutMenu.dart';
import 'package:ones_blog/bloc/restaurant_bloc.dart';
import 'package:ones_blog/model/location_model.dart';
import 'package:ones_blog/repository/location_repo.dart';
import 'bloc/lodging_bloc.dart';
import 'bloc/spot_bloc.dart';
import 'function/ShareArticle.dart';
import 'CreateMenu.dart';
import 'HomePage.dart';
import 'function/BuildDots.dart';

class StoreInformation extends StatefulWidget {
  // LocationModel locations;
  final int index;
  int categoryId;
  String token;
  StoreInformation({required this.index, required this.categoryId, required this.token});

  @override
  _StoreInformationState createState() => _StoreInformationState();
}

class _StoreInformationState extends State<StoreInformation> {
  // late LocationModel locations;
  // late RestaurantBloc restaurantBloc;

  int currentPos = 0;
  bool heartIsPressed = false;

  @override
  void initState() {
    super.initState();
    // restaurantBloc = BlocProvider.of<RestaurantBloc>(context);
    // restaurantBloc.add(FetchRestaurantEvent());
  }

  @override
  Widget build(BuildContext context) {
    if(widget.categoryId == 1){
      return restaurantView(context, widget.index);
    }else if(widget.categoryId == 2){
      return spotView(context, widget.index);
    }else{
      return lodgingView(context, widget.index);
    }

  }

  Widget restaurantView(BuildContext context,int index){
    return DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: Scaffold(
        // resizeToAvoidBottomInset: false,
        endDrawer: CreateMenu(context, widget.token),
        body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxScrolled) => [
            SliverAppBar(
              pinned: true,
              backgroundColor: Color.fromRGBO(222, 215, 209, 1),
              elevation: 0,
              leading: IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: Icon(
                  Icons.arrow_back_rounded,
                  color: Colors.black,
                  size: 40,
                ),
              ),
              toolbarHeight: 120,
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
                child: TabBar(
                  labelColor: Colors.black,
                  indicatorColor: Colors.blueGrey,
                  tabs: <Widget>[
                    Tab(
                      child: Text('店家資訊'),
                    ),
                    Tab(
                      child: Text('分享文'),
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
                  child: Column(
                    children: [
                      Container(
                        color: Color.fromRGBO(222, 215, 209, 1),
                        height: MediaQuery.of(context).size.height + 300,
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          children: [
                            SizedBox(
                              height: 20,
                            ),
                            CarouselSlider(
                              options: CarouselOptions(
                                  height: 160.0,
                                  aspectRatio: 2.0,
                                  enlargeCenterPage: true,
                                  scrollDirection: Axis.horizontal,
                                  onPageChanged: (index, reason) {
                                    setState(() {
                                      currentPos = index;
                                    });
                                  }),
                              items: [1,2,3,4,5].map((i) {
                                return Builder(
                                  builder: (BuildContext context) {
                                    return Container(
                                      width: MediaQuery.of(context).size.width / 1.5,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                          BorderRadius.circular(10),
                                          color:
                                          Color.fromRGBO(198, 201, 203, 1)),
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
                            buildDots(currentPos, [1, 2, 3, 4, 5]),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              children: [
                                SizedBox(
                                  width: 40,
                                ),
                                Text(
                                  // state.restaurants.data[index].name,
                                  LocationRepository.restaurantName[index],
                                  style: TextStyle(fontSize: 18),
                                ),
                                Spacer(),
                                IconButton(
                                  onPressed: () {
                                    // print(LocationRepository.restaurantIntroduction[index]);
                                    print('press');
                                    setState(() {
                                      heartIsPressed = !heartIsPressed;
                                    });
                                  },
                                  icon: Icon(
                                    heartIsPressed
                                        ? Icons.favorite
                                        : Icons.favorite_border,
                                    color: Colors.redAccent,
                                    size: 40,
                                  ),
                                ),
                                SizedBox(width: 40),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                SizedBox(
                                  width: 40,
                                ),
                                Icon(
                                  Icons.star,
                                  color: Color.fromRGBO(241, 208, 10, 1),
                                ),
                                Icon(
                                  Icons.star,
                                  color: Color.fromRGBO(241, 208, 10, 1),
                                ),
                                Icon(
                                  Icons.star,
                                  color: Color.fromRGBO(241, 208, 10, 1),
                                ),
                                Icon(
                                  Icons.star,
                                  color: Color.fromRGBO(241, 208, 10, 1),
                                ),
                                Icon(
                                  Icons.star_half,
                                  color: Color.fromRGBO(241, 208, 10, 1),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(LocationRepository.restaurantAvgScore[index]),
                                Spacer(),
                                Container(
                                  width: 48,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Color.fromRGBO(184, 197, 181, 1),
                                    border: Border.all(
                                        color: Color.fromRGBO(169, 179, 146, 1),
                                        width: 3.0),
                                  ),
                                  child: IconButton(
                                    onPressed: () {
                                      showDialog<String>(
                                        barrierDismissible: false,
                                        context: context,
                                        builder: (BuildContext context) =>
                                            AlertDialog(
                                              title: Text('新增評分'),
                                              content: RatingBar.builder(
                                                initialRating: 2.5,
                                                minRating: 1,
                                                direction: Axis.horizontal,
                                                allowHalfRating: true,
                                                itemSize: MediaQuery.of(context).size.width / 9,
                                                itemCount: 5,
                                                itemPadding: EdgeInsets.symmetric(
                                                    horizontal: 2.0),
                                                itemBuilder: (context, _) => Icon(
                                                  Icons.star,
                                                  color: Color.fromRGBO(
                                                      241, 208, 10, 1),
                                                ),
                                                onRatingUpdate: (rating) {
                                                  print(rating);
                                                },
                                              ),
                                              actions: <Widget>[
                                                TextButton(
                                                  onPressed: () =>
                                                      Navigator.pop(context, '取消'),
                                                  child: const Text('取消'),
                                                ),
                                                TextButton(
                                                  onPressed: () =>
                                                      Navigator.pop(context, '送出'),
                                                  child: const Text('送出'),
                                                ),
                                              ],
                                            ),
                                      );
                                    },
                                    icon: Icon(FontAwesomeIcons.plus),
                                  ),
                                ),
                                SizedBox(width: 35),
                              ],
                            ),
                            SizedBox(
                              height: 20.0,
                            ),
                            Row(
                              children: [
                                SizedBox(
                                  width: 40,
                                ),
                                Icon(FontAwesomeIcons.mapMarkerAlt),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(LocationRepository.restaurantAddress[index]),
                              ],
                            ),
                            SizedBox(
                              height: 20.0,
                            ),
                            Row(
                              children: [
                                SizedBox(
                                  width: 40,
                                ),
                                Icon(FontAwesomeIcons.phoneAlt),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(LocationRepository.restaurantPhone[index]),
                              ],
                            ),
                            SizedBox(
                              height: 20.0,
                            ),
                            Row(
                              children: [
                                SizedBox(
                                  width: 40,
                                ),
                                Icon(FontAwesomeIcons.clock),
                                SizedBox(
                                  width: 10,
                                ),
                                Text('星期一  11:00 - 20:00'),
                              ],
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            Row(
                              children: [
                                SizedBox(
                                  width: 74,
                                ),
                                Text('星期二  11:00 - 20:00'),
                              ],
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            Row(
                              children: [
                                SizedBox(
                                  width: 74,
                                ),
                                Text('星期三  11:00 - 20:00'),
                              ],
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            Row(
                              children: [
                                SizedBox(
                                  width: 74,
                                ),
                                Text('星期四  11:00 - 20:00'),
                              ],
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            Row(
                              children: [
                                SizedBox(
                                  width: 74,
                                ),
                                Text('星期五  11:00 - 20:00'),
                              ],
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            Row(
                              children: [
                                SizedBox(
                                  width: 74,
                                ),
                                Text('星期六  11:00 - 20:00'),
                              ],
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            Row(
                              children: [
                                SizedBox(
                                  width: 74,
                                ),
                                Text('星期日  休息'),
                              ],
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 20.0),
                              width: 300,
                              height: 200,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: new BorderRadius.all(
                                  Radius.circular(10.0),
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  LocationRepository.restaurantIntroduction[index],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Center(
                child: SingleChildScrollView(
                  child: Container(
                    height: MediaQuery.of(context).size.height,
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
                        ShareArticle('hi22556', '有機食材烹煮無菜單定...',
                            'images/element/test.jpeg'),
                        ShareArticle('hi22556', '有機食材烹煮無菜單定...',
                            'images/element/test.jpeg'),
                        ShareArticle('hi22556', '有機食材烹煮無菜單定...',
                            'images/element/test.jpeg'),
                        ShareArticle('hi22556', '有機食材烹煮無菜單定...',
                            'images/element/test.jpeg'),
                        ShareArticle('hi22556', '有機食材烹煮無菜單定...',
                            'images/element/test.jpeg'),
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
  Widget spotView(BuildContext context,int index){
    return DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: Scaffold(
        // resizeToAvoidBottomInset: false,
        endDrawer: CreateMenu(context, widget.token),
        body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxScrolled) => [
            SliverAppBar(
              pinned: true,
              backgroundColor: Color.fromRGBO(222, 215, 209, 1),
              elevation: 0,
              leading: IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: Icon(
                  Icons.arrow_back_rounded,
                  color: Colors.black,
                  size: 40,
                ),
              ),
              toolbarHeight: 120,
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
                child: TabBar(
                  labelColor: Colors.black,
                  indicatorColor: Colors.blueGrey,
                  tabs: <Widget>[
                    Tab(
                      child: Text('店家資訊'),
                    ),
                    Tab(
                      child: Text('分享文'),
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
                  child: Column(
                    children: [
                      Container(
                        color: Color.fromRGBO(222, 215, 209, 1),
                        height: MediaQuery.of(context).size.height + 300,
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          children: [
                            SizedBox(
                              height: 20,
                            ),
                            CarouselSlider(
                              options: CarouselOptions(
                                  height: 160.0,
                                  aspectRatio: 2.0,
                                  enlargeCenterPage: true,
                                  scrollDirection: Axis.horizontal,
                                  onPageChanged: (index, reason) {
                                    setState(() {
                                      currentPos = index;
                                    });
                                  }),
                              items: [1,2,3,4,5].map((i) {
                                return Builder(
                                  builder: (BuildContext context) {
                                    return Container(
                                      width: MediaQuery.of(context).size.width / 1.5,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                          BorderRadius.circular(10),
                                          color:
                                          Color.fromRGBO(198, 201, 203, 1)),
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
                            buildDots(currentPos, [1, 2, 3, 4, 5]),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              children: [
                                SizedBox(
                                  width: 40,
                                ),
                                Text(
                                  // state.restaurants.data[index].name,
                                  LocationRepository.spotName[index],
                                  style: TextStyle(fontSize: 18),
                                ),
                                Spacer(),
                                IconButton(
                                  onPressed: () {
                                    print(LocationRepository.spotIntroduction[index]);
                                    print('press');
                                    setState(() {
                                      heartIsPressed = !heartIsPressed;
                                    });
                                  },
                                  icon: Icon(
                                    heartIsPressed
                                        ? Icons.favorite
                                        : Icons.favorite_border,
                                    color: Colors.redAccent,
                                    size: 40,
                                  ),
                                ),
                                SizedBox(width: 40),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                SizedBox(
                                  width: 40,
                                ),
                                Icon(
                                  Icons.star,
                                  color: Color.fromRGBO(241, 208, 10, 1),
                                ),
                                Icon(
                                  Icons.star,
                                  color: Color.fromRGBO(241, 208, 10, 1),
                                ),
                                Icon(
                                  Icons.star,
                                  color: Color.fromRGBO(241, 208, 10, 1),
                                ),
                                Icon(
                                  Icons.star,
                                  color: Color.fromRGBO(241, 208, 10, 1),
                                ),
                                Icon(
                                  Icons.star_half,
                                  color: Color.fromRGBO(241, 208, 10, 1),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(LocationRepository.spotAvgScore[index]),
                                Spacer(),
                                Container(
                                  width: 48,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Color.fromRGBO(184, 197, 181, 1),
                                    border: Border.all(
                                        color: Color.fromRGBO(169, 179, 146, 1),
                                        width: 3.0),
                                  ),
                                  child: IconButton(
                                    onPressed: () {
                                      showDialog<String>(
                                        barrierDismissible: false,
                                        context: context,
                                        builder: (BuildContext context) =>
                                            AlertDialog(
                                              title: Text('新增評分'),
                                              content: RatingBar.builder(
                                                initialRating: 2.5,
                                                minRating: 1,
                                                direction: Axis.horizontal,
                                                allowHalfRating: true,
                                                itemSize: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                    9,
                                                itemCount: 5,
                                                itemPadding: EdgeInsets.symmetric(
                                                    horizontal: 2.0),
                                                itemBuilder: (context, _) => Icon(
                                                  Icons.star,
                                                  color: Color.fromRGBO(
                                                      241, 208, 10, 1),
                                                ),
                                                onRatingUpdate: (rating) {
                                                  print(rating);
                                                },
                                              ),
                                              actions: <Widget>[
                                                TextButton(
                                                  onPressed: () =>
                                                      Navigator.pop(context, '取消'),
                                                  child: const Text('取消'),
                                                ),
                                                TextButton(
                                                  onPressed: () =>
                                                      Navigator.pop(context, '送出'),
                                                  child: const Text('送出'),
                                                ),
                                              ],
                                            ),
                                      );
                                    },
                                    icon: Icon(FontAwesomeIcons.plus),
                                  ),
                                ),
                                SizedBox(width: 35),
                              ],
                            ),
                            SizedBox(
                              height: 20.0,
                            ),
                            Row(
                              children: [
                                SizedBox(
                                  width: 40,
                                ),
                                Icon(FontAwesomeIcons.mapMarkerAlt),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(LocationRepository.spotAddress[index]),
                              ],
                            ),
                            SizedBox(
                              height: 20.0,
                            ),
                            Row(
                              children: [
                                SizedBox(
                                  width: 40,
                                ),
                                Icon(FontAwesomeIcons.phoneAlt),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(LocationRepository.spotPhone[index]),
                              ],
                            ),
                            SizedBox(
                              height: 20.0,
                            ),
                            Row(
                              children: [
                                SizedBox(
                                  width: 40,
                                ),
                                Icon(FontAwesomeIcons.clock),
                                SizedBox(
                                  width: 10,
                                ),
                                Text('星期一  11:00 - 20:00'),
                              ],
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            Row(
                              children: [
                                SizedBox(
                                  width: 74,
                                ),
                                Text('星期二  11:00 - 20:00'),
                              ],
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            Row(
                              children: [
                                SizedBox(
                                  width: 74,
                                ),
                                Text('星期三  11:00 - 20:00'),
                              ],
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            Row(
                              children: [
                                SizedBox(
                                  width: 74,
                                ),
                                Text('星期四  11:00 - 20:00'),
                              ],
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            Row(
                              children: [
                                SizedBox(
                                  width: 74,
                                ),
                                Text('星期五  11:00 - 20:00'),
                              ],
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            Row(
                              children: [
                                SizedBox(
                                  width: 74,
                                ),
                                Text('星期六  11:00 - 20:00'),
                              ],
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            Row(
                              children: [
                                SizedBox(
                                  width: 74,
                                ),
                                Text('星期日  休息'),
                              ],
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 20.0),
                              width: 300,
                              height: 200,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: new BorderRadius.all(
                                  Radius.circular(10.0),
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  LocationRepository.spotIntroduction[index],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Center(
                child: SingleChildScrollView(
                  child: Container(
                    height: MediaQuery.of(context).size.height,
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
                        ShareArticle('hi22556', '有機食材烹煮無菜單定...',
                            'images/element/test.jpeg'),
                        ShareArticle('hi22556', '有機食材烹煮無菜單定...',
                            'images/element/test.jpeg'),
                        ShareArticle('hi22556', '有機食材烹煮無菜單定...',
                            'images/element/test.jpeg'),
                        ShareArticle('hi22556', '有機食材烹煮無菜單定...',
                            'images/element/test.jpeg'),
                        ShareArticle('hi22556', '有機食材烹煮無菜單定...',
                            'images/element/test.jpeg'),
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
  Widget lodgingView(BuildContext context,int index){
    return DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: Scaffold(
        // resizeToAvoidBottomInset: false,
        endDrawer: CreateMenu(context, widget.token),
        body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxScrolled) => [
            SliverAppBar(
              pinned: true,
              backgroundColor: Color.fromRGBO(222, 215, 209, 1),
              elevation: 0,
              leading: IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: Icon(
                  Icons.arrow_back_rounded,
                  color: Colors.black,
                  size: 40,
                ),
              ),
              toolbarHeight: 120,
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
                child: TabBar(
                  labelColor: Colors.black,
                  indicatorColor: Colors.blueGrey,
                  tabs: <Widget>[
                    Tab(
                      child: Text('店家資訊'),
                    ),
                    Tab(
                      child: Text('分享文'),
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
                  child: Column(
                    children: [
                      Container(
                        color: Color.fromRGBO(222, 215, 209, 1),
                        height: MediaQuery.of(context).size.height + 300,
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          children: [
                            SizedBox(
                              height: 20,
                            ),
                            CarouselSlider(
                              options: CarouselOptions(
                                  height: 160.0,
                                  aspectRatio: 2.0,
                                  enlargeCenterPage: true,
                                  scrollDirection: Axis.horizontal,
                                  onPageChanged: (index, reason) {
                                    setState(() {
                                      currentPos = index;
                                    });
                                  }),
                              items: [1,2,3,4,5].map((i) {
                                return Builder(
                                  builder: (BuildContext context) {
                                    return Container(
                                      width: MediaQuery.of(context).size.width / 1.5,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                          BorderRadius.circular(10),
                                          color:
                                          Color.fromRGBO(198, 201, 203, 1)),
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
                            buildDots(currentPos, [1, 2, 3, 4, 5]),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              children: [
                                SizedBox(
                                  width: 40,
                                ),
                                Text(
                                  // state.restaurants.data[index].name,
                                  LocationRepository.lodgingName[index],
                                  style: TextStyle(fontSize: 18),
                                ),
                                Spacer(),
                                IconButton(
                                  onPressed: () {
                                    print(LocationRepository.lodgingIntroduction[index]);
                                    print('press');
                                    setState(() {
                                      heartIsPressed = !heartIsPressed;
                                    });
                                  },
                                  icon: Icon(
                                    heartIsPressed
                                        ? Icons.favorite
                                        : Icons.favorite_border,
                                    color: Colors.redAccent,
                                    size: 40,
                                  ),
                                ),
                                SizedBox(width: 40),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                SizedBox(
                                  width: 40,
                                ),
                                Icon(
                                  Icons.star,
                                  color: Color.fromRGBO(241, 208, 10, 1),
                                ),
                                Icon(
                                  Icons.star,
                                  color: Color.fromRGBO(241, 208, 10, 1),
                                ),
                                Icon(
                                  Icons.star,
                                  color: Color.fromRGBO(241, 208, 10, 1),
                                ),
                                Icon(
                                  Icons.star,
                                  color: Color.fromRGBO(241, 208, 10, 1),
                                ),
                                Icon(
                                  Icons.star_half,
                                  color: Color.fromRGBO(241, 208, 10, 1),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(LocationRepository.lodgingAvgScore[index]),
                                Spacer(),
                                Container(
                                  width: 48,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Color.fromRGBO(184, 197, 181, 1),
                                    border: Border.all(
                                        color: Color.fromRGBO(169, 179, 146, 1),
                                        width: 3.0),
                                  ),
                                  child: IconButton(
                                    onPressed: () {
                                      showDialog<String>(
                                        barrierDismissible: false,
                                        context: context,
                                        builder: (BuildContext context) =>
                                            AlertDialog(
                                              title: Text('新增評分'),
                                              content: RatingBar.builder(
                                                initialRating: 2.5,
                                                minRating: 1,
                                                direction: Axis.horizontal,
                                                allowHalfRating: true,
                                                itemSize: MediaQuery.of(context).size.width / 9,
                                                itemCount: 5,
                                                itemPadding: EdgeInsets.symmetric(
                                                    horizontal: 2.0),
                                                itemBuilder: (context, _) => Icon(
                                                  Icons.star,
                                                  color: Color.fromRGBO(241, 208, 10, 1),
                                                ),
                                                onRatingUpdate: (rating) {
                                                  print(rating);
                                                },
                                              ),
                                              actions: <Widget>[
                                                TextButton(
                                                  onPressed: () =>
                                                      Navigator.pop(context, '取消'),
                                                  child: const Text('取消'),
                                                ),
                                                TextButton(
                                                  onPressed: () =>
                                                      Navigator.pop(context, '送出'),
                                                  child: const Text('送出'),
                                                ),
                                              ],
                                            ),
                                      );
                                    },
                                    icon: Icon(FontAwesomeIcons.plus),
                                  ),
                                ),
                                SizedBox(width: 35),
                              ],
                            ),
                            SizedBox(
                              height: 20.0,
                            ),
                            Row(
                              children: [
                                SizedBox(
                                  width: 40,
                                ),
                                Icon(FontAwesomeIcons.mapMarkerAlt),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(LocationRepository.lodgingAddress[index]),
                              ],
                            ),
                            SizedBox(
                              height: 20.0,
                            ),
                            Row(
                              children: [
                                SizedBox(
                                  width: 40,
                                ),
                                Icon(FontAwesomeIcons.phoneAlt),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(LocationRepository.lodgingPhone[index]),
                              ],
                            ),
                            SizedBox(
                              height: 20.0,
                            ),
                            Row(
                              children: [
                                SizedBox(
                                  width: 40,
                                ),
                                Icon(FontAwesomeIcons.clock),
                                SizedBox(
                                  width: 10,
                                ),
                                Text('星期一  11:00 - 20:00'),
                              ],
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            Row(
                              children: [
                                SizedBox(
                                  width: 74,
                                ),
                                Text('星期二  11:00 - 20:00'),
                              ],
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            Row(
                              children: [
                                SizedBox(
                                  width: 74,
                                ),
                                Text('星期三  11:00 - 20:00'),
                              ],
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            Row(
                              children: [
                                SizedBox(
                                  width: 74,
                                ),
                                Text('星期四  11:00 - 20:00'),
                              ],
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            Row(
                              children: [
                                SizedBox(
                                  width: 74,
                                ),
                                Text('星期五  11:00 - 20:00'),
                              ],
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            Row(
                              children: [
                                SizedBox(
                                  width: 74,
                                ),
                                Text('星期六  11:00 - 20:00'),
                              ],
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            Row(
                              children: [
                                SizedBox(
                                  width: 74,
                                ),
                                Text('星期日  休息'),
                              ],
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 20.0),
                              width: 300,
                              height: 200,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: new BorderRadius.all(
                                  Radius.circular(10.0),
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  LocationRepository.lodgingIntroduction[index],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Center(
                child: SingleChildScrollView(
                  child: Container(
                    height: MediaQuery.of(context).size.height,
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
                        ShareArticle('hi22556', '有機食材烹煮無菜單定...',
                            'images/element/test.jpeg'),
                        ShareArticle('hi22556', '有機食材烹煮無菜單定...',
                            'images/element/test.jpeg'),
                        ShareArticle('hi22556', '有機食材烹煮無菜單定...',
                            'images/element/test.jpeg'),
                        ShareArticle('hi22556', '有機食材烹煮無菜單定...',
                            'images/element/test.jpeg'),
                        ShareArticle('hi22556', '有機食材烹煮無菜單定...',
                            'images/element/test.jpeg'),
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
