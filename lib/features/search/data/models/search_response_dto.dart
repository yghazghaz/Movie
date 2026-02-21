
import 'package:movie/core/utils/genre_constants.dart';

import '../../domain/entities/search_response_entity.dart';

class SearchResponseDto {
  int? page;
  List<ResultsDto>? results;
  int? totalPages;
  int? totalResults;

  SearchResponseDto({
    this.page,
    this.results,
    this.totalPages,
    this.totalResults,
  });

  SearchResponseDto.fromJson(Map<String, dynamic> json) {
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
  SearchResponseEntity toEntity() => SearchResponseEntity(
    page: page ?? 0,
    results: results?.map((e) => e.toEntity()).toList() ?? [],
    totalPages: totalPages ?? 0,
    totalResults: totalResults ?? 0,
  );
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
    popularity = (json['popularity'] as num?)?.toDouble();
    posterPath = json['poster_path'];
    releaseDate = json['release_date'];
    title = json['title'];
    video = json['video'];
    voteAverage = (json['vote_average'] as num?)?.toDouble();
    voteCount = json['vote_count'];
  }


  ResultsEntity toEntity() {
    String year = "N/A";
    if (releaseDate != null &&
        releaseDate!.isNotEmpty &&
        releaseDate!.length >= 4) {
      year = releaseDate!.substring(0, 4);
    }

    String genreName = "Unknown";
    if (genreIds != null && genreIds!.isNotEmpty) {
      genreName = GenreConstants.movieGenres[genreIds!.first] ?? "Unknown";
    }
    final poster = posterPath ?? '';
    final rating = (voteAverage == null || voteAverage == 0)
        ? 0.0
        : voteAverage!;
    return ResultsEntity(
      genreIds: genreIds ?? [],
      id: id ?? 0,
      posterPath: poster,
      releaseDate: releaseDate ?? '',
      title: title ?? '',
      voteAverage: rating,
      year: year,
      genreName: genreName,
    );
  }
}
