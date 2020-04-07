import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:http/http.dart';
import 'package:movie/constants.dart';
import 'package:movie/models/movie.dart';

import '../keys.dart';

class MoviesProvider with ChangeNotifier{
  List<Movie> _movies = [];

  List<Movie> get movies => [..._movies];

  Movie getMovieById(String id){
    return _movies.firstWhere((item) => item.id == id);
  }

  Future<List<Movie>> fetchMovies() async{
    if(_movies.length > 0)
      return movies;
    
    try{
      final url = "${Constants.baseUrl}/popular?api_key=${Keys.api_key}";
      final response = await get(url);
      final result = json.decode(response.body)['results'] as List<dynamic>;
      print(result);
      List<Movie> tempList = [];
      result.forEach((item){
        tempList.add(Movie.fromMap(item));
      });
      _movies = tempList;
      notifyListeners();
      return movies;
    }
    catch(err){
      print(err);
      throw err;
    }
  }

  Future<String> fetchMovieYoutubeLink(Movie movie) async{
    if(movie.youtubeLink.isNotEmpty)
      return movie.youtubeLink;
    try{
      final url = "${Constants.baseUrl}/${movie.id}/videos?api_key=${Keys.api_key}";
      final response = await get(url);
      final result = json.decode(response.body)['results'] as List<dynamic>;
      
      int i = _movies.indexOf(movie);
      _movies[i].youtubeLink = result[0]['key'];
      notifyListeners();
      return _movies[i].youtubeLink;
    }
    catch(err){
      print(err);
      throw err;
    }
  }
}