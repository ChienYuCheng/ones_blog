import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../model/location_model.dart';
import '../repository/location_repo.dart';

part 'leader_board_event.dart';
part 'leader_board_state.dart';

class LeaderBoardBloc extends Bloc<LeaderBoardEvent, LeaderBoardState> {
  final LocationRepository repo;
  LeaderBoardBloc(this.repo) : super(LeaderBoardInitial());

  @override
  Stream<LeaderBoardState> mapEventToState(LeaderBoardEvent event) async* {
    if (event is FetchLeaderBoardEvent) {
      yield LoadingLeaderBoard();
      try {
        LocationModel leaderBoards = await repo.fetchLeaderBoardLocations('1');
        yield FetchedLeaderBoard(leaderBoards: leaderBoards);
      } catch (e) {
        yield LeaderBoardError(message: e.toString());
      }
    }
  }
}