import 'package:movie/features/watch_list/data/api/watch_list_local_datasource.dart';
import 'package:movie/features/watch_list/data/models/watch_list_model.dart';
import 'package:movie/features/watch_list/domain/entities/watch_list_entity.dart';
import 'package:movie/features/watch_list/domain/repositories/watch_list_repository.dart';

class WatchListRepositoryImpl implements WatchListRepository {
  final WatchListLocalDataSource localDataSource;

  WatchListRepositoryImpl(this.localDataSource);

  @override
  List<WatchListEntity> getWatchList() => localDataSource.getWatchList();

  @override
  bool isMovieSaved(int movieId) => localDataSource.isMovieSaved(movieId);

  @override
  Future<void> toggleMovie(WatchListEntity item) =>
      localDataSource.toggleMovie(WatchListModel.fromEntity(item));

  @override
  Future<void> removeMovie(int movieId) => localDataSource.removeMovie(movieId);
}
