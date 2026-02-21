abstract class ApiConstants {
  static const String apiBaseUrl = "api.themoviedb.org";
  static const String apiKey = "c4c826652f54893fe872b430fcab0d60";

  static const String apiMovieEndPoint = "/3/movie/";
  static const String apiPopularEndPoint = "/3/movie/popular";
  static const String apiReleasesEndPoint = "/3/movie/upcoming";
  static const String apiRecommendEndPoint = "/3/movie/top_rated";
  static const String apiSearchEndpoint = "/3/search/movie";
  static const String apiGenreIdEndPoint =
      "/3/discover/movie?include_adult=true&sort_by=vote_count.desc";
  static const String imagePath = "https://image.tmdb.org/t/p/w500";
}
