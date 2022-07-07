import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

import '../../constants/all_constants.dart';
import 'response/base_response.dart';
import 'response/movie_response.dart';

part 'rest_client.g.dart';

@RestApi(baseUrl: AppConstants.baseUrl)
abstract class RestClient {
  factory RestClient(Dio dio, {String baseUrl}) = _RestClient;

  @GET("/movie/{type}")
  Future<MovieResponse> fetchMoviesByCategory(
    @Path('type') String type, {
    @Query(AppConstants.apiKey) String apiKey = AppConstants.apiKeyValue,
  });

  @GET("/movie/{type}")
  Future<BaseResponse<MovieResponse>> fetchMoviesByCategoryBaseResponse(
    @Path('type') String type, {
    @Query(AppConstants.apiKey) String apiKey = AppConstants.apiKeyValue,
  });
}
