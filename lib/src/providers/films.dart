import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:themoviedbapi/src/models/films.dart';

class FilmsProvider {
  String _apikey = '27bfcbd1174e4ca3999637f6e1233e98';
  String _url = 'api.themoviedb.org';
  String _language = 'en-EN';

  void disposeStream() {
    _popularsStreamController?.close();
    _topRatedStreamController?.close();
  }

  Future<List<Film>> _procesRequest(Uri url) async {
    final request = await http.get(url);
    final decodedData = json.decode(request.body);
    final films = new Films.createListFilms(decodedData['results']);
    return films.listFilms;
  }

  Future<List<Film>> search(String query) async {
    final url = Uri.https(_url, '3/search/movie', {
      'api_key': _apikey,
      'query': query,
      'language': _language,
    });
    return await _procesRequest(url);
  }

  Future<List<Film>> getNowPlaying() async {
    final url = Uri.https(_url, '3/movie/now_playing', {
      'api_key': _apikey,
      'language': _language,
    });
    return await _procesRequest(url);
  }

  //
  bool _loadingPopulars = false;
  int _popularsPage = 0;
  List<Film> _populars = List();

  final _popularsStreamController = StreamController<List<Film>>.broadcast();
  Function(List<Film>) get popularsSink => _popularsStreamController.sink.add;
  Stream<List<Film>> get popularsStream => _popularsStreamController.stream;

  Future<List<Film>> getPopulars() async {
    if (_loadingPopulars) return [];
    _loadingPopulars = true;
    _popularsPage++;
    final url = Uri.https(_url, '3/movie/popular', {
      'api_key': _apikey,
      'language': _language,
      'page': _popularsPage.toString()
    });
    final response = await _procesRequest(url);
    _populars.addAll(response);
    popularsSink(_populars);
    _loadingPopulars = false;
    return response;
  }

  //
  bool _loadingTopRated = false;
  int _topRatedPage = 0;
  List<Film> _topRated = List();

  final _topRatedStreamController = StreamController<List<Film>>.broadcast();
  Function(List<Film>) get topRatedSink => _topRatedStreamController.sink.add;
  Stream<List<Film>> get topRatedStream => _topRatedStreamController.stream;

  Future<List<Film>> getTopRated() async {
    if (_loadingTopRated) return [];
    _loadingTopRated = true;
    _topRatedPage++;
    final url = Uri.https(_url, '3/movie/top_rated', {
      'api_key': _apikey,
      'language': _language,
      'page': _topRatedPage.toString()
    });
    final response = await _procesRequest(url);
    _topRated.addAll(response);
    topRatedSink(_topRated);
    _loadingTopRated = false;

    return response;
  }
}
