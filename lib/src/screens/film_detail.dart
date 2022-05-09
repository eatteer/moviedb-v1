import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:themoviedbapi/src/models/cast.dart';
import 'package:themoviedbapi/src/models/films.dart';
import 'package:themoviedbapi/src/models/genres.dart';
import 'package:themoviedbapi/src/providers/cast.dart';
import 'package:themoviedbapi/src/providers/genres.dart';

class FilmDetail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Film film = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      body: CustomScrollView(
        physics: BouncingScrollPhysics(),
        slivers: <Widget>[
          _sliverAppBar(context, film),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                SizedBox(height: 20.0),
                _poster(film),
                SizedBox(height: 20.0),
                _info(context, film),
                SizedBox(height: 20.0),
                _genres(context, film),
                SizedBox(height: 20.0),
                _overview(context, film),
                SizedBox(height: 20.0),
                _cast(context, film),
                SizedBox(height: 20.0),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _sliverAppBar(BuildContext context, Film film) {
    return SliverAppBar(
      iconTheme: IconThemeData(color: Colors.black),
      backgroundColor: Colors.transparent,
      pinned: false,
    );
  }

  Widget _poster(Film film) {
    return Center(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15.0),
        child: FadeInImage(
          image: NetworkImage(film.getPosterPath()),
          fit: BoxFit.cover,
          width: 200.0,
          height: 300.0,
          placeholder: AssetImage('assets/placeholder.png'),
        ),
      ),
    );
  }

  Widget _info(BuildContext context, Film film) {
    if (film.releaseDate == "") {
      film.releaseDate = 'Date not available';
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.0),
          child: Text(
            film.title,
            style: Theme.of(context).textTheme.title,
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(height: 10.0),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.0),
          child: Text(
            film.releaseDate,
            style: Theme.of(context).textTheme.subhead,
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(height: 10.0),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.0),
          child: Text(
            film.voteAverage.toString() + '/10',
            style: Theme.of(context).textTheme.subhead,
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }

  Widget _genres(BuildContext context, Film film) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Genres',
            style: Theme.of(context).textTheme.title,
          ),
          SizedBox(height: 10.0),
          _listViewGenres(film),
        ],
      ),
    );
  }

  Widget _listViewGenres(Film film) {
    final genreProvider = GenreProvider();
    return FutureBuilder(
      future: genreProvider.getGenres(),
      builder: (BuildContext context, AsyncSnapshot<List<Genre>> snapshot) {
        if (snapshot.hasData) {
          if (film.genreIds.isEmpty) {
            return Container(
              child: Text('Genres not available'),
            );
          } else {
            List<String> genres = List();
            for (var i = 0; i <= film.genreIds.length - 1; i++) {
              for (var j = 0; j < snapshot.data.length - 1; j++) {
                if (film.genreIds[i] == snapshot.data[j].id) {
                  genres.add(snapshot.data[j].name);
                }
              }
            }
            return ListView.builder(
              padding: EdgeInsets.all(0.0),
              primary: false,
              shrinkWrap: true,
              itemCount: genres.length,
              itemBuilder: (BuildContext context, int index) {
                return Text(genres[index]);
              },
            );
          }
        } else {
          return Container();
        }
      },
    );
  }

  Widget _overview(BuildContext context, Film film) {
    if (film.overview == '') {
      film.overview = 'Overview not available';
    }
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Overview',
            style: Theme.of(context).textTheme.title,
          ),
          SizedBox(height: 10.0),
          Text(film.overview)
        ],
      ),
    );
  }

  Widget _cast(BuildContext context, Film film) {
    final castProvider = CastProvider();
    return FutureBuilder(
      future: castProvider.getCast(film.id.toString()),
      builder: (BuildContext context, AsyncSnapshot<List<Actor>> snapshot) {
        if (snapshot.hasData) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                padding: EdgeInsets.symmetric(horizontal: 15.0),
                child: Text(
                  'Cast',
                  style: Theme.of(context).textTheme.title,
                ),
              ),
              SizedBox(height: 10.0),
              Container(
                child: _listViewCast(context, snapshot.data),
              ),
            ],
          );
        } else {
          return Container();
        }
      },
    );
  }

  Widget _listViewCast(BuildContext context, List<Actor> cast) {
    return Container(
      height: 194,
      width: double.infinity,
      child: ListView.builder(
        padding: EdgeInsets.symmetric(horizontal: 10.0),
        scrollDirection: Axis.horizontal,
        physics: BouncingScrollPhysics(),
        itemCount: cast.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            child: _actor(cast[index]),
            onTap: () {
              Navigator.pushNamed(context, 'person_detail',
                  arguments: cast[index].id);
            },
          );
        },
      ),
    );
  }

  Widget _actor(Actor actor) {
    return Container(
      width: 100,
      height: 150,
      margin: EdgeInsets.symmetric(horizontal: 5.0),
      child: Column(
        children: <Widget>[
          Container(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: Container(
                width: 100,
                height: 150,
                child: FadeInImage(
                  image: NetworkImage(actor.getProfilePath()),
                  fit: BoxFit.cover,
                  placeholder: AssetImage('assets/placeholder.png'),
                ),
              ),
            ),
          ),
          SizedBox(height: 10.0),
          Container(
            alignment: Alignment.centerLeft,
            child: Text(
              actor.name,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
            ),
          ),
        ],
      ),
    );
  }
}
