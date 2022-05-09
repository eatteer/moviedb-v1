import 'package:flutter/material.dart';

import 'package:themoviedbapi/src/models/films.dart';

import 'package:themoviedbapi/src/providers/films.dart';

FilmsProvider filmsProvider = FilmsProvider();
List<Film> recent = List();

class SearchFilm extends SearchDelegate {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    FilmsProvider filmsProvider = FilmsProvider();
    //ADD RECENTS
    if (query.isEmpty) {
      return Container(
        child: ListView.builder(
          physics: BouncingScrollPhysics(),
          padding: EdgeInsets.symmetric(vertical: 15.0),
          itemCount: recent.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              padding: EdgeInsets.symmetric(vertical: 5.0),
              child: ListTile(
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(5.0),
                  child: FadeInImage(
                    image: NetworkImage(
                      recent[index].getPosterPath(),
                    ),
                    placeholder: AssetImage('assets/placeholder.png'),
                    fit: BoxFit.cover,
                  ),
                ),
                title: Text(recent[index].title),
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    'film_detail',
                    arguments: recent[index],
                  );
                },
              ),
            );
          },
        ),
      );
    }
    //SHOW SUGGESTIONS
    return FutureBuilder(
      future: filmsProvider.search(query),
      builder: (BuildContext context, AsyncSnapshot<List<Film>> snapshot) {
        if (snapshot.hasData) {
          return Container(
            child: ListView.builder(
              physics: BouncingScrollPhysics(),
              padding: EdgeInsets.symmetric(vertical: 15.0),
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  padding: EdgeInsets.symmetric(vertical: 5.0),
                  child: ListTile(
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(5.0),
                      child: FadeInImage(
                        image: NetworkImage(
                          snapshot.data[index].getPosterPath(),
                        ),
                        placeholder: AssetImage('assets/placeholder.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                    title: Text(snapshot.data[index].title),
                    onTap: () {
                      if (recent.isEmpty) {
                        recent.add(snapshot.data[index]);
                      } else {
                        for (var i = 0; i <= recent.length - 1; i++) {
                          if (snapshot.data[index].id == recent[i].id) {
                            recent.removeAt(i);
                          }
                        }
                        recent.insert(0, snapshot.data[index]);
                      }
                      Navigator.pushNamed(
                        context,
                        'film_detail',
                        arguments: snapshot.data[index],
                      );
                    },
                  ),
                );
              },
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }
}
