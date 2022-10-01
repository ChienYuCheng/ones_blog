part of 'restaurant_bloc.dart';

@immutable
abstract class RestaurantState {}

class RestaurantInitial extends RestaurantState {}

class LoadingRestaurant extends RestaurantState {}


class FetchedRestaurant extends RestaurantState {
  final LocationModel restaurants;
  FetchedRestaurant({required this.restaurants});
}

class RestaurantError extends RestaurantState {
  final String message;
  RestaurantError({required this.message});
}
