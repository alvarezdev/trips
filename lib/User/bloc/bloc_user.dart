import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:trips/User/repository/auth_repository.dart';
import 'package:trips/User/repository/cloud_firestore_api.dart';

import '../../Place/model/place.dart';
import '../../Place/repository/firebase_storage_repository.dart';
import '../model/user_model.dart';
import '../repository/cloud_firestore_repository.dart';
import '../ui/widgets/profile_place.dart';

class UserBloc implements Bloc{

  final _auth_repository = AuthRepository();

  //Flujo de datos - Streams
  //Stream  - Firebase
  //StreamController
  Stream<User?> streamFirebase = FirebaseAuth.instance.authStateChanges();
  Stream<User?> get authStatus => streamFirebase;
  User? get currentUser =>  FirebaseAuth.instance.currentUser;

  //Casos uso
  //1.SignIn a la aplicacion Google
  Future<User> signIn() => _auth_repository.signInFirebase();

  //2. Registrar usuario en base de datos

  final _cloudFirestoreRepository = CloudFirestoreRepository();
  updateUserData(UserModel userModel) => _cloudFirestoreRepository.updateUserDataFirestore(userModel);
  Future<void> updatePlaceData(Place place) => _cloudFirestoreRepository.updatePlaceData(place);
  Stream<QuerySnapshot> placeListStream = FirebaseFirestore.instance.collection(CloudFirestoreAPI().PLACES).snapshots();
  get placesStream => placeListStream;
  List<Place> buildPlaces(List<DocumentSnapshot> placesListSnapshot) => _cloudFirestoreRepository.buildPlaces(placesListSnapshot);
  Future likePlace(Place place) => _cloudFirestoreRepository.likePlace(place);

  List<ProfilePlace> buildMyPlaces(List<DocumentSnapshot> placesListSnapshot) => _cloudFirestoreRepository.buildMyPlaces(placesListSnapshot);
  Stream<QuerySnapshot> myPlaceListStream (String uid) =>
      FirebaseFirestore.instance.collection(CloudFirestoreAPI().PLACES)
          .where("userOwner", isEqualTo: FirebaseFirestore.instance.doc("${CloudFirestoreAPI().USERS}/$uid")).snapshots();

  StreamController placeSelectedStreamController =  StreamController();
  Stream get placeSelectedStream => placeSelectedStreamController.stream;
  StreamSink get placeSelectedSink =>  placeSelectedStreamController.sink;

  final _firebaseStorageRepository = FirebaseStorageRepository();
  UploadTask uploadFile(String path, File file) => _firebaseStorageRepository.uploadFile(path, file);

  signOut(){
    return _auth_repository.signInOutFirebase();
  }

  @override
  void dispose() {

  }
}