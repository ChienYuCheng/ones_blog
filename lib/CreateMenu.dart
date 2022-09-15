import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ones_blog/BecomeStore.dart';
import 'package:ones_blog/UserInformation.dart';
import 'package:ones_blog/bloc/post_bloc.dart';
import 'package:ones_blog/repository/post_repo.dart';
import 'package:ones_blog/service/user_service.dart';
import 'AboutUs.dart';
import 'Community.dart';
import 'HomePage.dart';
import 'Leaderboard.dart';
import 'LoginAccount.dart';
import 'function/BuildMenuButton.dart';

Container CreateMenu(BuildContext context) {
  return Container(
    width: MediaQuery.of(context).size.width,
    child: Container(
      height: MediaQuery.of(context).size.height,
      color: Color.fromRGBO(222, 215, 209, 1),
      child: ListView(
        padding: EdgeInsets.only(top: 30),
        children: [
          Row(
            children: [
              Spacer(),
              IconButton(
                padding: EdgeInsets.only(top: 10, right: 20),
                onPressed: () => Navigator.of(context).pop(context),
                icon: Icon(
                  Icons.clear,
                  size: 40,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            height: 2.0,
            width: MediaQuery.of(context).size.width,
            color: Colors.white,
          ),
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  buildMenuButton('images/element/rank.png', '排行榜', context,
                      Leaderboard(), 40),
                  buildMenuButton(
                      'images/element/community.png',
                      '社群',
                      context,
                      BlocProvider<PostBloc>(
                        create: (context) => PostBloc(PostRepository()),
                        child: Community(),
                      ),
                      40),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  buildMenuButton('images/element/aboutUs.png', '關於我們', context,
                      AboutUs(), 40),
                  buildMenuButton('images/element/login.png', '個人資訊', context,
                      UserInformation(), 40),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  buildMenuButton('images/element/becomeStore.png', '成為店家',
                      context, BecomeStore(), 40),
                  kbuildMenuButtonPop(
                      'images/element/logout.png', '登出', context, () {
                    logout().then((value) => {
                          Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                  builder: (context) => LoginAccount()),
                              (route) => false)
                        });
                  }, 40),
                ],
              ),
            ],
          ),
        ],
      ),
    ),
  );
}
