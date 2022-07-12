import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:ones_blog/model/post_model.dart';

import '../repository/post_repository.dart';

part 'post_event.dart';
part 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final PostRepository postRepository;
  PostBloc({required this.postRepository}) : super(PostInitial()){
    on<PostEvent>((event, emit){
      // TODO: implement event handler
    });
  }
  Stream<PostState> mapEventToState(
      PostEvent event,
      )async* {
    if(event is GetPostEvent){
      yield PostLoadingState();
      try{
        List<PostModel> lstPosts = await postRepository.getAllPost();
        yield SuccessState(data: lstPosts);
      }catch(ex){
        print(ex);
        yield ErrorState(messageError: ex.toString());
      }
    }
  }
}
