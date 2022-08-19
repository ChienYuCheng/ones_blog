import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ones_blog/ArticleComments.dart';
import 'package:ones_blog/bloc/post_bloc.dart';
import 'package:ones_blog/model/post_model.dart';
import 'package:ones_blog/repository/post_repo.dart';
import 'Constant.dart';
import 'CreateMenu.dart';
import 'bloc/post_event.dart';
import 'bloc/post_state.dart';

class ArticleContent extends StatefulWidget {
  final int index;
  ArticleContent({required this.index});
  // final Data post;
  //
  // const ArticleContent(this.post);

  @override
  _ArticleContentState createState() => _ArticleContentState();
}

class _ArticleContentState extends State<ArticleContent> {
  bool bookMarkIsPressed = false;
  late PostBloc bloc;
  String category = "";

  @override
  void initState() {
    super.initState();
    bloc = BlocProvider.of<PostBloc>(context);
    bloc.add(DoFetchEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: CreateMenu(context),
      body: BlocBuilder<PostBloc, PostState>(
        builder: (context, state) {
          if(state is LoadingState){
            return CircularProgressIndicator();
          }else if(state is FetchSuccess){
            if(state.posts.data[widget.index].categoryId == 1){
              category = "餐廳專區";
            }else if(state.posts.data[widget.index].categoryId == 2){
              category = "景點專區";
            }else{
              category = "旅宿專區";
            }
            return NestedScrollView(
              headerSliverBuilder: (context, innerBoxScrolled) => [
                SliverAppBar(
                  pinned: true,
                  backgroundColor: Color.fromRGBO(222, 215, 209, 1),
                  elevation: 0,
                  leading: IconButton(
                    onPressed: () {
                      Navigator.pop(
                        context,
                      );
                    },
                    icon: Icon(
                      Icons.arrow_back_rounded,
                      color: Colors.black,
                      size: 40,
                    ),
                  ),
                  toolbarHeight: 70,
                  actions: [
                    Builder(
                      builder: (context) => IconButton(
                        icon: Image.asset('images/element/menu.png'),
                        iconSize: 70,
                        onPressed: () => Scaffold.of(context).openEndDrawer(),
                      ),
                    ),
                  ],
                ),
              ],
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      color: Color.fromRGBO(222, 215, 209, 1),
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              CircleAvatar(
                                radius: 35,
                                backgroundColor: Colors.white,
                                child: ClipOval(
                                  child: Image.asset('images/element/member.png'),
                                ),
                              ),
                              Column(
                                children: [
                                  Text(
                                    state.posts.data[widget.index].user.name,
                                    style: contextStyle,
                                  ),
                                  SizedBox(
                                    height: 20.0,
                                  ),
                                  Text(
                                    category,
                                    style: TextStyle(
                                        fontSize: 14, color: Colors.grey[600]),
                                  ),
                                ],
                              ),
                              IconButton(
                                onPressed: () {
                                  setState(() {
                                    bookMarkIsPressed = !bookMarkIsPressed;
                                  });
                                },
                                icon: Icon(
                                  bookMarkIsPressed
                                      ? Icons.bookmark
                                      : Icons.bookmark_border,
                                  size: 40,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width: 30.0,
                              ),
                              Expanded(
                                child: Text(
                                  state.posts.data[widget.index].title,
                                  style: titleStyle,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width: 30.0,
                              ),
                              Icon(
                                FontAwesomeIcons.mapMarkerAlt,
                                color: Colors.redAccent,
                              ),
                              SizedBox(
                                width: 10.0,
                              ),
                              Text(
                                '禾豐田食',
                                style: contextStyle,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                Text(
                                  // '- 吃飯的日嚐\n- 生活的日常\n- 土地的日藏\n一間披著名為餐廳的「日常站」\n- 吃飯的日嚐\n- 生活的日常\n- 土地的日藏- 生活的日常\n- 土地的日藏\n一間披著名為餐廳的「日常站」\n- 吃飯的日嚐\n- 生活的日常\n- 土地的日藏\n- 土地的日藏- 生活的日常\n- 土地的日藏\n一間披著名為餐廳的「日常站」\n- 吃飯的日嚐\n- 生活的日常\n- 土地的日藏\n- 土地的日藏- 生活的日常\n- 土地的日藏\n一間披著名為餐廳的「日常站」\n- 吃飯的日嚐\n- 生活的日常\n- 土地的日藏\n- 土地的日藏- 生活的日常',
                                    state.posts.data[widget.index].content,
                                    style: contextStyle),
                                SizedBox(
                                  height: 20.0,
                                ),
                                Row(
                                  children: [
                                    SizedBox(
                                      width: 30.0,
                                    ),
                                    Text(
                                      state.posts.data[widget.index].publishedAt,
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.grey[600]),
                                    ),
                                  ],
                                ),
                                Container(
                                  margin:
                                  EdgeInsets.only(top: 10.0, bottom: 10.0),
                                  height: 2.0,
                                  width: MediaQuery.of(context).size.width - 20,
                                  color: Colors.white,
                                ),
                                Row(
                                  children: [
                                    Spacer(),
                                    TextButton(
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                ArticleComments(),
                                            maintainState: false,
                                          ),
                                        );
                                      },
                                      child: Row(
                                        children: [
                                          Icon(FontAwesomeIcons.comment,
                                              color: Colors.black),
                                          SizedBox(
                                            width: 5.0,
                                          ),
                                          Text(
                                            '33則留言',
                                            style: contextStyle,
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10.0,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }else if(state is ErrorState){
            return ErrorWidget(state.message.toString());
          }
          return Container();
        },
      ),
    );
  }
}

