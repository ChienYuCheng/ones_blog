import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ones_blog/bloc/post_event.dart';
import 'package:ones_blog/bloc/post_state.dart';
import 'package:ones_blog/model/post_model.dart';
import 'package:ones_blog/repository/post_repo.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final PostRepository repo;
  PostBloc(this.repo) : super(InitialState());

  @override
  Stream<PostState> mapEventToState(PostEvent event) async*{
    if(event is DoFetchEvent) {
      yield LoadingState();
      try{
        List<PostModel> posts = await repo.fetchPosts();
        yield FetchSuccess(posts: posts);
      }catch(e){
        yield ErrorState(message: e.toString());
      }
    }
  }

}
