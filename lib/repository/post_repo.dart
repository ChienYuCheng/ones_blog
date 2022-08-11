import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:ones_blog/model/post_model.dart';

class PostRepository {
  Future<List<PostModel>> fetchPosts() async{
    try{
      String jsonData = await rootBundle.loadString('assets/raw/posts.json'); //載入原始json字串
      final response = json.decode(jsonData) as Map<String, dynamic>; //解碼得到的原始json字串
      // print(response.runtimeType);
      PostModel posts = PostModel.fromJson(response);
      // print(posts.runtimeType);
      // posts.data.forEach((post) {print("name : ${post.user.name}");});
      // print(posts.links.first);
      // posts.meta.link.forEach((element) {print("url: ${element.label}");});
      // print(posts.toString());
      return <PostModel>[posts];
    }catch(e){
      print(e);
      throw e;
    }
  }
}