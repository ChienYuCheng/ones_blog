import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../model/location_model.dart';
import '../repository/location_repo.dart';

part 'location_event.dart';
part 'location_state.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  final LocationRepository repo;
  LocationBloc(this.repo) : super(LocationInitial());

  @override
  Stream<LocationState> mapEventToState(LocationEvent event) async* {
    if (event is FetchLocationEvent) {
      yield LoadingLocation();
      try {
        LocationModel locations = await repo.fetchLocations();
        yield FetchedLocation(locations: locations);
      } catch (e) {
        yield LocationError(message: e.toString());
      }
    }
  }
}
