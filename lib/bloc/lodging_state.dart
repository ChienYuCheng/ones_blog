part of 'lodging_bloc.dart';

@immutable
abstract class LodgingState {}

class LodgingInitial extends LodgingState {}

class LoadingLodging extends LodgingState {}


class FetchedLodging extends LodgingState {
  final LocationModel lodgings;
  FetchedLodging({required this.lodgings});
}

class LodgingError extends LodgingState {
  final String message;
  LodgingError({required this.message});
}
