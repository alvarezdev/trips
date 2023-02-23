import 'package:flutter/material.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:trips/User/bloc/bloc_user.dart';
import 'card_image_with_fab_icon.dart';

class CardImageList extends StatelessWidget {

  UserBloc? userBloc;

  @override
  Widget build(BuildContext context) {
    userBloc = BlocProvider.of<UserBloc>(context);

    return Container(
      height: 350.0,
      //margin: const EdgeInsets.only(bottom: 400.0),
      child: StreamBuilder(
        stream: userBloc!.placeListStream,
        builder: (BuildContext context, AsyncSnapshot snapshot){
          switch(snapshot.connectionState){
            case ConnectionState.none:
            case ConnectionState.waiting:
            return const CircularProgressIndicator();
            case ConnectionState.active:
            case ConnectionState.done:
              return listViewPlace(userBloc!.buildPlaces(snapshot.data.docs));
          }
        }
      )
    );
  }

  Widget listViewPlace (List<CardImageWithFabIcon> placeCards){
    return  ListView(
        padding: const EdgeInsets.all(25.0),
        scrollDirection: Axis.horizontal,
        children: placeCards
      );
  }

}