import 'package:injectable/injectable.dart';
import 'package:movie/core/network/result.dart';
import 'package:movie/features/home/domain/entities/recommended_movies_entities.dart';
import 'package:movie/features/home/domain/repository/data_source/home_data_source.dart';
import 'package:movie/features/home/domain/repository/repo/home_repo.dart';

@LazySingleton(as: HomeRepo)
class HomeRepoImp implements HomeRepo {
  final HomeDataSource _homeDataSource;

  HomeRepoImp(this._homeDataSource);

  @override
  Future<ApiResult<MoviesEntities>> getRecommendedMovies() =>
      _homeDataSource.getRecommendedMovies();

  @override
  Future<ApiResult<MoviesEntities>> getPopularMovies() =>
      _homeDataSource.getPopularMovies();

  @override
  Future<ApiResult<MoviesEntities>> getReleasesMovies() =>
      _homeDataSource.getReleasesMovies();
}
