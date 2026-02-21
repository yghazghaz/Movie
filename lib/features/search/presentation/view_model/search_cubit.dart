import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:movie/features/search/domain/entities/search_response_entity.dart';
import 'package:movie/features/search/domain/repositories/search_repository/search_repository.dart';
import 'package:movie/features/search/domain/use_cases/search_movies_use_case.dart';
import 'package:movie/features/search/presentation/view_model/search_state.dart';

import '../../../../core/network/result.dart';

@injectable
class SearchCubit extends Cubit<SearchState> {
  SearchCubit(
    this._searchMoviesUseCase, {
    required SearchRepository searchRepository,
  }) : super(SearchInitial());
  final SearchMoviesUseCase _searchMoviesUseCase;

  Future<void> intent(String query) async {
    if (query.trim().isEmpty) {
      emit(const SearchEmpty());
      return;
    }
    emit(SearchLoading());

    var result = await _searchMoviesUseCase.invoke(query);
    switch (result) {
      case ApiSuccess<List<ResultsEntity>>():
        if (result.data.isEmpty) {
          emit(const SearchNoResults());
        } else {
          emit(SearchSuccess(result.data));
        }
      case ApiError<List<ResultsEntity>>():
        emit(SearchError(result.failure.message));
    }
  }
}
