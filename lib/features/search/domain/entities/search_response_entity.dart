class SearchResponseEntity {
  int page;
  List<ResultsEntity> results;
  int totalPages;
  int totalResults;

  SearchResponseEntity({
    this.page = 0,
    this.results = const [],
    this.totalPages = 0,
    this.totalResults = 0,
  });
}

class ResultsEntity {
  int id;
  String title;
  String posterPath;
  List<int> genreIds;
  String releaseDate;
  double voteAverage;
  final String year;
  final String genreName;

  ResultsEntity({
    this.genreIds = const [],
    this.id = 0,
    this.posterPath = '',
    this.releaseDate = '',
    this.title = '',
    this.voteAverage = 0,
    this.year = 'N/A',
    this.genreName = 'UnKnown',
  });
}
