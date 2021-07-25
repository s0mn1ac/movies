import 'package:flutter/material.dart';

import 'package:movies/models/models.dart';

class MovieSliderWidget extends StatelessWidget {

  final List<MovieModel> movies;
  final String? title;

  const MovieSliderWidget({ Key? key, required this.movies, this.title }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Container(
      width: double.infinity,
      height: 260.0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[

          if (this.title != null)
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(title!, style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
            ),

          SizedBox(height: 5.0),
          
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 20,
              itemBuilder: (_, int index) => _MoviePoster(movies[index])
            ),
          )
        ],
      ),
    );
  }

}

class _MoviePoster extends StatelessWidget {

  final MovieModel movie;

  const _MoviePoster(this.movie);

  @override
  Widget build(BuildContext context) {

    return Container(
      width: 130.0,
      height: 190.0,
      margin: EdgeInsets.symmetric(horizontal: 10.0),
      child: Column(
        children: <Widget>[

          GestureDetector(
            onTap: () => Navigator.pushNamed(context, 'details', arguments: 'movie-instance'),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: FadeInImage(
                placeholder: AssetImage('assets/no-image.jpg'),
                image: NetworkImage(movie.fullPosterImageUrl),
                width: 130.0,
                height: 190.0,
                fit: BoxFit.cover
              ),
            ),
          ),
          SizedBox(height: 5.0),
          Text(
            movie.title,
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
            textAlign: TextAlign.center
          )
        ],
      ),
    );
  }

}