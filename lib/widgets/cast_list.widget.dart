import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:movies/providers/movies.provider.dart';
import 'package:movies/models/models.dart';
import 'package:provider/provider.dart';

class CastListWidget extends StatelessWidget {

  final int movieId;

  const CastListWidget({Key? key, required this.movieId}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final moviesProvider = Provider.of<MoviesProvider>(context, listen: false);

    return FutureBuilder(
      future: moviesProvider.getCast(movieId),
      builder: (_, AsyncSnapshot<List<CastModel>> snapshot) {

        if (!snapshot.hasData) {

          return Container(
            width: double.infinity,
            height: 180.0,
            child: CupertinoActivityIndicator(),
          );
        }

        final List<CastModel> cast = snapshot.data!;

        return Container(
          margin: EdgeInsets.only(bottom: 30.0),
          width: double.infinity,
          height: 180.0,
          child: ListView.builder(
            itemCount: cast.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (BuildContext context, int index) => _CastCard(actor: cast[index]),
          ),
        );
      },
    );
  }

}

class _CastCard extends StatelessWidget {

  final CastModel actor;

  const _CastCard({Key? key, required this.actor}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Container(
      width: 110.0,
      height: 100.0,
      margin: EdgeInsets.symmetric(horizontal: 10.0),
      child: Column(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: FadeInImage(
              placeholder: AssetImage('assets/no-image.jpg'),
              image: NetworkImage(actor.fullProfilePath),
              height: 140.0,
              width: 100.0,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(height: 5.0),
          Text(actor.name,
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}