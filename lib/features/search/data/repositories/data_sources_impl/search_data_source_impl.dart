import 'package:injectable/injectable.dart';
import 'package:movie/core/network/result.dart';
import 'package:movie/features/search/data/api/search_api.dart';

import 'package:movie/features/search/data/models/search_response_dto.dart';
import 'package:movie/features/search/domain/entities/search_response_entity.dart';
import 'package:movie/features/search/domain/repositories/search_data_source/search_data_source.dart';


@LazySingleton(as: SearchDataSource)
class SearchDataSourceImpl implements SearchDataSource {
  SearchDataSourceImpl(this._searchApi);
  final SearchApi _searchApi;

  @override
  Future<ApiResult<List<ResultsEntity>>> searchMovies(String query) async {
    final result = await _searchApi.getSearchMovie(query);
    switch (result) {
      case ApiSuccess<SearchResponseDto>():
        final resultDto = result.data;
        
        final resultEntity = resultDto.toEntity();
        return ApiSuccess<List<ResultsEntity>>(resultEntity.results);
      case ApiError<SearchResponseDto>():
        return ApiError<List<ResultsEntity>>(result.failure);
    }
  }
}
