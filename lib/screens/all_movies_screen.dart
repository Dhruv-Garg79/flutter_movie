import 'package:flutter/material.dart';
import 'package:movie/dimensions.dart';
import 'package:movie/models/movie.dart';
import 'package:movie/providers/movies_provider.dart';
import 'package:movie/widgets/movie_widget.dart';
import 'package:movie/widgets/network_widget.dart';
import 'package:provider/provider.dart';

class AllMoviesScreen extends StatelessWidget {
  static const routeName = '/allMoviesScreen';

  Future<List<Movie>> _refreshMovies(BuildContext context) async {
    return await Provider.of<MoviesProvider>(context).fetchMovies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Movie Palace'),
      ),
      body: NetworkWidget(
        child: FutureBuilder(
          future: _refreshMovies(context),
          builder: (ctx, snap) =>
              snap.connectionState == ConnectionState.waiting
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : RefreshIndicator(
                      child: buildMovieList(snap.data),
                      onRefresh: () => _refreshMovies(context),
                    ),
        ),
      ),
    );
  }

  Widget buildMovieList(List<Movie> list) {
    return Container(
      margin: EdgeInsets.only(
        top: Dimensions.all,
        left: Dimensions.all,
        right: Dimensions.all,
      ),
      child: ListView.builder(
        itemBuilder: (ctx, i) => MovieWidget(list[i]),
        itemCount: list.length,
      ),
    );
  }
}
