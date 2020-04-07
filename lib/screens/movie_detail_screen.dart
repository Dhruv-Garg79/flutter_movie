import 'package:flutter/material.dart';
import 'package:movie/constants.dart';
import 'package:movie/dimensions.dart';
import 'package:movie/models/movie.dart';
import 'package:movie/providers/movies_provider.dart';
import 'package:movie/widgets/network_widget.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class MovieDetailScreen extends StatelessWidget {
  static const routeName = '/movieDetailScreen';

  Future<void> _launchYouTube(BuildContext context, String link) async {
    final url = '${Constants.youtube}?v=$link';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      Scaffold.of(context).showSnackBar(
          SnackBar(content: Text("can't watch this trailer right now!")));
    }
  }

  @override
  Widget build(BuildContext context) {
    String movieId = ModalRoute.of(context).settings.arguments as String;
    Movie movie = Provider.of<MoviesProvider>(context, listen: false)
        .getMovieById(movieId);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      extendBodyBehindAppBar: true,
      body: NetworkWidget(
        child: Stack(
          children: <Widget>[
            Hero(
              tag: movie.id,
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(movie.largePosterPath),
                    fit: BoxFit.fitHeight,
                  ),
                ),
              ),
            ),
            buildDetailCard(context, movie),
          ],
        ),
      ),
    );
  }

  Widget buildDetailCard(BuildContext context, Movie movie) {
    return Positioned(
      bottom: 32.0,
      left: 10.0,
      right: 10.0,
      child: Card(
        color: Theme.of(context).primaryColor,
        elevation: 4.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Column(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(Dimensions.medium),
              constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width * 0.6),
              child: Text(
                movie.title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(Dimensions.medium),
              child: Text(
                movie.overview,
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical : Dimensions.medium),
              child: FutureBuilder(
                future: Provider.of<MoviesProvider>(context, listen: false)
                    .fetchMovieYoutubeLink(movie),
                builder: (ctx, snap) =>
                    snap.connectionState == ConnectionState.waiting
                        ? CircularProgressIndicator()
                        : RaisedButton(
                            color: Theme.of(context).cardColor,
                            child: Text('Watch Trailer'),
                            onPressed: () async {
                              _launchYouTube(context, snap.data);
                            }
                          ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
