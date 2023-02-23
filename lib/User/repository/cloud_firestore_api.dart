import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:trips/Place/ui/widgets/card_image_with_fab_icon.dart';
import 'package:trips/User/model/user_model.dart';

import '../../Place/model/place.dart';
import '../ui/widgets/profile_place.dart';
class CloudFirestoreAPI{

  final String USERS = "users";
  final String PLACES = "places";

  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  updateUserData(UserModel userModel) async{
    DocumentReference reference = _db.collection(USERS).doc(userModel.uid);
    return await reference.set({
      'uid' : userModel.uid,
      'name': userModel.name,
      'email' : userModel.email,
      'photoURL' : userModel.photoURL,
      'myPlaces' : userModel.myPlaces,
      'myFavoritePlaces' : userModel.myFavoritePlaces,
      'lastSignIn' : DateTime.now()
    });
  }

  Future<void> updatePlaceData(Place place) async{
    CollectionReference refPlace = _db.collection(PLACES);

    User? user = _auth.currentUser;

    await refPlace.add({
        'name' : place.name,
        'description' : place.description,
        'likes' : place.likes,
        'urlImage' : place.urlImage,
        'userOwner' : _db.doc("$USERS/${user!.uid}")
    }).then((docRef) {
      docRef.get().then((snapshot) {
        DocumentReference refUsers = _db.collection(USERS).doc(user.uid);
        refUsers.update({
          'myPlaces' : FieldValue.arrayUnion([_db.doc("$PLACES/${snapshot.id}")])
        });
      });
    });
  }

  List<ProfilePlace> buildMyPlaces(List<DocumentSnapshot> placesListSnapshot){
    List<ProfilePlace> profilesPlaces = List.of(<ProfilePlace>[]);
    placesListSnapshot.forEach((element) {
      profilesPlaces.add(ProfilePlace(Place(
        name: element.get('name'),
        description: element.get('description'),
        urlImage: element.get('urlImage'),
        likes: element.get('likes')
      )));
    });
    return profilesPlaces;
  }

  List<CardImageWithFabIcon> buildPlaces(List<DocumentSnapshot> placesListSnapshot){
    List<CardImageWithFabIcon> profilesPlaces = List.of(<CardImageWithFabIcon>[]);
    placesListSnapshot.forEach((element) {
      profilesPlaces.add(CardImageWithFabIcon(
          onPressedFabIcon: () => likePlace(element.id),
          image: Image.network(element.get("urlImage")),
          width: 300.0,
          height: 300.0,
          iconData: Icons.favorite_border)
      );
    });
    return profilesPlaces;
  }

  Future likePlace(String idPlace) async{
    await _db.collection(PLACES).doc(idPlace).get().then((documentSnapshot) {
      int likes = documentSnapshot.get("likes");

      _db.collection(PLACES).doc(idPlace).update({
          'likes' : likes+1
      });
    });
  }
}