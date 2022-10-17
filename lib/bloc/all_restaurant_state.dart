part of 'all_restaurant_bloc.dart';

@immutable
abstract class AllRestaurantState {}

class AllRestaurantInitial extends AllRestaurantState {}

class LoadingAllRestaurant extends AllRestaurantState {}


class FetchedAllRestaurant extends AllRestaurantState {
  final LocationModel allRestaurants;
  FetchedAllRestaurant({required this.allRestaurants});
}

class AllRestaurantError extends AllRestaurantState {
  final String message;
  AllRestaurantError({required this.message});
}