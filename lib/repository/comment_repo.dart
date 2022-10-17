import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:ones_blog/model/comment_model.dart';
import 'package:ones_blog/model/post_model.dart';

class CommentRepository {
  Future<CommentModel> fetchComment() async {
    try{
      Uri uri = Uri.http('onesblog.herokuapp.com', '/api/posts/$post/comments',
          {'limit': '10', 'page': '1'});
      print(uri);
      http.Response response =
      await http.get(uri, headers: {'Accept' : 'application/json'});//發送請求
      if(response.statusCode == 200){
        final jsonData = jsonDecode(response.body);
        CommentModel comment = CommentModel.fromJson(jsonData);
        return comment;
      }else{
        throw Exception("Failed to load");
      }
      // final String response = await rootBundle.loadString('assets/raw/comments.json');
      // final data = await json.decode(response);
      // CommentModel comments = CommentModel.fromJson(data);
      // return comments;
    }catch(e){
      print(e);
      throw e;
    }
  }
}