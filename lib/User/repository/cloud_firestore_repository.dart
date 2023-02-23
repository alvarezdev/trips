
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:trips/User/model/user_model.dart';
import 'package:trips/User/repository/cloud_firestore_api.dart';

import '../../Place/model/place.dart';
import '../../Place/ui/widgets/card_image_with_fab_icon.dart';
import '../ui/widgets/profile_place.dart';

class CloudFirestoreRepository{
  final _cloudFirestoreAPI = CloudFirestoreAPI();
  updateUserDataFirestore(UserModel userModel) => _cloudFirestoreAPI.updateUserData(userModel);
  Future<void> updatePlaceData(Place place) => _cloudFirestoreAPI.updatePlaceData(place);
  List<ProfilePlace> buildMyPlaces(List<DocumentSnapshot> placesListSnapshot) => _cloudFirestoreAPI.buildMyPlaces(placesListSnapshot);
  List<CardImageWithFabIcon> buildPlaces(List<DocumentSnapshot> placesListSnapshot) => _cloudFirestoreAPI.buildPlaces(placesListSnapshot);

}