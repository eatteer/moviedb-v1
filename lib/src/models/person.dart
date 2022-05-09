class Person {
  String birthday;
  //String knownForDepartment;
  //dynamic deathday;
  int id;
  String name;
  //List<String> alsoKnownAs;
  //int gender;
  String biography;
  //double popularity;
  String placeOfBirth;
  String profilePath;
  //bool adult;
  //String imdbId;
  //dynamic homepage;

  Person({
    this.birthday,
    //this.knownForDepartment,
    //this.deathday,
    this.id,
    this.name,
    //this.alsoKnownAs,
    //this.gender,
    this.biography,
    //this.popularity,
    this.placeOfBirth,
    this.profilePath,
    //this.adult,
    //this.imdbId,
    //this.homepage,
  });

  Person.jsonToPerson(Map<String, dynamic> json) {
    birthday = json['birthday'];
    //knownForDepartment = json['known_for_department'];
    //deathday = json['deathday'];
    id = json['id'];
    name = json['name'];
    //alsoKnownAs = json['also_known_as'];
    //gender = json['gender'];
    biography = json['biography'];
    //popularity = json['popularity'];
    placeOfBirth = json['place_of_birth'];
    profilePath = json['profile_path'];
    //adult = json['adult'];
    //imdbId = json['imdb_id'];
    //homepage = json['homepage'];
  }

  getProfilePath() {
    if (profilePath == null) {
      return 'http://oxilife.com.pe/wp-content/uploads/2014/07/placehold.it-500x750-500x750.gif';
    } else {
      return 'https://image.tmdb.org/t/p/w500/$profilePath';
    }
  }
}
