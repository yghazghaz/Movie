import 'package:movie/features/watch_list/data/api/watch_list_local_datasource.dart';
import 'package:movie/features/watch_list/data/models/watch_list_model.dart';

class WatchListLocalDataSourceImpl implements WatchListLocalDataSource {
  final List<WatchListModel> _movies = [];

  @override
  List<WatchListModel> getWatchList() {
    return List.unmodifiable(_movies);
  }

  @override
  bool isMovieSaved(int movieId) {
    return _movies.any((movie) => movie.id == movieId);
  }

  @override
  Future<void> toggleMovie(WatchListModel model) async {
    final isSaved = isMovieSaved(model.id);

    if (isSaved) {
      _movies.removeWhere((movie) => movie.id == model.id);
    } else {
      _movies.add(model);
    }
  }

  @override
  Future<void> removeMovie(int movieId) async {
    _movies.removeWhere((movie) => movie.id == movieId);
  }
}
