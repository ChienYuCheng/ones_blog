import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ones_blog/AboutUs.dart';
import 'package:ones_blog/LoginAccount.dart';
import 'package:ones_blog/SignOutMenu.dart';
import 'Community.dart';
import 'CreateMenu.dart';
import 'HomePage.dart';
import 'Leaderboard.dart';
import 'bloc/spot_bloc.dart';
import 'function/BuildMenuButton.dart';
import 'function/CreateAreaList.dart';

class SpotsArea extends StatefulWidget {
  const SpotsArea({Key? key}) : super(key: key);

  @override
  _SpotsAreaState createState() => _SpotsAreaState();
}

class _SpotsAreaState extends State<SpotsArea> {

  late SpotBloc spotBloc;

  @override
  void initState() {
    super.initState();
    spotBloc = BlocProvider.of<SpotBloc>(context);
    spotBloc.add(FetchSpotEvent());
  }

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
                    image: AssetImage('images/text/spots.png'),
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
          child: Container(
            color: Color.fromRGBO(222, 215, 209, 1),
            height: MediaQuery.of(context).size.height + 1700,
            width: MediaQuery.of(context).size.width,
            child: BlocBuilder<SpotBloc, SpotState>(
                builder: (context, state) {
                  if (state is LoadingSpot) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is FetchedSpot){
                    return ListView.builder(
                        physics: new NeverScrollableScrollPhysics(),
                        itemCount: state.spots.data.length,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              CreateAreaList(
                                  state.spots.data[index].name,
                                  state.spots.data[index].address,
                                  state.spots.data[index].avgScore,
                                  'images/element/test.jpeg')
                            ],
                          );
                        });
                  } else if (state is SpotError) {
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
