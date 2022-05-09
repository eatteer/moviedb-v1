import 'package:flutter/material.dart';
import 'package:themoviedbapi/src/models/films.dart';
import 'package:themoviedbapi/src/providers/films.dart';
import 'package:themoviedbapi/src/search/search_delegate.dart';
import 'package:themoviedbapi/src/widgets/listview_films.dart';
import 'package:themoviedbapi/src/widgets/listview_nowplaying.dart';

class Home extends StatelessWidget {
  final filmsProvider = FilmsProvider();
  @override
  Widget build(BuildContext context) {
    filmsProvider.getPopulars();
    filmsProvider.getTopRated();
    return Scaffold(
      body: CustomScrollView(
        physics: BouncingScrollPhysics(),
        slivers: <Widget>[
          _sliverAppBar(context),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Column(
                  children: <Widget>[
                    SizedBox(height: 20.0),
                    _nowPlayingFilms(),
                    SizedBox(height: 20.0),
                    _popularFilms(context),
                    SizedBox(height: 20.0),
                    _topRatedFilms(context),
                    SizedBox(height: 20.0),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _sliverAppBar(BuildContext context) {
    return SliverAppBar(
      iconTheme: IconThemeData(color: Colors.black),
      backgroundColor: Colors.transparent,
      pinned: false,
      title: RichText(
        text: TextSpan(
          style: Theme.of(context).textTheme.title,
          children: [
            TextSpan(
              text: 'The Movie Data Base ',
              style: TextStyle(
                color: Colors.green,
              ),
            ),
            TextSpan(
              text: 'API',
              style: TextStyle(
                color: Colors.black,
              ),
            )
          ],
        ),
      ),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.search),
          onPressed: () {
            showSearch(
              delegate: SearchFilm(),
              context: context,
            );
          },
        )
      ],
    );
  }

  Widget _nowPlayingFilms() {
    return FutureBuilder(
      future: filmsProvider.getNowPlaying(),
      builder: (BuildContext context, AsyncSnapshot<List<Film>> snapshot) {
        if (snapshot.hasData) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                padding: EdgeInsets.symmetric(horizontal: 15.0),
                child: Text(
                  'Now playing',
                  style: Theme.of(context).textTheme.title,
                ),
              ),
              SizedBox(height: 20.0),
              NowPLayingFilms(
                films: snapshot.data,
              ),
            ],
          );
        } else {
          return Container();
        }
      },
    );
  }

  Widget _popularFilms(BuildContext context) {
    return StreamBuilder(
      stream: filmsProvider.popularsStream,
      builder: (BuildContext context, AsyncSnapshot<List<Film>> snapshot) {
        if (snapshot.hasData) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                padding: EdgeInsets.symmetric(horizontal: 15.0),
                child: Text(
                  'Populars',
                  style: Theme.of(context).textTheme.title,
                ),
              ),
              SizedBox(height: 20.0),
              FilmsView(
                films: snapshot.data,
                loadPage: filmsProvider.getPopulars,
              ),
            ],
          );
        } else {
          return Container();
        }
      },
    );
  }

  Widget _topRatedFilms(BuildContext context) {
    return StreamBuilder(
      stream: filmsProvider.topRatedStream,
      builder: (BuildContext context, AsyncSnapshot<List<Film>> snapshot) {
        if (snapshot.hasData) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                padding: EdgeInsets.symmetric(horizontal: 15.0),
                child: Text(
                  'Top rated',
                  style: Theme.of(context).textTheme.title,
                ),
              ),
              SizedBox(height: 20.0),
              FilmsView(
                films: snapshot.data,
                loadPage: filmsProvider.getTopRated,
              ),
            ],
          );
        } else {
          return Container();
        }
      },
    );
  }
}
