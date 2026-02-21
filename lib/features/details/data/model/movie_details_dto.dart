import 'package:movie/features/details/domain/entities/movie_details_entity.dart';

class MovieDetailsDto {
  final String backdropPath;
  final String posterPath;
  final String title;
  final String releaseDate;
  final double voteAverage;
  final int runtime;
  final String overview;
  final List<String> genres;
  final List<int> genreIds;

  const MovieDetailsDto({
    required this.backdropPath,
    required this.posterPath,
    required this.title,
    required this.releaseDate,
    required this.voteAverage,
    required this.runtime,
    required this.overview,
    required this.genres,
    required this.genreIds,
  });

  factory MovieDetailsDto.fromJson(Map<String, dynamic> json) {
    final genresList = json['genres'] as List? ?? [];

    return MovieDetailsDto(
      backdropPath: json['backdrop_path'] ?? '',
      posterPath: json['poster_path'] ?? '',
      title: json['title'] ?? '',
      releaseDate: json['release_date'] ?? '',
      voteAverage: (json['vote_average'] as num?)?.toDouble() ?? 0.0,
      runtime: json['runtime'] ?? 0,
      overview: json['overview'] ?? '',
      genres: genresList.map((e) => e['name'] as String).toList(),
      genreIds: genresList.map((e) => e['id'] as int).toList(),
    );
  }

  MovieDetailsEntity toEntity() {
    return MovieDetailsEntity(
      backdropPath: backdropPath,
      posterPath: posterPath,
      title: title,
      releaseDate: releaseDate,
      voteAverage: voteAverage,
      runtime: runtime,
      overview: overview,
      genres: genres,
      genreIds: genreIds,
    );
  }
}