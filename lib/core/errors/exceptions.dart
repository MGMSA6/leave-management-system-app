// exceptions.dart

class ServerException implements Exception {
  final String message;

  const ServerException([this.message = "Something went wrong on the server."]);
}

class NetworkException implements Exception {
  final String message;

  const NetworkException([this.message = "No internet connection."]);
}

class CacheException implements Exception {
  final String message;

  const CacheException([this.message = "Cache error occurred."]);
}

class UnauthorizedException implements Exception {
  final String message;

  const UnauthorizedException([this.message = "Unauthorized access."]);
}

class UnexpectedException implements Exception {
  final String message;

  const UnexpectedException([this.message = "An unexpected error occurred."]);
}
