import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';
import 'package:movie/core/error/failure.dart';
import 'package:movie/features/search/data/models/search_response_dto.dart';

import '../../../../core/network/error_status_code_handle.dart';
import '../../../../core/network/result.dart';
import '../../../../core/utils/api_constants.dart';

@lazySingleton
class SearchApi {
  Future<ApiResult<SearchResponseDto>> getSearchMovie(String query) async {
    try {
      Uri url = Uri.https(
        ApiConstants.apiBaseUrl,
        ApiConstants.apiSearchEndpoint,
        {'api_key': ApiConstants.apiKey, 'query': query},
      );

      final response = await http.get(url);
      final json = jsonDecode(response.body);
      if (response.statusCode >= 200 && response.statusCode < 300) {
        return ApiSuccess<SearchResponseDto>(SearchResponseDto.fromJson(json));
      } else {
        return ApiError<SearchResponseDto>(
          ErrorStatusCodeHandle.handle(response.statusCode, json),
        );
      }
    } catch (e) {
      if (e is SocketException) {
        return ApiError<SearchResponseDto>(const NetworkFailure());
      }
      return ApiError<SearchResponseDto>(
        const ServerFailure("Something went wrong. Please try again."),
      );
    }
  }
}
