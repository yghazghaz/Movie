import 'package:movie/features/home/domain/entites/recommended_movies_entites.dart';

class MoviesDto {
  int? page;
  List<ResultsDto>? results;
  int? totalPages;
  int? totalResults;

  MoviesDto({this.page, this.results, this.totalPages, this.totalResults});

  MoviesDto.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    if (json['results'] != null) {
      results = <ResultsDto>[];
      json['results'].forEach((v) {
        results!.add(ResultsDto.fromJson(v));
      });
    }
    totalPages = json['total_pages'];
    totalResults = json['total_results'];
  }
  MoviesEntites toEntity() =>
      MoviesEntites(results: results?.map((e) => e.toEntity()).toList() ?? []);
}

class ResultsDto {
  bool? adult;
  String? backdropPath;
  List<int>? genreIds;
  int? id;
  String? originalLanguage;
  String? originalTitle;
  String? overview;
  double? popularity;
  String? posterPath;
  String? releaseDate;
  String? title;
  bool? video;
  double? voteAverage;
  int? voteCount;

  ResultsDto({
    this.adult,
    this.backdropPath,
    this.genreIds,
    this.id,
    this.originalLanguage,
    this.originalTitle,
    this.overview,
    this.popularity,
    this.posterPath,
    this.releaseDate,
    this.title,
    this.video,
    this.voteAverage,
    this.voteCount,
  });

  ResultsDto.fromJson(Map<String, dynamic> json) {
    adult = json['adult'];
    backdropPath = json['backdrop_path'];
    genreIds = json['genre_ids'].cast<int>();
    id = json['id'];
    originalLanguage = json['original_language'];
    originalTitle = json['original_title'];
    overview = json['overview'];
    popularity = json['popularity'];
    posterPath = json['poster_path'];
    releaseDate = json['release_date'];
    title = json['title'];
    video = json['video'];
    voteAverage = json['vote_average'];
    voteCount = json['vote_count'];
  }
  ResultsEntity toEntity() => ResultsEntity(
    id: id ?? 0,
    title: title ?? 'Unknown',
    posterPath: posterPath ?? '',
    backdropPath: backdropPath ?? '',
    voteAverage: (voteAverage ?? 0.0).toDouble(),
    releaseDate: releaseDate ?? '',
  );
}
