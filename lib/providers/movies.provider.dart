import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

import 'package:movies/models/models.dart';
import 'package:movies/models/search_movies_response.model.dart';

class MoviesProvider extends ChangeNotifier {

  String _baseUrl = 'api.themoviedb.org';
  String _apiKey = '2891e2c2ab994cbd1bec6f4582e77b9e';
  String _language = 'es-ES';

  List<MovieModel> onDisplayMovies = [];
  List<MovieModel> popularMovies = [];

  Map<int, List<CastModel>> moviesCast = {};

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

  Future<List<CastModel>> getCast(int movieId) async {

    if (moviesCast.containsKey(movieId)) {
      return moviesCast[movieId]!;
    }

    final jsonResponse = await _getJsonResponse('3/movie/$movieId/credits');
    final castResponse = CastResponseModel.fromJson(jsonResponse);

    moviesCast[movieId] = castResponse.cast;

    return castResponse.cast;
  }

  Future<String>_getJsonResponse(String endpoint, [int page = 1]) async {

    final url = Uri.https(_baseUrl, '$endpoint', {
      'api_key': _apiKey,
      'language': _language,
      'page': '$page'
    });

    final response = await http.get(url);
    return response.body;
  }

  Future<List<MovieModel>> getSearchMovies(String query) async {

    final url = Uri.https(_baseUrl, '3/search/movie', {
      'api_key': _apiKey,
      'language': _language,
      'query': query
    });

    final response = await http.get(url);
    final searchResponse = SearchMoviesResponseModel.fromJson(response.body);
    return searchResponse.results;
  }

}