import 'package:movie/features/watch_list/domain/entities/watch_list_entity.dart';

abstract class WatchListState {
  final List<WatchListEntity> items;
  const WatchListState(this.items);
}

class WatchListInitial extends WatchListState {
  const WatchListInitial() : super(const []);
}

class WatchListLoading extends WatchListState {
  const WatchListLoading(super.items);
}

class WatchListLoaded extends WatchListState {
  const WatchListLoaded(super.items);
}

class WatchListError extends WatchListState {
  final String error;
  const WatchListError(this.error, super.items);
}
