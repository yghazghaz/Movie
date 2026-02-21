// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:movie/features/home/data/api/home_api.dart' as _i13;
import 'package:movie/features/home/data/repository/data_source/home_data_source_imp.dart'
    as _i614;
import 'package:movie/features/home/data/repository/repo/home_repo_imp.dart'
    as _i976;
import 'package:movie/features/home/domain/repository/data_source/home_data_source.dart'
    as _i1018;
import 'package:movie/features/home/domain/repository/repo/home_repo.dart'
    as _i988;
import 'package:movie/features/home/domain/use_case/popular_movies_use_case.dart'
    as _i588;
import 'package:movie/features/home/domain/use_case/recommended_movies_use_case.dart'
    as _i483;
import 'package:movie/features/home/domain/use_case/releases_movies_use_case.dart'
    as _i1068;
import 'package:movie/features/home/presentation/view_model/popular_cubit/home-cubit.dart'
    as _i631;
import 'package:movie/features/home/presentation/view_model/recommended_cubit/home_recommended_cubit.dart'
    as _i251;
import 'package:movie/features/home/presentation/view_model/release_cubit/home_release_cubit.dart'
    as _i1041;
import 'package:movie/features/search/data/api/search_api.dart' as _i80;
import 'package:movie/features/search/data/repositories/data_sources_impl/search_data_source_impl.dart'
    as _i622;
import 'package:movie/features/search/data/repositories/repositories_impl/search_repository_impl.dart'
    as _i926;
import 'package:movie/features/search/domain/repositories/search_data_source/search_data_source.dart'
    as _i828;
import 'package:movie/features/search/domain/repositories/search_repository/search_repository.dart'
    as _i208;
import 'package:movie/features/search/domain/use_cases/search_movies_use_case.dart'
    as _i596;
import 'package:movie/features/search/presentation/view_model/search_cubit.dart'
    as _i376;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    gh.factory<_i13.HomeApi>(() => _i13.HomeApi());
    gh.lazySingleton<_i80.SearchApi>(() => _i80.SearchApi());
    gh.lazySingleton<_i828.SearchDataSource>(
      () => _i622.SearchDataSourceImpl(gh<_i80.SearchApi>()),
    );
    gh.lazySingleton<_i208.SearchRepository>(
      () => _i926.SearchRepositoryImpl(gh<_i828.SearchDataSource>()),
    );
    gh.lazySingleton<_i1018.HomeDataSource>(
      () => _i614.HomeDataSourceImp(gh<_i13.HomeApi>()),
    );
    gh.factory<_i596.SearchMoviesUseCase>(
      () => _i596.SearchMoviesUseCase(gh<_i208.SearchRepository>()),
    );
    gh.factory<_i376.SearchCubit>(
      () => _i376.SearchCubit(
        gh<_i596.SearchMoviesUseCase>(),
        searchRepository: gh<_i208.SearchRepository>(),
      ),
    );
    gh.lazySingleton<_i988.HomeRepo>(
      () => _i976.HomeRepoImp(gh<_i1018.HomeDataSource>()),
    );
    gh.factory<_i588.GetPopularMoviesUseCase>(
      () => _i588.GetPopularMoviesUseCase(gh<_i988.HomeRepo>()),
    );
    gh.factory<_i483.GetRecommendedMoviesUseCase>(
      () => _i483.GetRecommendedMoviesUseCase(gh<_i988.HomeRepo>()),
    );
    gh.factory<_i1068.GitReleasesMoviesUseCase>(
      () => _i1068.GitReleasesMoviesUseCase(gh<_i988.HomeRepo>()),
    );
    gh.factory<_i251.RecommendedCubit>(
      () => _i251.RecommendedCubit(gh<_i483.GetRecommendedMoviesUseCase>()),
    );
    gh.factory<_i1041.ReleasesCubit>(
      () => _i1041.ReleasesCubit(gh<_i1068.GitReleasesMoviesUseCase>()),
    );
    gh.factory<_i631.PopularCubit>(
      () => _i631.PopularCubit(gh<_i588.GetPopularMoviesUseCase>()),
    );
    return this;
  }
}
