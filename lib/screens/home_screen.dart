import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ones_blog/bloc/post_bloc.dart';
import 'package:ones_blog/model/post_model.dart';

import '../bloc/post_event.dart';
import '../bloc/post_state.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();

}

class _HomeScreenState extends State<HomeScreen> {
  // late PostBloc bloc;
  //
  // @override
  // void initState() {
  //   super.initState();
  //   bloc = BlocProvider.of<PostBloc>(context);
  //   bloc.add(DoFetchEvent());
  // }
  
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
                itemCount: state.posts.data.length,
                itemBuilder: (context, index){
                  print(state.posts.data.length);
                  return Card(
                    child: ListTile(
                      title: Text(state.posts.data[index].content),
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