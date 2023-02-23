import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:trips/User/bloc/bloc_user.dart';
import 'package:trips/User/model/user_model.dart';
import '../../../Place/model/place.dart';

class ProfilePlacesList extends StatelessWidget {

  UserBloc? userBloc;
  UserModel? userModel;
  ProfilePlacesList({required this.userModel});

  Place place = Place(
    name: "Knuckles Mountains Range",
    description: "Hiking. Water fall hunting. Natural bath",
    urlImage: 'assets/img/river.jpeg',
    likes: 3,
    );
  Place place2 = Place(
    name: "Mountains",
    description: "Hiking. Water fall hunting. Natural bath",
    urlImage: 'assets/img/mountain.jpeg',
    likes: 3,
  );

  @override
  Widget build(BuildContext context) {
    userBloc = BlocProvider.of<UserBloc>(context);
    return Container(
      margin: const EdgeInsets.only(
          top: 10.0,
          left: 20.0,
          right: 20.0,
          bottom: 10.0
      ),
      child: StreamBuilder<QuerySnapshot>(
        stream: userBloc!.myPlaceListStream(userModel!.uid),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          switch (snapshot.connectionState){
            case ConnectionState.none:
              return const CircularProgressIndicator();
            case ConnectionState.waiting:
              return const CircularProgressIndicator();
            case ConnectionState.active:
              return Column(
                children: userBloc!.buildPlaces(snapshot.data!.docs),
              );
            case ConnectionState.done:
              return Column(
                children: userBloc!.buildPlaces(snapshot.data!.docs),
              );
          }
        },
      ),
    );
  }
}