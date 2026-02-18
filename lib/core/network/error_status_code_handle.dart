import '../error/failure.dart';

class ErrorStatusCodeHandle {
  static Failure handle(int statusCode, dynamic body) {
    switch (statusCode) {
      case 401:
        return const UnauthorizedFailure();

      case 404:
        return const NotFoundFailure();

      case 429:
        return const ServerFailure("Too many requests");

      case 500:
      case 502:
      case 503:
      case 504:
        return const ServerFailure("Server unavailable");

      default:
        return ServerFailure("Unexpected error ($statusCode)");
    }
  }
}
