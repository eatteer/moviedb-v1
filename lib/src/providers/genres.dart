import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:themoviedbapi/src/models/genres.dart';

class GenreProvider {
  String _apikey = '27bfcbd1174e4ca3999637f6e1233e98';
  String _url = 'api.themoviedb.org';
  String _language = 'en-EN';

  Future<List<Genre>> getGenres() async {
    final url = Uri.https(_url, '3/genre/movie/list', {
      'api_key': _apikey,
      'language': _language,
    });
    return await _procesRequest(url);
  }

  Future<List<Genre>> _procesRequest(Uri url) async {
    final request = await http.get(url);
    final decodedData = json.decode(request.body);
    final genres = Genres.createGenre(decodedData['genres']);
    return genres.genresList;
  }
}
