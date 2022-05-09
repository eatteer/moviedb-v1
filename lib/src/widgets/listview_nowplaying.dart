import 'package:flutter/material.dart';
import 'package:themoviedbapi/src/models/films.dart';
import 'package:carousel_slider/carousel_slider.dart';

class NowPLayingFilms extends StatelessWidget {
  final List<Film> films;
  NowPLayingFilms({@required this.films});
  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
      scrollDirection: Axis.horizontal,
      viewportFraction: 0.4,
      enlargeCenterPage: true,
      enableInfiniteScroll: true,
      pauseAutoPlayOnTouch: Duration(milliseconds: 1500),
      autoPlay: true,
      autoPlayAnimationDuration: Duration(milliseconds: 1500),
      autoPlayCurve: Curves.fastOutSlowIn,
      itemCount: films.length,
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15.0),
            child: FadeInImage(
              image: NetworkImage(films[index].getPosterPath()),
              placeholder: AssetImage('assets/placeholder.png'),
              fit: BoxFit.cover,
            ),
          ),
          onTap: () {
            Navigator.pushNamed(context, 'film_detail',
                arguments: films[index]);
          },
        );
      },
    );
  }
}
