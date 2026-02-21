import 'package:movie/features/home/domain/entites/recommended_movies_entites.dart';

sealed class HomeState {}

final class HomeInitial extends HomeState {}

final class HomeLoading extends HomeState {}

final class HomeSuccess extends HomeState {
  final List<ResultsEntity> listOfMovies;
  HomeSuccess(this.listOfMovies);
}

final class HomeError extends HomeState {
  final String message;
  HomeError(this.message);
}
