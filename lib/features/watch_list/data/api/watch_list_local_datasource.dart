import 'package:hive/hive.dart';
import 'package:movie/core/utils/app_hive.dart';
import 'package:movie/features/watch_list/data/models/watch_list_model.dart';

abstract class WatchListLocalDataSource {
  List<WatchListModel> getWatchList();
  bool isMovieSaved(int movieId);
  Future<void> toggleMovie(WatchListModel item);
  Future<void> removeMovie(int movieId);
}

class WatchListLocalDataSourceImpl implements WatchListLocalDataSource {
  final Box<WatchListModel> _box;

  WatchListLocalDataSourceImpl({Box<WatchListModel>? box})
    : _box = box ?? Hive.box<WatchListModel>(AppHive.watchListBox);

  @override
  List<WatchListModel> getWatchList() => _box.values.toList();

  @override
  bool isMovieSaved(int movieId) => _box.containsKey(movieId);

  @override
  Future<void> toggleMovie(WatchListModel item) async {
    if (_box.containsKey(item.id)) {
      await _box.delete(item.id);
    } else {
      await _box.put(item.id, item);
    }
  }

  @override
  Future<void> removeMovie(int movieId) async {
    if (_box.containsKey(movieId)) {
      await _box.delete(movieId);
    }
  }
}
