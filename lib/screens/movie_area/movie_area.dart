import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/movie_provider.dart';
import '../../repository/remote/my_api_sevice.dart';
import '../../utilities/error_handle_factory.dart';

class MovieArea extends StatefulWidget {
  const MovieArea({Key? key}) : super(key: key);

  @override
  State<MovieArea> createState() => _MovieAreaState();
}

class _MovieAreaState extends State<MovieArea> {
  @override
  void initState() {
    super.initState();
    Provider.of<MovieStore>(context, listen: false)
        .fetchMoviesByCategory(Category.week);
    Provider.of<MovieStore>(context, listen: false).handleError = (error) {
      ErrorHandleFactory.handleErrorByType(context, error);
    };
  }

  @override
  Widget build(BuildContext context) {
    var movieStore = Provider.of<MovieStore>(context);

    return RefreshIndicator(
      onRefresh: () async {
        movieStore.fetchMoviesByCategory(Category.week);
      },
      child: ListView(
        children: [
          ...movieStore.getMovies.map(
            (e) => Text(e.title ?? ""),
          ),
          ...movieStore.getMovies.map(
            (e) => Text(e.title ?? ""),
          ),
        ],
      ),
    );
  }
}
