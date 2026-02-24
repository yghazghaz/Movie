import 'package:movie/features/home/domain/entities/recommended_movies_entities.dart';

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
