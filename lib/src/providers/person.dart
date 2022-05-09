import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:themoviedbapi/src/models/person.dart';

class PersonProvider {
  String _apiKey = '27bfcbd1174e4ca3999637f6e1233e98';
  String _url = 'api.themoviedb.org';
  String _languaje = 'en-EN';

  Future<Person> getPerson(String id) async {
    Uri url = Uri.https(_url, '3/person/$id', {
      'api_key': _apiKey,
      'language': _languaje,
    });
    Response response = await http.get(url);
    dynamic decoded = json.decode(response.body);
    return Person.jsonToPerson(decoded);
  }
}
