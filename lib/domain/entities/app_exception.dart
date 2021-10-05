class AppException implements Exception {
  final AppExceptionType type;
  final String? msg;

  const AppException({required this.type, this.msg});

  @override
  String toString() => msg ?? 'AppException of type $type';
}

enum AppExceptionType {database, network, api}