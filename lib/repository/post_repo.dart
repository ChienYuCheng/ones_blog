import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:ones_blog/model/post_model.dart';

class PostRepository {
  Future<PostModel> fetchPosts() async {
    try{
      Uri uri = Uri.https('onesblog.herokuapp.com', '/api/posts',
          {'limit': '10', 'page': '1'});
      print(uri);
      http.Response response =
          await http.get(uri, headers: {'Accept' : 'application.json'});//發送請求
      if(response.statusCode == 200){
        final jsonData = jsonDecode(response.body);
        PostModel posts = PostModel.fromJson(jsonData);
        return posts;
      }else{
        throw Exception("Failed to load");
      }
    }catch(e){
      print(e);
      throw e;
    }
  }
}

// Future<PostModel> fetchPosts() async{
//   try{
//     String jsonData = await rootBundle.loadString('assets/raw/posts.json'); //載入原始json字串
//     final response = json.decode(jsonData) as Map<String, dynamic>; //解碼得到的原始json字串
//     PostModel posts = PostModel.fromJson(response);
//     return posts;
//   }catch(e){
//     print(e);
//     throw e;
//   }
// }