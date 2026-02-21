import 'package:movie/core/utils/app_hive.dart';
import 'package:movie/features/watch_list/domain/entities/watch_list_entity.dart';
import 'package:hive/hive.dart';

class WatchListModel extends WatchListEntity {
  const WatchListModel({
    required super.id,
    required super.title,
    super.posterPath,
    super.backdropPath,
    super.releaseDate,
    super.voteAverage,
  });

  factory WatchListModel.fromEntity(WatchListEntity entity) {
    return WatchListModel(
      id: entity.id,
      title: entity.title,
      posterPath: entity.posterPath,
      backdropPath: entity.backdropPath,
      releaseDate: entity.releaseDate,
      voteAverage: entity.voteAverage,
    );
  }
}

class WatchListModelAdapter extends TypeAdapter<WatchListModel> {
  @override
  int get typeId => AppHive.watchListItemTypeId;

  @override
  WatchListModel read(BinaryReader reader) {
    return WatchListModel(
      id: reader.read() as int,
      title: reader.read() as String,
      posterPath: reader.read() as String?,
      backdropPath: reader.read() as String?,
      releaseDate: reader.read() as String?,
      voteAverage: reader.read() as double?,
    );
  }

  @override
  void write(BinaryWriter writer, WatchListModel obj) {
    writer
      ..write(obj.id)
      ..write(obj.title)
      ..write(obj.posterPath)
      ..write(obj.backdropPath)
      ..write(obj.releaseDate)
      ..write(obj.voteAverage);
  }
}
