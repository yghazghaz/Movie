// ignore: depend_on_referenced_packages
import 'package:equatable/equatable.dart';
import '../../domain/entities/movie_details_entity.dart';
import '../../domain/entities/similar_movie_entity.dart';

enum RequestState { loading, loaded, error }

class DetailsState extends Equatable {
  final MovieDetailsEntity? movieDetails;
  final RequestState movieDetailsState;
  final String movieDetailsMessage;

  final List<SimilarMovieEntity> similarMovies;
  final RequestState similarMoviesState;
  final String similarMoviesMessage;

  const DetailsState({
    this.movieDetails,
    this.movieDetailsState = RequestState.loading,
    this.movieDetailsMessage = '',
    this.similarMovies = const [],
    this.similarMoviesState = RequestState.loading,
    this.similarMoviesMessage = '',
  });

  DetailsState copyWith({
    MovieDetailsEntity? movieDetails,
    RequestState? movieDetailsState,
    String? movieDetailsMessage,
    List<SimilarMovieEntity>? similarMovies,
    RequestState? similarMoviesState,
    String? similarMoviesMessage,
  }) {
    return DetailsState(
      movieDetails: movieDetails ?? this.movieDetails,
      movieDetailsState: movieDetailsState ?? this.movieDetailsState,
      movieDetailsMessage: movieDetailsMessage ?? this.movieDetailsMessage,
      similarMovies: similarMovies ?? this.similarMovies,
      similarMoviesState: similarMoviesState ?? this.similarMoviesState,
      similarMoviesMessage: similarMoviesMessage ?? this.similarMoviesMessage,
    );
  }

  @override
  List<Object?> get props => [
    movieDetails,
    movieDetailsState,
    movieDetailsMessage,
    similarMovies,
    similarMoviesState,
    similarMoviesMessage,
  ];
}
