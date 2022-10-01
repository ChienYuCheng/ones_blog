part of 'spot_bloc.dart';

@immutable
abstract class SpotState {}

class SpotInitial extends SpotState {}

class LoadingSpot extends SpotState {}


class FetchedSpot extends SpotState {
  final LocationModel spots;
  FetchedSpot({required this.spots});
}

class SpotError extends SpotState {
  final String message;
  SpotError({required this.message});
}