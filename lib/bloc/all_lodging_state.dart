part of 'all_lodging_bloc.dart';

@immutable
abstract class AllLodgingState {}

class AllLodgingInitial extends AllLodgingState {}

class LoadingAllLodging extends AllLodgingState {}


class FetchedAllLodging extends AllLodgingState {
  final LocationModel allLodgings;
  FetchedAllLodging({required this.allLodgings});
}

class AllLodgingError extends AllLodgingState {
  final String message;
  AllLodgingError({required this.message});
}