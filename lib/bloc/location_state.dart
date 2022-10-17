part of 'location_bloc.dart';

@immutable
abstract class LocationState {}

class LocationInitial extends LocationState {}

class LoadingLocation extends LocationState {}


class FetchedLocation extends LocationState {
  final LocationModel locations;
  FetchedLocation({required this.locations});
}

class LocationError extends LocationState {
  final String message;
  LocationError({required this.message});
}