class ServerException implements Exception {
  final String message;
  final int? statusCode;
  const ServerException({required this.message, this.statusCode});
}

class CacheException implements Exception {
  final String message;
  const CacheException({this.message = 'Cache operation failed'});
}

class AuthException implements Exception {
  final String message;
  const AuthException({this.message = 'Not authenticated'});
}