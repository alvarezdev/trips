import '../../Place/model/place.dart';

class UserModel {
  final String uid;
  final String name;
  final String email;
  final String photoURL;

  final List<Place>? myFavoritePlaces;
  final List<Place>? myPlaces;

  UserModel(
       {this.myFavoritePlaces,
        this.myPlaces,
        required this.uid,
        required this.name,
        required this.email,
        required this.photoURL}
      );
}