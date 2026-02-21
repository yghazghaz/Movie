import '../error/failure.dart';

sealed class ApiResult<T> {}

class ApiSuccess<T> extends ApiResult<T> {
  final T data;
  ApiSuccess(this.data);
}

class ApiError<T> extends ApiResult<T> {
  final Failure failure;
  ApiError(this.failure);
}

extension ApiResultX<T> on ApiResult<T> {
  R when<R>({
    required R Function(T data) success,
    required R Function(Failure failure) error,
  }) {
    if (this is ApiSuccess<T>) {
      return success((this as ApiSuccess<T>).data);
    } else if (this is ApiError<T>) {
      return error((this as ApiError<T>).failure);
    }
    throw Exception('Unknown ApiResult type');
  }
}