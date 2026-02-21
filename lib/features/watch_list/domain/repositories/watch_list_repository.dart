import 'package:movie/features/watch_list/domain/entities/watch_list_entity.dart';

abstract class WatchListRepository {
  List<WatchListEntity> getWatchList();
  bool isMovieSaved(int movieId);
  Future<void> toggleMovie(WatchListEntity item);
  Future<void> removeMovie(int movieId);
}
