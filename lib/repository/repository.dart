import 'package:logger/logger.dart';
import 'package:dio/dio.dart';

import '../constants/all_constants.dart';
import '../models/movie.dart';
import 'remote/error/app_exception.dart';
import 'remote/error/app_exception_map.dart';
import 'remote/my_api_sevice.dart';
import 'remote/rest_client.dart';

var logger = Logger();

class Repository {
  // final _apiService = MyApiService();
  final _restClient = RestClient(Dio());
  final errorMap = AppExceptionMap();

  Future<List<Movie>> fetchMoviesByCategory(Category category) async {
    try {
      final response = await _restClient.fetchMoviesByCategory(
        category.path,
        apiKey: AppConstants.apiKeyValue,
      );

      return response.results ?? [];
    } catch (error) {
      logger.e(error);
      throw errorMap.map(error);
    }
  }

  Future<List<Movie>> fetchMoviesByCategoryBaseResponse(
      Category category) async {
    try {
      final response = await _restClient.fetchMoviesByCategoryBaseResponse(
        category.path,
        apiKey: AppConstants.apiKeyValue,
      );
      if (response.statusCode == 10) {
        throw errorMap.map(RemoteException(response.statusMessage ?? ''));
      }
      return response.data?.results ?? [];
    } catch (error) {
      logger.e(error);
      throw errorMap.map(error);
    }
  }
}
