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
import 'package:ones_blog/model/location_model.dart';
import 'package:ones_blog/repository/location_repo.dart';
import 'CreateMenu.dart';
import 'bloc/all_restaurant_bloc.dart';
import 'bloc/all_spot_bloc.dart';
import 'bloc/location_bloc.dart';
import 'bloc/lodging_bloc.dart';
import 'bloc/restaurant_bloc.dart';
import 'bloc/spot_bloc.dart';
import 'function/BuildButton.dart';
import 'function/PlaceElement.dart';
import 'function/BuildDots.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  String token;
  HomePage({required this.token});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  late RestaurantBloc restaurantBloc;
  late SpotBloc spotBloc;
  late LodgingBloc lodgingBloc;

  bool _verticalList = true;
  ScrollController _scrollController = ScrollController();
  int restaurantCurrentPos = 0, spotsCurrentPos = 0, lodgingCurrentPos = 0;

  @override
  void initState() {
    super.initState();
    print(widget.token);
    restaurantBloc = BlocProvider.of<RestaurantBloc>(context);
    restaurantBloc.add(FetchRestaurantEvent());
    spotBloc = BlocProvider.of<SpotBloc>(context);
    spotBloc.add(FetchSpotEvent());
    lodgingBloc = BlocProvider.of<LodgingBloc>(context);
    lodgingBloc.add(FetchLodgingEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      endDrawer: CreateMenu(context,widget.token),
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
                        buildButtionPush(
                            '餐廳', 80, 48, context,
                            BlocProvider<LocationBloc>(
                              create: (context) => LocationBloc(LocationRepository()),
                              child: RestaurantArea(token: widget.token,),
                            )),
                        buildButtionPush(
                            '景點', 80, 48, context,
                            BlocProvider<LocationBloc>(
                              create: (context) => LocationBloc(LocationRepository()),
                              child: SpotsArea(token: widget.token,),
                            )),
                        buildButtionPush(
                            '旅宿', 80, 48, context,
                            BlocProvider<LocationBloc>(
                              create: (context) => LocationBloc(LocationRepository()),
                              child: LodgingArea(token: widget.token),
                            )),
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
                    BlocBuilder<RestaurantBloc,RestaurantState>(
                      builder: (context,state){
                        if (state is LoadingRestaurant) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }else if(state is FetchedRestaurant){
                          return CarouselSlider.builder(
                            itemCount: 5,
                            itemBuilder: (BuildContext context, int itemIndex, int pageIndex){
                              return Container(
                                padding: EdgeInsets.all(10.0),
                                width: MediaQuery.of(context).size.width / 1.5,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Color.fromRGBO(198, 201, 203, 1)),
                                child: GestureDetector(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text(
                                        state.restaurants.data[itemIndex].name,
                                        style: TextStyle(fontSize: 16.0),
                                      ),
                                      SizedBox(
                                        height: 20.0,
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            width: 100,
                                            child: Text(
                                              state.restaurants.data[itemIndex].address,
                                              maxLines: 1,
                                              // overflow: TextOverflow.ellipsis,
                                              style: TextStyle(fontSize: 16.0),
                                            ),
                                          ),
                                          Row(
                                            children: [
                                              Icon(
                                                Icons.star,
                                                color: Color.fromRGBO(241, 208, 10, 1),
                                              ),
                                              Text(
                                                state.restaurants.data[itemIndex].avgScore,
                                                style: TextStyle(fontSize: 16.0),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                BlocProvider(
                                                  create: (context) =>
                                                      RestaurantBloc(LocationRepository()),
                                                  child: StoreInformation(
                                                    index: itemIndex,
                                                    token: widget.token,
                                                    categoryId: state.restaurants.data[itemIndex].categoryId,
                                                  ),
                                                )));
                                  },
                                ),
                              );
                            },
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
                            // items: LocationRepository.restaurantName.map((i) {
                            //   return Builder(
                            //     builder: (BuildContext context) {
                            //       return Container(
                            //         width: MediaQuery.of(context).size.width / 1.5,
                            //         decoration: BoxDecoration(
                            //             borderRadius: BorderRadius.circular(10),
                            //             color: Color.fromRGBO(198, 201, 203, 1)),
                            //         child: GestureDetector(
                            //           child: Text(
                            //             '$i',
                            //             style: TextStyle(fontSize: 16.0),
                            //           ),
                            //           onTap: () {
                            //             Navigator.push(
                            //                 context,
                            //                 MaterialPageRoute(
                            //                     builder: (context) =>
                            //                         BlocProvider(
                            //                           create: (context) =>
                            //                               RestaurantBloc(LocationRepository()),
                            //                           child: StoreInformation(
                            //                             index: LocationRepository.restaurantName.indexOf(i),
                            //                           ),
                            //                         )));
                            //           },
                            //         ),
                            //       );
                            //     },
                            //   );
                            // }).toList(),
                          );
                        }else if(state is RestaurantError){
                          return ErrorWidget(state.message.toString());
                        }
                        return Container();
                      },
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    buildDots(restaurantCurrentPos, [1,2,3,4,5]),
                    buildButtionPush(
                        "看更多",
                        MediaQuery.of(context).size.width / 2,
                        48,
                        context,
                        BlocProvider<LocationBloc>(
                          create: (context) =>
                              LocationBloc(LocationRepository()),
                          child: RestaurantArea(token: widget.token),
                        )),
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
                    BlocBuilder<SpotBloc,SpotState>(
                      builder: (context,state){
                        if (state is LoadingSpot) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }else if(state is FetchedSpot){
                          return CarouselSlider.builder(
                            itemCount: 2,
                            itemBuilder: (BuildContext context, int itemIndex, int pageIndex){
                              return Container(
                                padding: EdgeInsets.all(10.0),
                                width: MediaQuery.of(context).size.width / 1.5,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Color.fromRGBO(198, 201, 203, 1)),
                                child: GestureDetector(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text(
                                        state.spots.data[itemIndex].name,
                                        style: TextStyle(fontSize: 16.0),
                                      ),
                                      SizedBox(
                                        height: 20.0,
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            width: 100,
                                            child: Text(
                                              state.spots.data[itemIndex].address,
                                              maxLines: 1,
                                              // overflow: TextOverflow.ellipsis,
                                              style: TextStyle(fontSize: 16.0),
                                            ),
                                          ),
                                          Row(
                                            children: [
                                              Icon(
                                                Icons.star,
                                                color: Color.fromRGBO(241, 208, 10, 1),
                                              ),
                                              Text(
                                                state.spots.data[itemIndex].avgScore,
                                                style: TextStyle(fontSize: 16.0),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                BlocProvider(
                                                  create: (context) =>
                                                      RestaurantBloc(LocationRepository()),
                                                  child: StoreInformation(
                                                    index: itemIndex,
                                                    token: widget.token,
                                                    categoryId: state.spots.data[itemIndex].categoryId,
                                                  ),
                                                )));
                                  },
                                ),
                              );
                            },
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
                            // items: LocationRepository.restaurantName.map((i) {
                            //   return Builder(
                            //     builder: (BuildContext context) {
                            //       return Container(
                            //         width: MediaQuery.of(context).size.width / 1.5,
                            //         decoration: BoxDecoration(
                            //             borderRadius: BorderRadius.circular(10),
                            //             color: Color.fromRGBO(198, 201, 203, 1)),
                            //         child: GestureDetector(
                            //           child: Text(
                            //             '$i',
                            //             style: TextStyle(fontSize: 16.0),
                            //           ),
                            //           onTap: () {
                            //             Navigator.push(
                            //                 context,
                            //                 MaterialPageRoute(
                            //                     builder: (context) =>
                            //                         BlocProvider(
                            //                           create: (context) =>
                            //                               RestaurantBloc(LocationRepository()),
                            //                           child: StoreInformation(
                            //                             index: LocationRepository.restaurantName.indexOf(i),
                            //                           ),
                            //                         )));
                            //           },
                            //         ),
                            //       );
                            //     },
                            //   );
                            // }).toList(),
                          );
                        }else if(state is SpotError){
                          return ErrorWidget(state.message.toString());
                        }
                        return Container();
                      },
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    buildDots(spotsCurrentPos, [1,2,3,4,5]),
                    buildButtionPush(
                        "看更多", MediaQuery.of(context).size.width / 2, 48, context, BlocProvider<LocationBloc>(
                      create: (context) =>
                          LocationBloc(LocationRepository()),
                      child: SpotsArea(token: widget.token),
                    )),
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
                    BlocBuilder<LodgingBloc,LodgingState>(
                      builder: (context,state){
                        if (state is LoadingLodging) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }else if(state is FetchedLodging){
                          return CarouselSlider.builder(
                            itemCount: 2,
                            itemBuilder: (BuildContext context, int itemIndex, int pageIndex){
                              return Container(
                                padding: EdgeInsets.all(10.0),
                                width: MediaQuery.of(context).size.width / 1.5,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Color.fromRGBO(198, 201, 203, 1)),
                                child: GestureDetector(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text(
                                        state.lodgings.data[itemIndex].name,
                                        style: TextStyle(fontSize: 16.0),
                                      ),
                                      SizedBox(
                                        height: 20.0,
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            width: 100,
                                            child: Text(
                                              state.lodgings.data[itemIndex].address,
                                              maxLines: 1,
                                              // overflow: TextOverflow.ellipsis,
                                              style: TextStyle(fontSize: 16.0),
                                            ),
                                          ),
                                          Row(
                                            children: [
                                              Icon(
                                                Icons.star,
                                                color: Color.fromRGBO(241, 208, 10, 1),
                                              ),
                                              Text(
                                                state.lodgings.data[itemIndex].avgScore,
                                                style: TextStyle(fontSize: 16.0),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                BlocProvider(
                                                  create: (context) =>
                                                      RestaurantBloc(LocationRepository()),
                                                  child: StoreInformation(
                                                    index: itemIndex,
                                                    token: widget.token,
                                                    categoryId: state.lodgings.data[itemIndex].categoryId,
                                                  ),
                                                )));
                                  },
                                ),
                              );
                            },
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
                            // items: LocationRepository.restaurantName.map((i) {
                            //   return Builder(
                            //     builder: (BuildContext context) {
                            //       return Container(
                            //         width: MediaQuery.of(context).size.width / 1.5,
                            //         decoration: BoxDecoration(
                            //             borderRadius: BorderRadius.circular(10),
                            //             color: Color.fromRGBO(198, 201, 203, 1)),
                            //         child: GestureDetector(
                            //           child: Text(
                            //             '$i',
                            //             style: TextStyle(fontSize: 16.0),
                            //           ),
                            //           onTap: () {
                            //             Navigator.push(
                            //                 context,
                            //                 MaterialPageRoute(
                            //                     builder: (context) =>
                            //                         BlocProvider(
                            //                           create: (context) =>
                            //                               RestaurantBloc(LocationRepository()),
                            //                           child: StoreInformation(
                            //                             index: LocationRepository.restaurantName.indexOf(i),
                            //                           ),
                            //                         )));
                            //           },
                            //         ),
                            //       );
                            //     },
                            //   );
                            // }).toList(),
                          );
                        }else if(state is LodgingError){
                          return ErrorWidget(state.message.toString());
                        }
                        return Container();
                      },
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    buildDots(lodgingCurrentPos, [1, 2, 3, 4, 5]),
                    buildButtionPush(
                        "看更多", MediaQuery.of(context).size.width / 2, 48, context, BlocProvider<LocationBloc>(
                      create: (context) =>
                          LocationBloc(LocationRepository()),
                      child: LodgingArea(token: widget.token),
                    )),
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
List<Widget> indicators(imagesLength,currentIndex) {
  return List<Widget>.generate(imagesLength, (index) {
    return Container(
      margin: EdgeInsets.all(3),
      width: 10,
      height: 10,
      decoration: BoxDecoration(
          color: currentIndex == index ? Colors.black : Colors.black26,
          shape: BoxShape.circle),
    );
  });
}