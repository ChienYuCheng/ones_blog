import 'package:flutter/material.dart';
import 'package:flutter/services.dart' as rootBundle;
import 'package:ones_blog/bloc/post_bloc.dart';
import 'package:ones_blog/model/post_model.dart';

import 'dart:convert';

import '../repository/post_repository.dart';

class PostService implements PostRepository{
  @override
  Future<List<PostModel>> getAllPost() async{
    String jsonData = await rootBundle.rootBundle.loadString("assets/raw/posts.json");
    List<dynamic> raw = jsonDecode(jsonData);
    // return raw.map((post) => PostModel.fromJson(post)).toList();
    List<PostModel> posts = raw.map((post) => PostModel.fromJson(post)).toList();
    print("Success");
    return posts;
  }
}