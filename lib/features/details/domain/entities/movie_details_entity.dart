class MovieDetailsEntity {
  final String backdropPath;
  final String posterPath;
  final String title;
  final String releaseDate;
  final double voteAverage;
  final int runtime;
  final String overview;
  final List<String> genres;
  final List<int> genreIds  ;

  const MovieDetailsEntity({
    required this.backdropPath,
    required this.posterPath,
    required this.title,
    required this.releaseDate,
    required this.voteAverage,
    required this.runtime,
    required this.overview,
    required this.genres, required this.genreIds,
  });
}
