import 'package:injectable/injectable.dart';
import 'package:movie/core/network/result.dart';
import 'package:movie/features/home/domain/entites/recommended_movies_entites.dart';
import 'package:movie/features/home/domain/repository/data_source/home_data_source.dart';
import 'package:movie/features/home/domain/repository/repo/home_repo.dart';

@LazySingleton(as: HomeRepo)
class HomeRepoImp implements HomeRepo {
  final HomeDataSource _homeDataSource;

  HomeRepoImp(this._homeDataSource);

  @override
  Future<ApiResult<MoviesEntites>> getRecommendedMovies() =>
      _homeDataSource.getRecommendedMovies();

  @override
  Future<ApiResult<MoviesEntites>> getPopularMovies() =>
      _homeDataSource.getPopularMovies();

  @override
  Future<ApiResult<MoviesEntites>> getReleasesMovies() =>
      _homeDataSource.getReleasesMovies();
}