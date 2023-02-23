import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseAuthAPI {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  Future<User> signIn() async{
    GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();
    GoogleSignInAuthentication gSA = await googleSignInAccount!.authentication;

    AuthCredential credential = GoogleAuthProvider.credential(
        idToken: gSA.idToken,
        accessToken: gSA.accessToken
    );

    UserCredential userCredential = await _auth.signInWithCredential(credential);
    return userCredential.user!;
  }

  signOut() async {
    await _auth.signOut().then((value) => debugPrint("Sesión cerrada"));
    googleSignIn.signOut();
  }

}