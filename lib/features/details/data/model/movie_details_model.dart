

import 'package:movie/features/details/domain/entities/movie_details_entity.dart';

class MovieDetailsModel extends MovieDetailsEntity {
  const MovieDetailsModel({
    required super.backdropPath,
    required super.posterPath,
    required super.title,
    required super.releaseDate,
    required super.voteAverage,
    required super.runtime,
    required super.overview,
    required super.genres,
  });

  factory MovieDetailsModel.fromJson(Map<String, dynamic> json) {
    return MovieDetailsModel(
      backdropPath: json['backdrop_path'] ?? '',
      posterPath: json['poster_path'] ?? '',
      title: json['title'] ?? '',
      releaseDate: json['release_date'] ?? '',
      voteAverage: (json['vote_average'] as num?)?.toDouble() ?? 0.0,
      runtime: json['runtime'] ?? 0,
      overview: json['overview'] ?? '',
      genres: List<String>.from(json['genres'].map((e) => e['name'])),
    );
  }
}
