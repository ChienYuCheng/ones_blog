part of 'leader_board_bloc.dart';

@immutable
abstract class LeaderBoardState {}

class LeaderBoardInitial extends LeaderBoardState {}

class LoadingLeaderBoard extends LeaderBoardState {}


class FetchedLeaderBoard extends LeaderBoardState {
  final LocationModel leaderBoards;
  FetchedLeaderBoard({required this.leaderBoards});
}

class LeaderBoardError extends LeaderBoardState {
  final String message;
  LeaderBoardError({required this.message});
}