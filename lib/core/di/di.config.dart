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
    gh.lazySingleton<_i80.SearchApi>(() => _i80.SearchApi());
    gh.lazySingleton<_i828.SearchDataSource>(
      () => _i622.SearchDataSourceImpl(gh<_i80.SearchApi>()),
    );
    gh.lazySingleton<_i208.SearchRepository>(
      () => _i926.SearchRepositoryImpl(gh<_i828.SearchDataSource>()),
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
    return this;
  }
}
