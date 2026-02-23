abstract class Failure {
  final String message;
  const Failure(this.message);
}

class ServerFailure extends Failure {
  const ServerFailure(super.message);
}

class NetworkFailure extends Failure {
  const NetworkFailure() : super("No internet connection");
}

class UnauthorizedFailure extends Failure {
  const UnauthorizedFailure() : super("Unauthorized");
}

class NotFoundFailure extends Failure {
  const NotFoundFailure() : super("Not found");
}
