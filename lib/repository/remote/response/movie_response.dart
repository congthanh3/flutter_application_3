import 'package:json_annotation/json_annotation.dart';

import '../../../models/movie.dart';

part 'movie_response.g.dart';

@JsonSerializable()
class MovieResponse {
  @JsonKey(name: 'page')
  int? page;
  @JsonKey(name: 'total_results')
  double? totalResults;
  @JsonKey(name: 'total_pages')
  int? totalPages;
  @JsonKey(name: 'results')
  List<Movie>? results;

  MovieResponse({
    this.page,
    this.totalResults,
    this.totalPages,
    this.results,
  });

  factory MovieResponse.fromJson(Map<String, dynamic> json) =>
      _$MovieResponseFromJson(json);
  Map<String, dynamic> toJson() => _$MovieResponseToJson(this);

  @override
  String toString() {
    return 'ResponseMovies(page: $page, totalResults: $totalResults, totalPages: $totalPages, results: $results)';
  }
}
