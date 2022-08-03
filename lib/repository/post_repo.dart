import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:ones_blog/model/post_model.dart';

class PostRepository {
  Future<List<PostModel>> fetchPosts() async{
    // try{
    //   List<PostModel> posts = [];
    //   String response = await rootBundle.loadString('assets/raw/posts.json');
    //   var data = json.decode(response);
    //   data.map((post) => posts.add(PostModel.fromJson(post))).toList();
    //   return posts;
    // }catch(e){
    //   print(e);
    //   throw e;
    // }
    try{
      String jsonData = await rootBundle.loadString('assets/raw/posts.json'); //載入原始json字串
      Map<String, dynamic> response = json.decode(jsonData); //解碼得到的原始json字串
      print(response.runtimeType);
      List<dynamic> postData = response['data'];
      print(postData);
      print("-------");
      print(postData[0]);
      return postData.map((e) => PostModel.fromJson(e)).toList();
    }catch(e){
      print(e);
      throw e;
    }
  }
}