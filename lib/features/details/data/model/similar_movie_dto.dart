import 'package:movie/features/details/domain/entities/similar_movie_entity.dart';

class SimilarMovieDto {
  final int id;
  final String? posterPath;
  final String? title;

  const SimilarMovieDto({
    required this.id,
    this.posterPath,
    this.title,
  });

  factory SimilarMovieDto.fromJson(Map<String, dynamic> json) {
    return SimilarMovieDto(
      id: json['id'] ?? 0,
      posterPath: json['poster_path'],
      title: json['title'],
    );
  }

  SimilarMovieEntity toEntity() {
    return SimilarMovieEntity(
      id: id,
      posterPath: posterPath,
      title: title,
    );
  }
}