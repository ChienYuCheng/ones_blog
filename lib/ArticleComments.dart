import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ones_blog/bloc/post_bloc.dart';
import 'package:ones_blog/function/CreateComment.dart';
import 'Constant.dart';
import 'CreateMenu.dart';
import 'bloc/comment_bloc.dart';
import 'bloc/post_state.dart';
import 'function/CreateArticle.dart';

class ArticleComments extends StatefulWidget {
  const ArticleComments({Key? key}) : super(key: key);

  @override
  _ArticleCommentsState createState() => _ArticleCommentsState();
}

class _ArticleCommentsState extends State<ArticleComments> {
  bool bookMarkIsPressed = false;
  final myController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      endDrawer: CreateMenu(context),
      body: NestedScrollView(
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
        body: Container(
          color: Color.fromRGBO(222, 215, 209, 1),
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              Expanded(
                child: BlocBuilder<CommentBloc, CommentState>(
                  builder: (context, state){
                    if(state is LoadingComment){
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }else if(state is FetchedComment){
                      return ListView.builder(
                        itemCount: state.comments.data.length,
                        itemBuilder: (BuildContext context, int index) {
                        return new Column(
                          children: [
                            createComment(
                                state.comments.data[index].userId.toString(),
                                state.comments.data[index].content,
                                state.comments.data[index].postId.toString(),
                                context),
                          ],
                        );
                      },
                    );
                    }else if(state is CommentError){
                      return ErrorWidget(state.message.toString());
                    }
                  return Container();
                },
                )
              ),
              ListTile(
                title: TextField(
                  controller: myController,
                  decoration: InputDecoration(
                    hintText: '留言...',
                    suffixIcon: IconButton(
                      icon: Icon(Icons.send_rounded),
                      onPressed: (){
                        setState(() {

                        });
                      },
                    ),
                  ),
                ),
              ),
              Text(myController.text.toString(),),
            ],
          ),
        ),
      ),
    );
  }
}

// Container(
// color: Color.fromRGBO(222, 215, 209, 1),
// width: MediaQuery.of(context).size.width,
// child: Column(
// children: [
// Expanded(
// child: ListView.builder(
// itemCount: 10,
// itemBuilder: (BuildContext context, int index){
// return createComment('hi22556', '這家餐廳好好吃！！食材用的很實在，真的是好食在啊哈哈哈XD\n下次還要再來吃~~~', '2022年8月21日', context);
// },
// ),
// ),
// Container(
// padding: EdgeInsets.symmetric(horizontal: 8),
// height: 50,
// child: Row(
// children: [
// SizedBox(
// width: 20,
// ),
// Expanded(
// child: TextField(
// decoration:
// InputDecoration.collapsed(hintText: '留言...'),
// textCapitalization: TextCapitalization.sentences,
// ),
// ),
// IconButton(
// icon: Icon(Icons.send_rounded),
// iconSize: 25,
// color: Colors.black,
// onPressed: () {}),
// ],
// ),
// ),
// ],
// ),
// ),