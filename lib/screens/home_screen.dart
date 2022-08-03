import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ones_blog/bloc/post_bloc.dart';
import 'package:ones_blog/bloc/post_cubit.dart';
import 'package:ones_blog/model/post_model.dart';

import '../bloc/post_event.dart';
import '../bloc/post_state.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late PostBloc bloc;

  @override
  void initState() {
    bloc = BlocProvider.of<PostBloc>(context);
    bloc.add(DoFetchEvent());
    super.initState();
  }
  @override
  void dispose() {
    bloc.close();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("Post List"),
      ),
      body: Center(
        child: BlocBuilder<PostBloc, PostState>(
          builder: (context, state){
            if(state is LoadingState){
              return CircularProgressIndicator();
            }else if(state is FetchSuccess){
              return ListView.builder(
                itemCount: state.posts.length,
                itemBuilder: (context, index){
                  return Card(
                    child: ListTile(
                      title: Text(state.posts[index].data.toString()),
                    ),
                  );
                },
              );
            }else if(state is ErrorState){
              return ErrorWidget(state.message.toString());
            }
            return Container();
          },
        ),
      )
    );
  }
}
// body: BlocBuilder<PostCubit, List<PostModel>>(
// builder: (context, posts) {
// // if(posts.isEmpty){
// //   return Center(
// //     child: CircularProgressIndicator(),
// //   );
// // }
// return ListView.builder(
// itemCount: posts.length,
// itemBuilder: (context, index) {
// return Card(
// child: ListTile(
// title: Text('${posts[index]}'),
// ),
// );
// });
// },
// ),


// child: BlocBuilder<PostBloc, PostState>(
// builder: (context, state){
// if(state is InitialState){
// return CircularProgressIndicator();
// }else if(state is LoadingState){
// return CircularProgressIndicator();
// }else if(state is FetchSuccess){
// return ListView.builder(
// itemCount: state.posts.length,
// itemBuilder: (context, index){
// return Card(
// child: ListTile(
// title: Text("TEXT"),
// ),
// );
// },
// );
// }else if(state is ErrorState){
// return ErrorWidget(state.message.toString());
// }
// },
// ),