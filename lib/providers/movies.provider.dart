import 'dart:async';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:movies/helpers/debouncer.dart';

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

  final debouncer = Debouncer(
    duration: Duration(milliseconds: 500)
  );

  final StreamController<List<MovieModel>> _suggestionStreamController = new StreamController.broadcast();
  Stream<List<MovieModel>> get suggestionsStream => this._suggestionStreamController.stream;

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

  void getSuggestionsByQuery(String query) {

    debouncer.value = '';
    debouncer.onValue = (value) async {
      final results = await this.getSearchMovies(query);
      this._suggestionStreamController.add(results);
    };

    final timer = Timer.periodic(Duration(milliseconds: 300), (_) {
      debouncer.value = query;
    });

    Future.delayed(Duration(milliseconds: 301)).then((_) => timer.cancel());
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

}