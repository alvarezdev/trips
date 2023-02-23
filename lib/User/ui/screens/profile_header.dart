import 'package:flutter/material.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:trips/User/bloc/bloc_user.dart';
import 'package:trips/User/model/user_model.dart';

import '../widgets/button_bar.dart';
import '../../../Place/ui/widgets/user_info.dart';

class ProfileHeader extends StatelessWidget {

  UserModel? userModel;

  ProfileHeader({required this.userModel});

  @override
  Widget build(BuildContext context) {
    const title = Text(
      'Profile',
      style: TextStyle(
          fontFamily: 'Lato',
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 30.0
      ),
    );

    return Container(
      margin: const EdgeInsets.only(
          left: 20.0,
          right: 20.0,
          top: 50.0
      ),
      child: Column(
        children: <Widget>[
          Row(
            children: const <Widget>[
              title
            ],
          ),
          UserInfo(userModel: userModel!),
          ButtonsBar()
        ],
      ),
    );
  }

  /*Widget? showProfileData(AsyncSnapshot snapshot){
    if (!snapshot.hasData || snapshot.hasError){
      debugPrint("No logueado");
      return Container(
        margin: const EdgeInsets.only(
            left: 20.0,
            right: 20.0,
            top: 50.0
        ),
        child: Column(
          children: [
            Row(
              children: const [
                CircularProgressIndicator(),
                Text("No se pudo cargar la informacion. Haz loguin")
              ],
            ),
          ],
        ),
      );
    }else{
      debugPrint("Logueado");
      debugPrint(snapshot.data.toString());
      userModel = UserModel(uid: "", name: snapshot.data.displayName, email: snapshot.data.email, photoURL: snapshot.data.photoURL);
      const title = Text(
        'Profile',
        style: TextStyle(
            fontFamily: 'Lato',
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 30.0
        ),
      );

      return Container(
        margin: const EdgeInsets.only(
            left: 20.0,
            right: 20.0,
            top: 50.0
        ),
        child: Column(
          children: <Widget>[
            Row(
              children: const <Widget>[
                title
              ],
            ),
            UserInfo(userModel: userModel!),
            ButtonsBar()
          ],
        ),
      );
    }
  }*/

}