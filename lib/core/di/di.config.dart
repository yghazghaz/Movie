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
import 'package:movie/features/details/data/api/details_api.dart' as _i655;
import 'package:movie/features/details/data/repository/data_source/details_data_source_imp.dart'
    as _i702;
import 'package:movie/features/details/data/repository/repo/details_repo_imp.dart'
    as _i547;
import 'package:movie/features/details/domain/repository/data_source/details_data_source.dart'
    as _i1015;
import 'package:movie/features/details/domain/repository/repo/base_details_repo.dart'
    as _i226;
import 'package:movie/features/details/domain/use_case/get_movie_details_use_case.dart'
    as _i454;
import 'package:movie/features/details/domain/use_case/get_similar_movies_use_case.dart'
    as _i1071;
import 'package:movie/features/details/presentation/view_model/details_cubit.dart'
    as _i1020;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    gh.factory<_i655.DetailsApi>(() => _i655.DetailsApi());
    gh.lazySingleton<_i1015.DetailsDataSource>(
      () => _i702.DetailsDataSourceImpl(gh<_i655.DetailsApi>()),
    );
    gh.lazySingleton<_i226.BaseDetailsRepository>(
      () => _i547.DetailsRepoImpl(gh<_i1015.DetailsDataSource>()),
    );
    gh.factory<_i454.GetMovieDetailsUseCase>(
      () => _i454.GetMovieDetailsUseCase(gh<_i226.BaseDetailsRepository>()),
    );
    gh.factory<_i1071.GetSimilarMoviesUseCase>(
      () => _i1071.GetSimilarMoviesUseCase(gh<_i226.BaseDetailsRepository>()),
    );
    gh.factory<_i1020.DetailsCubit>(
      () => _i1020.DetailsCubit(
        gh<_i454.GetMovieDetailsUseCase>(),
        gh<_i1071.GetSimilarMoviesUseCase>(),
      ),
    );
    return this;
  }
}
