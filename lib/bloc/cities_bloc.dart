// import 'dart:async';
//
// import 'package:bloc/bloc.dart';
// import 'package:equatable/equatable.dart';
// import 'package:meta/meta.dart';
//
// import '../model/cities_model.dart';
// import '../repository/cities_repo.dart';
//
// part 'cities_event.dart';
// part 'cities_state.dart';
//
// class CitiesBloc extends Bloc<CitiesEvent, CitiesState> {
//   final CitiesRepository repo;
//   CitiesBloc(this.repo) : super(CitiesInitial());
//
//   @override
//   Stream<CitiesState> mapEventToState(CitiesEvent event) async* {
//     if (event is FetchCitiesEvent) {
//       yield LoadingCities();
//       try {
//         CitiesModel cities = await repo.fetchCities();
//         yield FetchedCities(cities: cities);
//       } catch (e) {
//         yield CitiesError(message: e.toString());
//       }
//     }
//   }
// }
