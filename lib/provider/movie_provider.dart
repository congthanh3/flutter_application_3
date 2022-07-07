import 'package:flutter/material.dart';

import '../models/movie.dart';
import '../repository/remote/my_api_sevice.dart';
import '../repository/repository.dart';

class MovieStore extends ChangeNotifier {
  final _repository = Repository();
  void Function(Object)? handleError;
  final List<Movie> _movies = [];

  List<Movie> get getMovies => _movies;

  void fetchMoviesByCategory(Category category) {
    _movies.clear();
    _repository.fetchMoviesByCategory(category).then((newMovies) {
      _movies.addAll(newMovies);
      notifyListeners();
    }).catchError((error) {
      handleError?.call(error);
    });
  }
}
