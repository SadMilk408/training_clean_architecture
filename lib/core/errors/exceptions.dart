class ServerException implements Exception {
  final String message;
  ServerException({required this.message});
}
class UnAuthException implements Exception {
  final String message;
  UnAuthException({required this.message});
}
class ConnectException implements Exception {
  final String message;
  ConnectException({required this.message});
}
class CacheException implements Exception {}