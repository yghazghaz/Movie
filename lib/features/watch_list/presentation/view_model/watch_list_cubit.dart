import 'package:movie/features/watch_list/domain/entities/watch_list_entity.dart';
import 'package:movie/features/watch_list/domain/use_cases/watch_list_use_case.dart';
import 'package:movie/features/watch_list/presentation/view_model/watch_list_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WatchListCubit extends Cubit<WatchListState> {
  final GetWatchListUseCase getWatchListUseCase;
  final ToggleWatchListUseCase toggleWatchListUseCase;
  final RemoveFromWatchListUseCase removeFromWatchListUseCase;
  final IsMovieSavedUseCase isMovieSavedUseCase;

  WatchListCubit({
    required this.getWatchListUseCase,
    required this.toggleWatchListUseCase,
    required this.removeFromWatchListUseCase,
    required this.isMovieSavedUseCase,
  }) : super(const WatchListInitial()) {
    loadWatchList();
  }

  void loadWatchList() {
    final items = getWatchListUseCase();
    emit(WatchListLoaded(items));
  }

  bool isMovieSaved(int movieId) => isMovieSavedUseCase(movieId);

  Future<void> toggleMovie(WatchListEntity item) async {
    final cachedItems = List<WatchListEntity>.from(state.items);
    try {
      emit(WatchListLoading(cachedItems));
      await toggleWatchListUseCase(item);
      emit(WatchListLoaded(getWatchListUseCase()));
    } catch (e) {
      emit(WatchListError(e.toString(), cachedItems));
    }
  }

  Future<void> removeMovie(int movieId) async {
    await removeFromWatchListUseCase(movieId);
    emit(WatchListLoaded(getWatchListUseCase()));
  }
}
