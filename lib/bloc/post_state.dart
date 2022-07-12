part of 'post_bloc.dart';

@immutable
abstract class PostState {}

class PostInitial extends PostState {}

class PostLoadingState extends PostState{}

class SuccessState extends PostState{
  final List<PostModel> data;

  SuccessState({required this.data});
}

class ErrorState extends PostState{
  final String messageError;

  ErrorState({required this.messageError});
}