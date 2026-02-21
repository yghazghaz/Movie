

import 'package:injectable/injectable.dart';
import 'package:movie/core/network/result.dart';
import 'package:movie/features/search/domain/entities/search_response_entity.dart';

import '../repositories/search_repository/search_repository.dart';
@injectable
class SearchMoviesUseCase {
  SearchMoviesUseCase(this._searchRepo);
  final SearchRepository _searchRepo;
 Future<ApiResult<List<ResultsEntity>>> invoke(String query)async => await _searchRepo.searchMovies(query);
}
