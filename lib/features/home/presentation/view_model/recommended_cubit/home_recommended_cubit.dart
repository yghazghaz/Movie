import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:movie/core/network/result.dart';
import 'package:movie/features/home/domain/entities/recommended_movies_entities.dart';
import 'package:movie/features/home/domain/use_case/recommended_movies_use_case.dart';
import 'package:movie/features/home/presentation/view_model/popular_cubit/home_state.dart';

@injectable
class RecommendedCubit extends Cubit<HomeState> {
  RecommendedCubit(this._getRecommendedMoviesUseCase) : super(HomeInitial());
  final GetRecommendedMoviesUseCase _getRecommendedMoviesUseCase;
  Future<void> intent(HomeIntent intent) async {
    if (intent is RecommendedMoviesIntent) {
      await _getRecommendedMovies();
    }
  }

  Future<void> _getRecommendedMovies() async {
    emit(HomeLoading());
    final result = await _getRecommendedMoviesUseCase.call();
    if (result is ApiSuccess<MoviesEntities>) {
      final recommendedMovies = result.data.results ?? [];
      emit(HomeSuccess(recommendedMovies));
    } else if (result is ApiError<MoviesEntities>) {
      emit(HomeError(result.failure.message));
    }
  }
}

sealed class HomeIntent {}

class RecommendedMoviesIntent extends HomeIntent {}
