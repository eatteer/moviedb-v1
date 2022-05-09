import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:themoviedbapi/src/models/cast.dart';

class CastProvider {
  String _apikey = '27bfcbd1174e4ca3999637f6e1233e98';
  String _url = 'api.themoviedb.org';
  String _language = 'en-EN';

  Future<List<Actor>> getCast(String filmId) async {
    final url = Uri.https(_url, '3/movie/$filmId/credits', {
      'api_key': _apikey,
      'language': _language,
    });
    return await _procesRequest(url);
  }

  Future<List<Actor>> _procesRequest(Uri url) async {
    final request = await http.get(url);
    final decodedData = json.decode(request.body);
    final cast = Cast.createCast(decodedData['cast']);
    return cast.castList;
  }
}
