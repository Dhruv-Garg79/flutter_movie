import 'package:flutter/material.dart';
import 'package:movie/providers/movies_provider.dart';
import 'package:movie/providers/network_provider.dart';
import 'package:movie/routes.dart';
import 'package:movie/screens/all_movies_screen.dart';
import 'package:movie/theme.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => NetworkProvider(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => MoviesProvider(),
        )
      ],
      child: MaterialApp(
        title: 'Movie Palace',
        theme: AppTheme.darkTheme,
        initialRoute: AllMoviesScreen.routeName,
        routes: Routes.routes,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
