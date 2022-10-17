import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ones_blog/ArticleContent.dart';
import 'package:ones_blog/CreateMenu.dart';
import 'package:ones_blog/model/post_model.dart';
import 'package:ones_blog/repository/post_repo.dart';
import 'AddArticle.dart';
import 'HomePage.dart';
import 'bloc/post_bloc.dart';
import 'bloc/post_event.dart';
import 'bloc/post_state.dart';
import 'function/CreateArticle.dart';

class Community extends StatefulWidget {
  String token;
  Community({required this.token});
  // const Community({Key? key}) : super(key: key);

  @override
  _CommunityState createState() => _CommunityState();
}

class _CommunityState extends State<Community> {

  late PostBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = BlocProvider.of<PostBloc>(context);
    bloc.add(DoFetchEvent());
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 3,
      child: Scaffold(
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
              toolbarHeight: 175,
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
                child: Column(
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          width: 5,
                        ),
                        Container(
                          child: Image.asset(
                            'images/text/communityWord.png',
                            height: 55,
                          ),
                        ),
                      ],
                    ),
                    TabBar(
                      labelColor: Colors.black,
                      indicatorColor: Colors.blueGrey,
                      tabs: <Widget>[
                        Tab(
                          child: Text(
                            '餐廳',
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                        Tab(
                          child: Text(
                            '景點',
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                        Tab(
                          child: Text(
                            '旅宿',
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                      ],
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
                  child: Container(
                    height: MediaQuery.of(context).size.height + 350,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: Color.fromRGBO(222, 215, 209, 1),width: 5),
                      color: Color.fromRGBO(222, 215, 209, 1),
                    ),
                    child: BlocBuilder<PostBloc, PostState>(
                      builder: (context, state){
                        if (state is LoadingState) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        } else if(state is FetchSuccess){
                          return ListView.builder(
                            itemCount: state.posts.data.length,
                            itemBuilder: (context, index){
                              final article = state.posts.data[index];
                              return new Column(
                                children: [
                                  if (state.posts.data[index].locationId == 1)
                                    CreateArticle(article.user.name, article.title, 'images/element/test.jpeg',context,index,widget.token)
                                ],
                              );
                            },
                          );
                        }else if(state is ErrorState){
                          return ErrorWidget(state.message.toString());
                        }
                        return Container();
                      },
                    ),
                  ),
                ),
              ),
              Center(
                child: SingleChildScrollView(
                  child: Container(
                    height: MediaQuery.of(context).size.height + 350,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: Color.fromRGBO(222, 215, 209, 1), width: 5),
                      color: Color.fromRGBO(222, 215, 209, 1),
                    ),
                    child: BlocBuilder<PostBloc, PostState>(
                      builder: (context, state){
                        if(state is LoadingState){
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }else if(state is FetchSuccess){
                          return ListView.builder(
                            itemCount: state.posts.data.length,
                            itemBuilder: (context, index){
                              // print(index.toString());
                              return new Column(
                                children: [
                                  if(state.posts.data[index].locationId == 2)
                                    CreateArticle(state.posts.data[index].user.name, state.posts.data[index].title, 'images/element/test.jpeg', context,index,widget.token)
                                ],
                              );
                            },
                          );
                        }else if(state is ErrorState){
                          return ErrorWidget(state.message.toString());
                        }
                        return Container();
                      },
                    ),
                  ),
                ),
              ),
              Center(
                child: SingleChildScrollView(
                  child: Container(
                    height: MediaQuery.of(context).size.height + 350,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: Color.fromRGBO(222, 215, 209, 1), width: 5),
                      color: Color.fromRGBO(222, 215, 209, 1),
                    ),
                    child: BlocBuilder<PostBloc, PostState>(
                      builder: (context, state){
                        if(state is LoadingState){
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }else if(state is FetchSuccess){
                          return ListView.builder(
                            itemCount: state.posts.data.length,
                            itemBuilder: (context, index){
                              return new Column(
                                children: [
                                  if(state.posts.data[index].locationId == 3)
                                    CreateArticle(state.posts.data[index].user.name, state.posts.data[index].title, 'images/element/test.jpeg', context,index,widget.token)
                                ],
                              );
                            },
                          );
                        }else if(state is ErrorState){
                          return ErrorWidget(state.message.toString());
                        }
                        return Container();
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          elevation: 4,
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => AddArticle(token: widget.token,),
                maintainState: false,
              ),
            );
          },
          backgroundColor: Colors.white,
          child: const Icon(
            FontAwesomeIcons.plus,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}