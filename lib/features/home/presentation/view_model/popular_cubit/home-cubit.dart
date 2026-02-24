import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:movie/core/network/result.dart';
import 'package:movie/features/home/domain/entities/recommended_movies_entities.dart';
import 'package:movie/features/home/domain/use_case/popular_movies_use_case.dart';
import 'package:movie/features/home/presentation/view_model/popular_cubit/home_state.dart';

@injectable
class PopularCubit extends Cubit<HomeState> {
  PopularCubit(this._getPopularMoviesUseCase) : super(HomeInitial());
  final GetPopularMoviesUseCase _getPopularMoviesUseCase;
  Future<void> intent(HomeIntent intent) async {
    if (intent is PopularMoviesIntent) {
      await _getPopularMovies();
    }
  }

  Future<void> _getPopularMovies() async {
    emit(HomeLoading());
    final result = await _getPopularMoviesUseCase.call();
    if (result is ApiSuccess<MoviesEntities>) {
      final recommendedMovies = result.data.results ?? [];
      emit(HomeSuccess(recommendedMovies));
    } else if (result is ApiError<MoviesEntities>) {
      emit(HomeError(result.failure.message));
    }
  }
}

sealed class HomeIntent {}

class PopularMoviesIntent extends HomeIntent {}
