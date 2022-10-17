import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ones_blog/bloc/leader_board_bloc.dart';
import 'package:ones_blog/repository/location_repo.dart';
import 'CreateMenu.dart';
import 'HomePage.dart';
import 'StoreInformation.dart';
import 'function/BuildDots.dart';

class Leaderboard extends StatefulWidget {
  String token;
  Leaderboard({required this.token});
  // const Leaderboard({Key? key}) : super(key: key);

  @override
  _LeaderboardState createState() => _LeaderboardState();
}

class _LeaderboardState extends State<Leaderboard> {
  int restaurantCurrentPos = 0, spotsCurrentPos = 0, lodgingCurrentPos = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: CreateMenu(context,widget.token),
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
                    BlocBuilder<LeaderBoardBloc,LeaderBoardState>(
                      builder: (context,state){
                        if (state is LoadingLeaderBoard) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }else if(state is FetchedLeaderBoard){
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
                                        state.leaderBoards.data[itemIndex].name,
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
                                              state.leaderBoards.data[itemIndex].address,
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
                                                state.leaderBoards.data[itemIndex].avgScore,
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
                                                      LeaderBoardBloc(LocationRepository()),
                                                  child: StoreInformation(
                                                    userId: state.leaderBoards.data[itemIndex].userId,
                                                    index: itemIndex,
                                                    token: widget.token,
                                                    categoryId: state.leaderBoards.data[itemIndex].categoryId,
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
                        }else if(state is LeaderBoardError){
                          return ErrorWidget(state.message.toString());
                        }
                        return Container();
                      },
                    ),
                    // CarouselSlider(
                    //   options: CarouselOptions(
                    //       height: 260.0,
                    //       aspectRatio: 2.0,
                    //       enlargeCenterPage: true,
                    //       scrollDirection: Axis.horizontal,
                    //       onPageChanged: (index, reason) {
                    //         setState(() {
                    //           restaurantCurrentPos = index;
                    //         });
                    //       }),
                    //   items: [1, 2, 3, 4, 5, 6, 7, 8, 9].map((i) {
                    //     return Builder(
                    //       builder: (BuildContext context) {
                    //         return Container(
                    //           width: MediaQuery.of(context).size.width / 1.5,
                    //           decoration: BoxDecoration(
                    //               borderRadius: BorderRadius.circular(10),
                    //               color: Color.fromRGBO(198, 201, 203, 1)),
                    //           child: GestureDetector(
                    //             child: Center(
                    //               child: Text(
                    //                 'text $i',
                    //                 style: TextStyle(fontSize: 16.0),
                    //               ),
                    //             ),
                    //             onTap: (){
                    //               Navigator.push(context, MaterialPageRoute(builder: (context)=>StoreInformation(index: 0,categoryId: 0,)));
                    //             },
                    //           ),
                    //         );
                    //       },
                    //     );
                    //   }).toList(),
                    // ),
                    SizedBox(
                      height: 5,
                    ),
                    buildDots(
                        restaurantCurrentPos, [1, 2, 3, 4, 5, 6, 7, 8, 9]),
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
                              child: GestureDetector(
                                child: Center(
                                  child: Text(
                                    'text $i',
                                    style: TextStyle(fontSize: 16.0),
                                  ),
                                ),
                                onTap: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>StoreInformation(userId: 0,index: 0,token: widget.token,categoryId: 0,)));
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
                              child: GestureDetector(
                                child: Center(
                                  child: Text(
                                    'text $i',
                                    style: TextStyle(fontSize: 16.0),
                                  ),
                                ),
                                onTap: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>StoreInformation(userId: 0,index: 0,token: widget.token,categoryId: 0,)));
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
