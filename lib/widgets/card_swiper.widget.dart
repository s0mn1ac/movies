import 'package:flutter/material.dart';

import 'package:card_swiper/card_swiper.dart';
import 'package:movies/models/models.dart';


class CardSwiperWidget extends StatelessWidget {

  final List<MovieModel> movies;

  const CardSwiperWidget({ Key? key, required this.movies }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

    if (this.movies.length == 0) {
      
      return Container(
        width: double.infinity,
        height: size.height * 0.5,
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Container(
      width: double.infinity,
      height: size.height * 0.5,
      child: Swiper(
        itemCount: movies.length,
        layout: SwiperLayout.STACK,
        itemWidth: size.width * 0.6,
        itemHeight: size.height * 0.45,
        itemBuilder: (BuildContext context, int index) {

          final movie = movies[index];
          
          return GestureDetector(
            onTap: () => Navigator.pushNamed(context, 'details', arguments: movie),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: FadeInImage(
                placeholder: AssetImage('assets/no-image.jpg'),
                image: NetworkImage(movie.fullPosterParh),
                fit: BoxFit.cover,
              ),
            ),
          );
        },
      )
    );
  }
}