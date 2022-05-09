class Cast {
  List<Actor> castList = List();
  Cast.createCast(List<dynamic> jsonListCast) {
    jsonListCast.forEach(
      (jsonActor) {
        final objActor = Actor.jsonToActor(jsonActor);
        castList.add(objActor);
      },
    );
  }
}

class Actor {
  //int castId;
  //String character;
  //String creditId;
  //int gender;
  int id;
  String name;
  String profilePath;

  Actor({
    //this.castId,
    //this.character,
    //this.creditId,
    //this.gender,
    this.id,
    this.name,
    //this.order,
    this.profilePath,
  });

  Actor.jsonToActor(Map<String, dynamic> jsonActor) {
    //castId = jsonActor['cast_id'];
    //character = jsonActor['character'];
    //creditId = jsonActor['credit_id'];
    //gender = jsonActor['gender'];
    id = jsonActor['id'];
    name = jsonActor['name'];
    //order = jsonActor['order'];
    profilePath = jsonActor['profile_path'];
  }

  getProfilePath() {
    if (profilePath == null) {
      return 'https://www.eurosegway.es/images/no-avatar-300x300.png';
    } else {
      return 'https://image.tmdb.org/t/p/w500/$profilePath';
    }
  }
}
