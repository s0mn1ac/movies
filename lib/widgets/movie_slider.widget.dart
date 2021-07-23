import 'package:flutter/material.dart';

class MovieSliderWidget extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return Container(
      width: double.infinity,
      height: 260.0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: Text('Populares', style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
          ),
          SizedBox(height: 5.0),
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 20,
              itemBuilder: (_, int index) => _MoviePoster()
            ),
          )
        ],
      ),
    );
  }

}

class _MoviePoster extends StatelessWidget {

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
                image: NetworkImage('https://via.placeholder.com/300x400'),
                width: 130.0,
                height: 190.0,
                fit: BoxFit.cover
              ),
            ),
          ),
          SizedBox(height: 5.0),
          Text(
            'nelvervkloermvmrelmvlkremlvmrmvmdklmvldfmlvmdflmbv,df,bnm,dfnmbndm,nb,mdnbm,dnfm,nf,bmdnfnb,dnfm,bnd',
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
            textAlign: TextAlign.center
          )
        ],
      ),
    );
  }

}