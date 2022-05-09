import 'package:flutter/material.dart';
import 'package:themoviedbapi/src/models/person.dart';
import 'package:themoviedbapi/src/providers/person.dart';

class PersonDetail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    int id = ModalRoute.of(context).settings.arguments;
    PersonProvider personProvider = PersonProvider();
    return FutureBuilder(
      future: personProvider.getPerson(id.toString()),
      builder: (BuildContext context, AsyncSnapshot<Person> snapshot) {
        if (snapshot.hasData) {
          Person person = snapshot.data;
          return Scaffold(
            body: CustomScrollView(
              physics: BouncingScrollPhysics(),
              slivers: <Widget>[
                _sliverAppBar(),
                SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      SizedBox(height: 20.0),
                      _poster(person),
                      SizedBox(height: 20.0),
                      _info(context, person),
                      SizedBox(height: 20.0),
                      _biography(context, person),
                      SizedBox(height: 20.0),
                    ],
                  ),
                )
              ],
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }

  Widget _sliverAppBar() {
    return SliverAppBar(
      iconTheme: IconThemeData(color: Colors.black),
      backgroundColor: Colors.transparent,
      pinned: false,
    );
  }

  Widget _poster(Person person) {
    return Center(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15.0),
        child: FadeInImage(
          image: NetworkImage(person.getProfilePath()),
          fit: BoxFit.cover,
          width: 200.0,
          height: 300.0,
          placeholder: AssetImage('assets/placeholder.png'),
        ),
      ),
    );
  }

  Widget _info(BuildContext context, Person person) {
    if (person.birthday == null || person.birthday == '') {
      person.birthday = 'Date not available';
    }
    if (person.placeOfBirth == null || person.placeOfBirth == '') {
      person.placeOfBirth = 'Place not available';
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.0),
          child: Text(
            person.name,
            style: Theme.of(context).textTheme.title,
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(height: 10.0),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.0),
          child: Text(
            person.birthday,
            style: Theme.of(context).textTheme.subhead,
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(height: 10.0),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.0),
          child: Text(
            person.placeOfBirth,
            style: Theme.of(context).textTheme.subhead,
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }

  Widget _biography(BuildContext context, Person person) {
    if (person.biography == null || person.biography == '') {
      person.biography = 'Biography not available';
    }
    return GestureDetector(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Biography',
              style: Theme.of(context).textTheme.title,
            ),
            SizedBox(height: 10.0),
            Text(
              person.biography,
              maxLines: 10,
              overflow: TextOverflow.ellipsis,
            )
          ],
        ),
      ),
      onTap: () {
        showDialog(
          barrierDismissible: true,
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              title: Row(
                children: <Widget>[
                  IconButton(
                    icon: Icon(Icons.arrow_back),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  SizedBox(width: 16.0),
                  Text('Biography'),
                ],
              ),
              titleTextStyle: Theme.of(context).textTheme.title,
              contentTextStyle: Theme.of(context).textTheme.body1,
              content: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Text(person.biography),
              ),
            );
          },
        );
      },
    );
  }
}
