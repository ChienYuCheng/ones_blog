import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:ones_blog/model/post_model.dart';

class PostRepository {
  Future<List<PostModel>> fetchPosts() async {
    try{
      Uri uri = Uri.https('onesblog.herokuapp.com', '/api/posts',
          {'category_id': '2', 'limit': '10', 'page': '1'});
      print(uri);
      http.Response response =
          await http.get(uri, headers: {'Accept' : 'application.json'});//發送請求
      final jsonData = json.decode(response.body);
      print(response.body);
      PostModel posts = PostModel.fromJson(jsonData);
      return <PostModel>[posts];
    }catch(e){
      print(e);
      throw e;
    }
  }
}
// Future<List<PostModel>> fetchPosts() async{
//   try{
//     String jsonData = await rootBundle.loadString('assets/raw/posts.json'); //載入原始json字串
//     final response = json.decode(jsonData) as Map<String, dynamic>; //解碼得到的原始json字串
//     PostModel posts = PostModel.fromJson(response);
//     return <PostModel>[posts];
//   }catch(e){
//     print(e);
//     throw e;
//   }
// }