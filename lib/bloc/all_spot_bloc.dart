import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../model/location_model.dart';
import '../repository/location_repo.dart';

part 'all_spot_event.dart';
part 'all_spot_state.dart';

class AllSpotBloc extends Bloc<AllSpotEvent, AllSpotState> {
  final LocationRepository repo;
  AllSpotBloc(this.repo) : super(AllSpotInitial());

  @override
  Stream<AllSpotState> mapEventToState(AllSpotEvent event) async* {
    if (event is FetchAllSpotEvent) {
      yield LoadingAllSpot();
      try {
        LocationModel allSpots = await repo.fetchAllSpotLocations();
        yield FetchedAllSpot(allSpots: allSpots);
      } catch (e) {
        yield AllSpotError(message: e.toString());
      }
    }
  }
}
