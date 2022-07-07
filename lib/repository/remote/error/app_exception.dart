class AppException implements Exception {
  final String _prefix;
  final String _message;
  AppException(this._prefix, this._message);

  @override
  String toString() => '$_prefix$_message';
}

class FetchDataException extends AppException {
  FetchDataException(
    String message,
  ) : super('Fetch Data error:', message);
}

class NotInternet extends AppException {
  NotInternet(
    String message,
  ) : super('Not connection internet', message);
}

class BadRequestException extends AppException {
  BadRequestException(
    String message,
  ) : super('Internal Server Error :', message);
}

class UnauthorizedException extends AppException {
  UnauthorizedException(
    String message,
  ) : super('Unauthorized :', message);
}

class RemoteException extends AppException {
  RemoteException(
    String message,
  ) : super('Unauthorized :', message);
}
