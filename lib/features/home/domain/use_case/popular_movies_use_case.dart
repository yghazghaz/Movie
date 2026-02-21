import 'package:movie/core/network/result.dart';
import 'package:movie/features/home/domain/entites/recommended_movies_entites.dart';
import 'package:movie/features/home/domain/repository/repo/home_repo.dart';

class GetPopularMoviesUseCase {
  HomeRepo _repo;
  GetPopularMoviesUseCase(this._repo);
  Future<ApiResult<MoviesEntites>> call() async =>
      await _repo.getPopularMovies();
}
