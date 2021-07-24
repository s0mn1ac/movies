import 'package:flutter/material.dart';

class CastListWidget extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return Container(
      margin: EdgeInsets.only(bottom: 30.0),
      width: double.infinity,
      height: 180.0,
      child: ListView.builder(
        itemCount: 10,
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, int index) => _CastCard(),
      ),
    );
  }
}

class _CastCard extends StatelessWidget {

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
              image: NetworkImage('https://via.placeholder.com/150x300'),
              height: 140.0,
              width: 100.0,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(height: 5.0),
          Text('actor.name',
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}