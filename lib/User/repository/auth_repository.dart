import 'package:firebase_auth/firebase_auth.dart';
import 'package:trips/User/repository/firebase_auth_api.dart';

class AuthRepository {

  final _firebaseAuthApi = FirebaseAuthAPI();

  Future<User> signInFirebase() => _firebaseAuthApi.signIn();
  signInOutFirebase() => _firebaseAuthApi.signOut();

}