import 'package:flutter/material.dart';
import 'package:themoviedbapi/src/models/films.dart';

final double _heightListView = 194.0;
final double _heightFilm = 150.0;
final double _widthFilm = 100.0;

class FilmsView extends StatelessWidget {
  final List<Film> films;
  final Function loadPage;
  FilmsView({
    @required this.films,
    @required this.loadPage,
  });
  @override
  Widget build(BuildContext context) {
    final ScrollController _scrollController = ScrollController();
    _scrollController.addListener(
      () {
        if (_scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent) {
          loadPage();
        }
      },
    );
    return Container(
      height: _heightListView,
      child: ListView.builder(
        padding: EdgeInsets.symmetric(horizontal: 10.0),
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        controller: _scrollController,
        itemCount: films.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            child: Container(
              height: _heightFilm,
              width: _widthFilm,
              margin: EdgeInsets.symmetric(horizontal: 5.0),
              child: Column(
                children: <Widget>[
                  _poster(context, films[index]),
                  SizedBox(height: 10.0),
                  _title(films[index])
                ],
              ),
            ),
            onTap: () {
              Navigator.pushNamed(context, 'film_detail',
                  arguments: films[index]);
            },
          );
        },
      ),
    );
  }

  Widget _poster(BuildContext context, Film film) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10.0),
      child: FadeInImage(
        image: NetworkImage(film.getPosterPath()),
        fit: BoxFit.cover,
        placeholder: AssetImage('assets/placeholder.png'),
      ),
    );
  }

  Widget _title(Film film) {
    return Container(
      alignment: Alignment.centerLeft,
      child: Text(
        film.title,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
