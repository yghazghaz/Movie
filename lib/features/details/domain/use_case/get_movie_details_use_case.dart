import 'package:injectable/injectable.dart';
import 'package:movie/core/network/result.dart';
import 'package:movie/features/details/domain/entities/movie_details_entity.dart';
import 'package:movie/features/details/domain/repository/repo/base_details_repo.dart';

@injectable
class GetMovieDetailsUseCase {
  final BaseDetailsRepository baseDetailsRepository;

  GetMovieDetailsUseCase(this.baseDetailsRepository);

  Future<ApiResult<MovieDetailsEntity>> call(int movieId) async {
    return await baseDetailsRepository.getMovieDetails(movieId);
  }
}
