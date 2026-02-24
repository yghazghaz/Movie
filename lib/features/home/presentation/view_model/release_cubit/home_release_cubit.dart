import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:movie/core/network/result.dart';
import 'package:movie/features/home/domain/entities/recommended_movies_entities.dart';
import 'package:movie/features/home/domain/use_case/releases_movies_use_case.dart';
import 'package:movie/features/home/presentation/view_model/popular_cubit/home_state.dart';

@injectable
class ReleasesCubit extends Cubit<HomeState> {
  ReleasesCubit(this._getReleasesMoviesUseCase) : super(HomeInitial());
  final GitReleasesMoviesUseCase _getReleasesMoviesUseCase;
  Future<void> intent(HomeIntent intent) async {
    if (intent is ReleasesMoviesIntent) {
      await _getReleasesMovies();
    }
  }

  Future<void> _getReleasesMovies() async {
    emit(HomeLoading());
    final result = await _getReleasesMoviesUseCase.call();
    if (result is ApiSuccess<MoviesEntities>) {
      final releasesMovies = result.data.results ?? [];
      emit(HomeSuccess(releasesMovies));
    } else if (result is ApiError<MoviesEntities>) {
      emit(HomeError(result.failure.message));
    }
  }
}

sealed class HomeIntent {}

class ReleasesMoviesIntent extends HomeIntent {}
