import 'dart:io';

import 'app_exception.dart';
import 'exception_map.dart';

class AppExceptionMap implements ExceptionMap {
  @override
  AppException map(Object? error) {
    switch (error) {
      case SocketException:
        throw NotInternet('No Internet connect');
      case RemoteException:
        throw RemoteException(error.toString());
      default:
        throw FetchDataException('Something error: ${error.toString()}');
    }
  }
}
