import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:themoviedbapi/src/screens/film_detail.dart';
import 'package:themoviedbapi/src/screens/home.dart';
import 'package:themoviedbapi/src/screens/person_detail.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    precacheImage(AssetImage('assets/placeholder.png'), context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Film Project',
      initialRoute: '/',
      routes: {
        '/': (BuildContext context) => Home(),
        'film_detail': (BuildContext context) => FilmDetail(),
        'person_detail': (BuildContext context) => PersonDetail(),
      },
      theme: ThemeData(
        fontFamily: 'Rubik',
        textTheme: TextTheme(
          title: TextStyle(
            fontWeight: FontWeight.bold,
          ),
          body1: TextStyle(
            color: Colors.grey[600],
          ),
        ),
      ),
    );
  }
}
