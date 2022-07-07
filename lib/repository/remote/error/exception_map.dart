import 'app_exception.dart';

abstract class ExceptionMap implements Exception {
  AppException map(Object? error);
}
