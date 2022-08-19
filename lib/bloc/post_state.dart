// part of 'post_bloc.dart';
//
// @immutable
// abstract class PostState {}
//
// class PostInitial extends PostState {}
import 'package:equatable/equatable.dart';
import 'package:ones_blog/model/post_model.dart';

class PostState extends Equatable {
  @override
  List<Object?> get props => [];
}

class InitialState extends PostState {}

class LoadingState extends PostState {}


class FetchSuccess extends PostState {
  final PostModel posts;
  FetchSuccess({required this.posts});
}

class ErrorState extends PostState {
  final String message;
  ErrorState({required this.message});
}