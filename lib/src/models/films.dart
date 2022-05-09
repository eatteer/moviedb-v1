class Films {
  List<Film> listFilms = new List();

  Films.createListFilms(List<dynamic> jsonListFilm) {
    if (jsonListFilm == null) return;
    jsonListFilm.forEach(
      (jsonFilm) {
        var film = Film.jsonToFilm(jsonFilm);
        listFilms.add(film);
      },
    );
  }
}

class Film {
  //double popularity;
  //int voteCount;
  //bool video;
  String posterPath;
  int id;
  //bool adult;
  //String backdropPath;
  //String originalLanguage;
  //String originalTitle;
  List<int> genreIds;
  String title;
  double voteAverage;
  String overview;
  String releaseDate;

  Film({
    //this.popularity,
    //this.voteCount,
    //this.video,
    this.posterPath,
    this.id,
    //this.adult,
    //this.backdropPath,
    //this.originalLanguage,
    //this.originalTitle,
    this.genreIds,
    this.title,
    this.voteAverage,
    this.overview,
    this.releaseDate,
  });

  Film.jsonToFilm(Map<String, dynamic> jsonFilm) {
    //popularity = jsonFilm['popularity'] / 1;
    //voteCount = jsonFilm['vote_count'];
    //video = jsonFilm['video'];
    posterPath = jsonFilm['poster_path'];
    id = jsonFilm['id'];
    //adult = jsonFilm['adult'];
    //backdropPath = jsonFilm['backdrop_path'];
    //originalLanguage = jsonFilm['original_language'];
    //originalTitle = jsonFilm['original_title'];
    genreIds = jsonFilm['genre_ids'].cast<int>();
    title = jsonFilm['title'];
    voteAverage = jsonFilm['vote_average'] / 1;
    overview = jsonFilm['overview'];
    releaseDate = jsonFilm['release_date'];
  }

  getPosterPath() {
    if (posterPath == null) {
      return 'http://oxilife.com.pe/wp-content/uploads/2014/07/placehold.it-500x750-500x750.gif';
    } else {
      return 'https://image.tmdb.org/t/p/w500/$posterPath';
    }
  }

  //getBackdropPath() {
  //  if (backdropPath == null) {
  //    return 'http://oxilife.com.pe/wp-content/uploads/2014/07/placehold.it-500x750-500x750.gif';
  //  } else {
  //    return 'https://image.tmdb.org/t/p/w500/$backdropPath';
  //  }
  //}
}
