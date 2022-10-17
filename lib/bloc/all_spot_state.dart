part of 'all_spot_bloc.dart';

@immutable
abstract class AllSpotState {}

class AllSpotInitial extends AllSpotState {}

class LoadingAllSpot extends AllSpotState {}


class FetchedAllSpot extends AllSpotState {
  final LocationModel allSpots;
  FetchedAllSpot({required this.allSpots});
}

class AllSpotError extends AllSpotState {
  final String message;
  AllSpotError({required this.message});
}