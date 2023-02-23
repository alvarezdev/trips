import 'package:flutter/material.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:trips/User/bloc/bloc_user.dart';
import 'package:trips/User/model/user_model.dart';
import 'package:trips/User/ui/screens/profile_header.dart';
import '../widgets/profile_places_list.dart';
import '../widgets/profile_background.dart';

class ProfileTrips extends StatelessWidget {

  UserBloc? userBloc;

  @override
  Widget build(BuildContext context) {
    userBloc = BlocProvider.of<UserBloc>(context);

    return StreamBuilder(
        stream:userBloc!.streamFirebase,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          switch(snapshot.connectionState){
            case ConnectionState.none:
            case ConnectionState.waiting:
              return const CircularProgressIndicator();
            case ConnectionState.active:
            case ConnectionState.done:
              return showProfileData(snapshot);
          }
        }
    );

  }

  Widget showProfileData(AsyncSnapshot snapshot){
    if (!snapshot.hasData || snapshot.hasError){
      print("No logueado");
      return Stack(
        children: <Widget>[
          ProfileBackground(),
          ListView(
            children: const [
              //ProfileHeader(),
              //ProfilePlacesList()
              Text("Usuario no logueado")
            ],
          ),
        ],
      );
    }else{
      print("Logueado");
      UserModel user = UserModel(
        uid: snapshot.data.uid,
        name: snapshot.data.displayName,
        email: snapshot.data.email,
        photoURL: snapshot.data.photoURL,
      );
      return Stack(
        children: <Widget>[
          ProfileBackground(),
          ListView(
            children: [
              ProfileHeader(userModel: user),
              ProfilePlacesList(userModel: user)
            ],
          ),
        ],
      );
    }
  }
}