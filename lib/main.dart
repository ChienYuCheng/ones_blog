import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ones_blog/ArticleComments.dart';
import 'package:ones_blog/ArticleContent.dart';
import 'package:ones_blog/BecomeStore.dart';
import 'package:ones_blog/Community.dart';
import 'package:ones_blog/CreateAccount.dart';
import 'package:ones_blog/StoreInformation.dart';
import 'package:ones_blog/bloc/post_bloc.dart';
import 'package:ones_blog/bloc/post_cubit.dart';
import 'package:ones_blog/repository/post_repo.dart';
import 'package:ones_blog/screens/home_screen.dart';
import 'package:ones_blog/services/post_service.dart';
import 'HomePage.dart';
import 'UserInformation.dart';
import 'package:flutter/services.dart';

import 'bloc/post_state.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BlocProvider(
        create: (context) => PostBloc(InitialState(), PostRepository()),
        child: HomeScreen(),
      ),
    );
  }
}
// return BlocProvider(
// create: (context) => PostCubit(),
// child: MaterialApp(
// debugShowCheckedModeBanner: false,
// home: HomeScreen(),
// ),
// )