import 'package:flutter/material.dart';

import 'package:movies/models/models.dart';

class MovieSliderWidget extends StatefulWidget {

  final List<MovieModel> movies;
  final String? title;
  final Function onNextPage;

  const MovieSliderWidget({ Key? key, required this.movies, required this.onNextPage, this.title }) : super(key: key);

  @override
  _MovieSliderWidgetState createState() => _MovieSliderWidgetState();
}

class _MovieSliderWidgetState extends State<MovieSliderWidget> {

  final ScrollController scrollController = new ScrollController();

  @override
  void initState() { 
    super.initState();
    scrollController.addListener(() {
      if (scrollController.position.pixels >= scrollController.position.maxScrollExtent - 500) {
        widget.onNextPage();
      }
    });
  }

  @override
  void dispose() {

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    if (this.widget.movies.length == 0) {
      return Container(
        width: double.infinity,
        height: 260.0,
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Container(
      width: double.infinity,
      height: 260.0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[

          if (this.widget.title != null)
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(this.widget.title!, style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
            ),

          SizedBox(height: 5.0),
          
          Expanded(
            child: ListView.builder(
              controller: scrollController,
              scrollDirection: Axis.horizontal,
              itemCount: this.widget.movies.length,
              itemBuilder: (_, int index) => _MoviePoster(widget.movies[index])
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