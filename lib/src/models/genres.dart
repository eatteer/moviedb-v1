class Genres {
  List<Genre> genresList = List();
  Genres.createGenre(List<dynamic> jsonListGenres) {
    jsonListGenres.forEach(
      (jsonGenre) {
        final objGenre = Genre.jsonToGenre(jsonGenre);
        genresList.add(objGenre);
      },
    );
  }
}

class Genre {
  int id;
  String name;
  Genre({
    this.id,
    this.name,
  });
  Genre.jsonToGenre(Map<String, dynamic> jsonGenre) {
    id = jsonGenre['id'];
    name = jsonGenre['name'];
  }
}
