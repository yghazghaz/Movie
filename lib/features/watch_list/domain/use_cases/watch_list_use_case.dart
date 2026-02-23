import 'package:movie/features/watch_list/domain/entities/watch_list_entity.dart';
import 'package:movie/features/watch_list/domain/repositories/watch_list_repository.dart';

class GetWatchListUseCase {
  final WatchListRepository repository;
  GetWatchListUseCase(this.repository);

  List<WatchListEntity> call() => repository.getWatchList();
}

class ToggleWatchListUseCase {
  final WatchListRepository repository;
  ToggleWatchListUseCase(this.repository);

  Future<void> call(WatchListEntity item) => repository.toggleMovie(item);
}

class RemoveFromWatchListUseCase {
  final WatchListRepository repository;
  RemoveFromWatchListUseCase(this.repository);

  Future<void> call(int movieId) => repository.removeMovie(movieId);
}

class IsMovieSavedUseCase {
  final WatchListRepository repository;
  IsMovieSavedUseCase(this.repository);

  bool call(int movieId) => repository.isMovieSaved(movieId);
}
