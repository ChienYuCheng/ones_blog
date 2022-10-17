import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../model/location_model.dart';
import '../repository/location_repo.dart';

part 'all_lodging_event.dart';
part 'all_lodging_state.dart';

class AllLodgingBloc extends Bloc<AllLodgingEvent, AllLodgingState> {
  final LocationRepository repo;
  AllLodgingBloc(this.repo) : super(AllLodgingInitial());

  @override
  Stream<AllLodgingState> mapEventToState(AllLodgingEvent event) async* {
    if (event is FetchAllLodgingEvent) {
      yield LoadingAllLodging();
      try {
        LocationModel allLodgings = await repo.fetchAllSpotLocations();
        yield FetchedAllLodging(allLodgings: allLodgings);
      } catch (e) {
        yield AllLodgingError(message: e.toString());
      }
    }
  }
}
