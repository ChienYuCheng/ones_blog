import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ones_blog/BecomeStore.dart';
import 'package:ones_blog/UserInformation.dart';
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
                onPressed: () => Navigator.of(context).pop(),
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
                  buildMenuButton(
                      Icons.leaderboard_rounded, '排行榜', context, Leaderboard()),
                  buildMenuButton(
                      FontAwesomeIcons.comments, '社群', context, Community()),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  buildMenuButton(
                      FontAwesomeIcons.infoCircle, '關於我們', context, AboutUs()),
                  buildMenuButton(FontAwesomeIcons.userCircle, '個人資訊', context,
                      UserInformation()),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  buildMenuButton(
                      FontAwesomeIcons.store, '成為店家', context, BecomeStore()),
                  buildMenuButton(
                      FontAwesomeIcons.signOutAlt, '登出', context, HomePage()),
                ],
              ),
            ],
          ),
        ],
      ),
    ),
  );
}
