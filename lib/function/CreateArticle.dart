import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ones_blog/ArticleContent.dart';
import 'package:ones_blog/Constant.dart';
import 'package:ones_blog/bloc/post_bloc.dart';
import 'package:ones_blog/model/post_model.dart';
import 'package:ones_blog/repository/post_repo.dart';

TextButton CreateArticle(String type, String title, String route, BuildContext context,int index,String token) {
  return TextButton(
    onPressed: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: ((context) {
            return BlocProvider<PostBloc>(
              create: (context) => PostBloc(PostRepository()),
              child: ArticleContent(index: index,token: token,),
            );
          }),
          maintainState: false,
        ),
      );
    },
    child: Container(
      // margin: EdgeInsets.only(top: 10.0),
      decoration: BoxDecoration(
        color: Color.fromRGBO(198, 201, 203, 1.0),
        borderRadius: new BorderRadius.all(
          Radius.circular(5.0),
        ),
      ),
      width: 335,
      height: 85,
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  type,
                  style: titleStyle,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  title,
                  style: contextStyle,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ],
            ),
          ),
          // Spacer(),
          ClipRRect(
            borderRadius: BorderRadius.circular(5.0),
            child: Image(
              image: AssetImage(route),
            ),
          ),
        ],
      ),
    ),
  );
}
