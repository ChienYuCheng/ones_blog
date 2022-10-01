import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../model/location_model.dart';
import '../repository/location_repo.dart';

part 'restaurant_event.dart';
part 'restaurant_state.dart';

class RestaurantBloc extends Bloc<RestaurantEvent, RestaurantState> {
  final LocationRepository repo;
  RestaurantBloc(this.repo) : super(RestaurantInitial());

  @override
  Stream<RestaurantState> mapEventToState(RestaurantEvent event) async* {
    if (event is FetchRestaurantEvent) {
      yield LoadingRestaurant();
      try {
        LocationModel restaurants = await repo.fetchRestaurantLocations();
        yield FetchedRestaurant(restaurants: restaurants);
      } catch (e) {
        yield RestaurantError(message: e.toString());
      }
    }
  }
}
