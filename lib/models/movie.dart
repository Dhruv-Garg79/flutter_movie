import 'dart:convert';

class Movie {
  final String id;
  final String title;
  final String overview;
  final String vote_average;
  final String release_date;
  final String poster_path;
  final String backdrop_path;
  String youtubeLink = '';

  Movie({
    this.id,
    this.title,
    this.overview,
    this.vote_average,
    this.release_date,
    this.poster_path,
    this.backdrop_path
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'overview': overview,
      'vote_average': vote_average,
      'release_date': release_date,
      'poster_path': poster_path,
      'backdrop_path' : backdrop_path,
    };
  }

  static Movie fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
  
    return Movie(
      id: map['id'].toString(),
      title: map['title'],
      overview: map['overview'],
      vote_average: map['vote_average'].toString(),
      release_date: map['release_date'],
      poster_path: map['poster_path'],
      backdrop_path: map['backdrop_path'],
    );
  }

  String toJson() => json.encode(toMap());

  static Movie fromJson(String source) => fromMap(json.decode(source));

  String get smallPosterPath => "http://image.tmdb.org/t/p/w154/${poster_path}";

  String get largePosterPath => "http://image.tmdb.org/t/p/w342/${poster_path}";
}
