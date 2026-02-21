

import '../../domain/entities/search_response_entity.dart';
abstract class SearchState {
  const SearchState();
}

class SearchInitial extends SearchState {
  const SearchInitial();
}

class SearchEmpty extends SearchState {
  const SearchEmpty();
}

class SearchLoading extends SearchState {
  const SearchLoading();
}

class SearchSuccess extends SearchState {
  final List<ResultsEntity> movies;
  const SearchSuccess(this.movies);
}

class SearchNoResults extends SearchState {
  const SearchNoResults();
}

class SearchError extends SearchState {
  final String messageError;
  const SearchError(this.messageError);
}
