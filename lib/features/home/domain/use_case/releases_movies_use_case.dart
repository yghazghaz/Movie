import 'package:movie/core/network/result.dart';
import 'package:movie/features/home/domain/entites/recommended_movies_entites.dart';
import 'package:movie/features/home/domain/repository/repo/home_repo.dart';

class GitReleasesMoviesUseCase {
  HomeRepo _repo;
  GitReleasesMoviesUseCase(this._repo);
  Future<ApiResult<MoviesEntites>> call() async =>
      await _repo.getReleasesMovies();
}
