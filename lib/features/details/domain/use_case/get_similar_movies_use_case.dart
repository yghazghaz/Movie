

import 'package:injectable/injectable.dart';
import 'package:movie/core/network/result.dart';
import 'package:movie/features/details/domain/entities/similar_movie_entity.dart';
import 'package:movie/features/details/domain/repository/repo/base_details_repo.dart';
@injectable
class GetSimilarMoviesUseCase {
  final BaseDetailsRepository baseDetailsRepository;

  GetSimilarMoviesUseCase(this.baseDetailsRepository);

  Future<ApiResult<List<SimilarMovieEntity>>> call(int movieId) async {
    return await baseDetailsRepository.getSimilarMovies(movieId);
  }
}
