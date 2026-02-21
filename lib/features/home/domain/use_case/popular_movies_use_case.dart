import 'package:injectable/injectable.dart';
import 'package:movie/core/network/result.dart';
import 'package:movie/features/home/domain/entites/recommended_movies_entites.dart';
import 'package:movie/features/home/domain/repository/repo/home_repo.dart';
@injectable
class GetPopularMoviesUseCase {
  GetPopularMoviesUseCase(this._repo);
  final HomeRepo _repo;
  Future<ApiResult<MoviesEntites>> call() async =>
      await _repo.getPopularMovies();
}
