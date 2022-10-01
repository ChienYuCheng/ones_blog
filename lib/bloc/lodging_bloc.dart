import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../model/location_model.dart';
import '../repository/location_repo.dart';

part 'lodging_event.dart';
part 'lodging_state.dart';

class LodgingBloc extends Bloc<LodgingEvent, LodgingState> {
  final LocationRepository repo;
  LodgingBloc(this.repo) : super(LodgingInitial());

  @override
  Stream<LodgingState> mapEventToState(LodgingEvent event) async* {
    if (event is FetchLodgingEvent) {
      yield LoadingLodging();
      try {
        LocationModel lodgings = await repo.fetchLodgingLocations();
        yield FetchedLodging(lodgings: lodgings);
      } catch (e) {
        yield LodgingError(message: e.toString());
      }
    }
  }
}
