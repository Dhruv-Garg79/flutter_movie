import 'package:flutter/material.dart';
import 'package:movie/dimensions.dart';
import 'package:movie/models/movie.dart';
import 'package:movie/screens/movie_detail_screen.dart';

class MovieWidget extends StatelessWidget {
  final Movie movie;
  MovieWidget(this.movie);

  @override
  Widget build(BuildContext context) {
    var imageWidth = Dimensions.imageWidth(context);
    return Container(
      margin: EdgeInsets.only(bottom: Dimensions.medium),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context)
              .pushNamed(MovieDetailScreen.routeName, arguments: movie.id);
        },
        child: Stack(
          children: <Widget>[
            Positioned.fill(
              left: imageWidth - 2,
              child: Card(
                margin: EdgeInsets.symmetric(vertical: Dimensions.medium),
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: Dimensions.big,
                    top: Dimensions.big,
                    bottom: Dimensions.medium,
                    right: Dimensions.small
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        movie.title,
                        textAlign: TextAlign.start,
                        maxLines: 2,
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Released on : ${movie.release_date}',
                        style: TextStyle(fontSize: 12),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top : 8.0),
                        child: Text(
                          movie.overview,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.network(
                movie.smallPosterPath,
                fit: BoxFit.cover,
                width: imageWidth,
              ),
            ),
            Positioned(
              top: 10,
              left: imageWidth - 20,
              child: CircleAvatar(
                backgroundColor: Colors.amber,
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Text(
                    movie.vote_average,
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
