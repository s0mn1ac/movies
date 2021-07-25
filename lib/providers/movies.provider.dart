import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

import 'package:movies/models/models.dart';

class MoviesProvider extends ChangeNotifier {

  String _baseUrl = 'api.themoviedb.org';
  String _apiKey = '2891e2c2ab994cbd1bec6f4582e77b9e';
  String _language = 'es-ES';

  List<MovieModel> onDisplayMovies = [];
  List<MovieModel> popularMovies = [];

  int _popularPage = 0;

  MoviesProvider() {
    this.getOnDisplayMovies();
    this.getPopularMovies();
  }

  getOnDisplayMovies() async {

    final jsonResponse = await _getJsonResponse('3/movie/now_playing');
    final nowPlayingResponse = NowPlayingResponseModel.fromJson(jsonResponse);

    onDisplayMovies = nowPlayingResponse.results;

    notifyListeners();
  }

  getPopularMovies() async {

    _popularPage++;

    final jsonResponse = await _getJsonResponse('3/movie/popular', _popularPage);
    final popularResponse = PopularResponseModel.fromJson(jsonResponse);

    popularMovies = [...popularMovies, ...popularResponse.results];

    notifyListeners();
  }

  Future<String>_getJsonResponse(String endpoint, [int page = 1]) async {

    var url = Uri.https(_baseUrl, '$endpoint', {
      'api_key': _apiKey,
      'language': _language,
      'page': '$page'
    });

    final response = await http.get(url);
    return response.body;

  }

}