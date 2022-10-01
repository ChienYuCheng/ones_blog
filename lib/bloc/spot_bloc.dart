import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../model/location_model.dart';
import '../repository/location_repo.dart';

part 'spot_event.dart';
part 'spot_state.dart';

class SpotBloc extends Bloc<SpotEvent, SpotState> {
  final LocationRepository repo;
  SpotBloc(this.repo) : super(SpotInitial());

  @override
  Stream<SpotState> mapEventToState(SpotEvent event) async* {
    if (event is FetchSpotEvent) {
      yield LoadingSpot();
      try {
        LocationModel spots = await repo.fetchSpotLocations();
        yield FetchedSpot(spots: spots);
      } catch (e) {
        yield SpotError(message: e.toString());
      }
    }
  }
}
