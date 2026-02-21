
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:movie/core/network/result.dart';

import '../../domain/use_case/get_movie_details_use_case.dart';
import '../../domain/use_case/get_similar_movies_use_case.dart';
import 'details_state.dart';
@injectable
class DetailsCubit extends Cubit<DetailsState> {
  final GetMovieDetailsUseCase getMovieDetailsUseCase;
  final GetSimilarMoviesUseCase getSimilarMoviesUseCase;

  DetailsCubit(this.getMovieDetailsUseCase, this.getSimilarMoviesUseCase)
    : super(const DetailsState());

  Future<void> getMovieDetails(int movieId) async {
    emit(state.copyWith(movieDetailsState: RequestState.loading));

    final result = await getMovieDetailsUseCase(movieId);

    if (result is ApiSuccess) {
      emit(
        state.copyWith(
          movieDetails: (result as ApiSuccess).data,
          movieDetailsState: RequestState.loaded,
        ),
      );
    } else if (result is ApiError) {
      emit(
        state.copyWith(
          movieDetailsMessage: (result as ApiError).failure.message,
          movieDetailsState: RequestState.error,
        ),
      );
    }
  }

  Future<void> getSimilarMovies(int movieId) async {
    emit(state.copyWith(similarMoviesState: RequestState.loading));

    final result = await getSimilarMoviesUseCase(movieId);

    if (result is ApiSuccess) {
      emit(
        state.copyWith(
          similarMovies: (result as ApiSuccess).data,
          similarMoviesState: RequestState.loaded,
        ),
      );
    } else if (result is ApiError) {
      emit(
        state.copyWith(
          similarMoviesMessage: (result as ApiError).failure.message,
          similarMoviesState: RequestState.error,
        ),
      );
    }
  }
}
