class WatchListEntity {
  const WatchListEntity({
    required this.id,
    required this.title,
    this.posterPath,
    this.backdropPath,
    this.releaseDate,
    this.voteAverage,
    required this.genreIds, this.runtime ,
  });
  final int id;
  final String title;
  final String? posterPath;
  final String? backdropPath;
  final String? releaseDate;
  final double? voteAverage;
  final double? runtime;
  final List<int>?genreIds;

}
