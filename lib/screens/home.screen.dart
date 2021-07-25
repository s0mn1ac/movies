import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:movies/providers/movies.provider.dart';
import 'package:movies/widgets/widgets.dart';


class HomeScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final moviesProvider = Provider.of<MoviesProvider>(context, listen: true);

    return Scaffold(
      appBar: AppBar(
        title: Text('En cartelera'),
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.search_outlined)
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            CardSwiperWidget(movies: moviesProvider.onDisplayMovies),
            MovieSliderWidget(movies: moviesProvider.popularMovies, title: 'Las más populares')
          ],
        ),
      )
    );
  }
}