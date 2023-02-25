import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
      'userOwner' : _db.doc("$USERS/${user!.uid}"),
      'usersLiked' : place.usersLiked
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
      profilesPlaces.add(ProfilePlace(
          Place(
            //id: element.get('id'),
            name: element.get('name'),
            description: element.get('description'),
            urlImage: element.get('urlImage'),
            likes: element.get('likes')
          )
        )
      );
    });
    return profilesPlaces;
  }

  List<Place> buildPlaces(List<DocumentSnapshot> placesListSnapshot){
    List<Place> profilesPlaces = List.of(<Place>[]);
    User? user = _auth.currentUser;
    placesListSnapshot.forEach((element) {
      Place place = Place(
        id: element.id,
        name: element.get('name'),
        description: element.get('description'),
        urlImage: element.get('urlImage'),
        likes: element.get('likes')
      );
      var usersLikedRefs =  element.get("usersLiked");
      place.liked = false;
      if (usersLikedRefs != null){
        usersLikedRefs!.forEach((drUL){
          if(user!.uid == drUL.id){
            place.liked = true;
          }
        });
      }
      profilesPlaces.add(place);
    });
    return profilesPlaces;
  }

  Future likePlace(Place place) async{
    await _db.collection(PLACES).doc(place.id).get().then((documentSnapshot) {
      int likes = documentSnapshot.get('likes');
      String uid = _auth.currentUser!.uid;
      _db.collection(PLACES).doc(place.id).update({
        'likes' : place.liked ? likes + 1 : likes - 1,
        'usersLiked':
        place.liked?
        FieldValue.arrayUnion([_db.doc("$USERS/$uid")]):
        FieldValue.arrayRemove([_db.doc("$USERS/$uid")])
      });
    });
  }
}