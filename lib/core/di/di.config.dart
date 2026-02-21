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

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    gh.factory<_i13.HomeApi>(() => _i13.HomeApi());
    gh.lazySingleton<_i1018.HomeDataSource>(
      () => _i614.HomeDataSourceImp(gh<_i13.HomeApi>()),
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
