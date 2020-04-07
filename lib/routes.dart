import 'package:flutter/widgets.dart';
import 'package:movie/screens/all_movies_screen.dart';
import 'package:movie/screens/movie_detail_screen.dart';

class Routes{
  static final _routes = <String, WidgetBuilder> {
    AllMoviesScreen.routeName: (BuildContext context) => AllMoviesScreen(),
    MovieDetailScreen.routeName: (BuildContext context) => MovieDetailScreen()
  };

  static Map<String, WidgetBuilder> get routes => _routes;
}