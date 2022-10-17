import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../model/location_model.dart';
import '../repository/location_repo.dart';

part 'all_restaurant_event.dart';
part 'all_restaurant_state.dart';

class AllRestaurantBloc extends Bloc<AllRestaurantEvent, AllRestaurantState> {
  final LocationRepository repo;
  AllRestaurantBloc(this.repo) : super(AllRestaurantInitial());

  @override
  Stream<AllRestaurantState> mapEventToState(AllRestaurantEvent event) async* {
    if (event is FetchAllRestaurantEvent) {
      yield LoadingAllRestaurant();
      try {
        LocationModel allRestaurants = await repo.fetchAllRestaurantLocations();
        yield FetchedAllRestaurant(allRestaurants: allRestaurants);
      } catch (e) {
        yield AllRestaurantError(message: e.toString());
      }
    }
  }
}
