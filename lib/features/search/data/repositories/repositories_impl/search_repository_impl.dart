import 'package:injectable/injectable.dart';
import 'package:movie/features/search/domain/repositories/search_repository/search_repository.dart';

import '../../../../../core/network/result.dart';
import '../../../domain/entities/search_response_entity.dart';
import '../../../domain/repositories/search_data_source/search_data_source.dart';

@LazySingleton(as: SearchRepository)
class SearchRepositoryImpl implements SearchRepository {
  SearchRepositoryImpl(this._searchDataSource);
  final SearchDataSource _searchDataSource;
  @override
  Future<ApiResult<List<ResultsEntity>>> searchMovies(String query)async =>
     await _searchDataSource.searchMovies(query);
}
