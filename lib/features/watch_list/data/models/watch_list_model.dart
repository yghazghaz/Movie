import 'package:hive/hive.dart';
import 'package:movie/core/utils/app_hive.dart';
import 'package:movie/features/watch_list/domain/entities/watch_list_entity.dart';

class WatchListModel extends WatchListEntity {
  const WatchListModel({
    required super.id,
    required super.title,
    super.runtime,
    super.posterPath,
    super.backdropPath,
    super.releaseDate,
    super.voteAverage, required super.genreIds,
  });

  factory WatchListModel.fromEntity(WatchListEntity entity) {
    return WatchListModel(
      id: entity.id,
      title: entity.title,
      runtime: entity.runtime,
      posterPath: entity.posterPath,
      backdropPath: entity.backdropPath,
      releaseDate: entity.releaseDate,
      voteAverage: entity.voteAverage, genreIds:entity.genreIds,
      
    );
  }
}

class WatchListModelAdapter extends TypeAdapter<WatchListModel> {
  @override
  int get typeId => AppHive.watchListItemTypeId;

  @override
  WatchListModel read(BinaryReader reader) {
    return WatchListModel(
      id: reader.read() ,
      title: reader.read() ,
      runtime: reader.read(),
      posterPath: reader.read() ,
      backdropPath: reader.read() ,
      releaseDate: reader.read() ,
      voteAverage: reader.read(), 
      genreIds:reader.read(),
    );
  }

  @override
  void write(BinaryWriter writer, WatchListModel obj) {
    writer
      ..write(obj.id)
      ..write(obj.title)
      ..write(obj.runtime)
      ..write(obj.posterPath)
      ..write(obj.backdropPath)
      ..write(obj.releaseDate)
      ..write(obj.voteAverage)
      ..write(obj.genreIds);
  }
}
