// part of 'post_bloc.dart';
//
// @immutable
// abstract class PostEvent {}
import 'package:equatable/equatable.dart';

class PostEvent extends Equatable{
  @override
  List<Object?> get props => [];
}

class DoFetchEvent extends PostEvent{}