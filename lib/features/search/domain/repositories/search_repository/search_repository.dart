import '../../../../../core/network/result.dart';
import '../../entities/search_response_entity.dart';

abstract class SearchRepository {
  Future<ApiResult<List<ResultsEntity>>> searchMovies( String query);
}