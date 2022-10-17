import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ones_blog/Leaderboard.dart';
import 'package:ones_blog/LocationInformation.dart';
import 'package:ones_blog/LoginAccount.dart';
import 'package:ones_blog/SignOutMenu.dart';
import 'package:ones_blog/StoreInformation.dart';
import 'AboutUs.dart';
import 'Community.dart';
import 'CreateMenu.dart';
import 'HomePage.dart';
import 'bloc/all_restaurant_bloc.dart';
import 'bloc/location_bloc.dart';
import 'bloc/post_bloc.dart';
import 'bloc/restaurant_bloc.dart';
import 'function/BuildMenuButton.dart';
import 'function/CreateAreaList.dart';

class RestaurantArea extends StatefulWidget {
  String token;
  RestaurantArea({required this.token});
  // const RestaurantArea({Key? key}) : super(key: key);

  @override
  _RestaurantAreaState createState() => _RestaurantAreaState();
}

class _RestaurantAreaState extends State<RestaurantArea> {
  late LocationBloc locationBloc;

  @override
  void initState() {
    super.initState();
    locationBloc = BlocProvider.of<LocationBloc>(context);
    locationBloc.add(FetchLocationEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: CreateMenu(context, widget.token),
      // endDrawer: SignOutMenu(context),
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
                  // SizedBox(
                  //   width: 20,
                  // ),
                  // Image(
                  //   image: AssetImage('images/text/newTaipeiCity.png'),
                  //   height: 55,
                  // ),
                ],
              ),
            ),
          ),
        ],
        body: SingleChildScrollView(
          child: Container(
            color: Color.fromRGBO(222, 215, 209, 1),
            height: MediaQuery.of(context).size.height + 1700,
            width: MediaQuery.of(context).size.width,
            child: BlocBuilder<LocationBloc, LocationState>(
                builder: (context, state) {
              if (state is LoadingLocation) {
                return Column(
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      width: 50,
                      height: 50,
                      child: CircularProgressIndicator(),
                    )
                  ],
                );
              } else if (state is FetchedLocation) {
                return ListView.builder(
                    physics: new NeverScrollableScrollPhysics(),
                    itemCount: state.locations.data.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          if (state.locations.data[index].categoryId == 1)
                            CreateAreaList(
                                state.locations.data[index].name,
                                state.locations.data[index].address,
                                state.locations.data[index].avgScore,
                                'images/element/test.jpeg',
                                context,
                                LocationInformation(
                                  index: index,
                                  token: widget.token,
                                )),
                        ],
                      );
                    });
              } else if (state is LocationError) {
                return ErrorWidget(state.message.toString());
              }
              return Container();
            }),
          ),
        ),
      ),
    );
  }
}