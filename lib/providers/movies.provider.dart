import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

import 'package:movies/models/models.dart';

class MoviesProvider extends ChangeNotifier {

  String _baseUrl = 'api.themoviedb.org';
  String _apiKey = '2891e2c2ab994cbd1bec6f4582e77b9e';
  String _language = 'es-ES';

  List<MovieModel> onDisplayMovies = [];

  MoviesProvider() {
    print('MoviesProvider inicializado');
    this.getOnDisplayMovies();
  }

  getOnDisplayMovies() async {

    var url = Uri.https(_baseUrl, '3/movie/now_playing', {
      'api_key': _apiKey,
      'language': _language,
      'page': '1'
    });

    final response = await http.get(url);
    final nowPlayingResponse = NowPlayingResponseModel.fromJson(response.body);

    onDisplayMovies = nowPlayingResponse.results;

    notifyListeners();
  }

}