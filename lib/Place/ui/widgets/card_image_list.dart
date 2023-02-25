import 'package:flutter/material.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:trips/User/bloc/bloc_user.dart';
import '../../model/place.dart';
import 'card_image_with_fab_icon.dart';

class CardImageList extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
  return _CardImageList();
  }
}

class _CardImageList extends State<CardImageList> {

  UserBloc? userBloc;

  @override
  Widget build(BuildContext context) {
    userBloc = BlocProvider.of<UserBloc>(context);

    return Container(
      height: 320.0,
      child: StreamBuilder(
        stream: userBloc!.placeListStream,
        builder: (BuildContext context, AsyncSnapshot snapshot){
          switch(snapshot.connectionState){
            case ConnectionState.none:
            case ConnectionState.waiting:
            return const Center(child: CircularProgressIndicator());
            case ConnectionState.active:
            case ConnectionState.done:
            return listViewPlaces(userBloc!.buildPlaces(snapshot.data.docs));
          }
        }
      )
    );
  }

  Widget listViewPlaces(List<Place> places){

    setLiked(Place place){
      setState(() {
        place.liked = !place.liked;
        userBloc!.likePlace(place);
        int likes = place.likes!;
        likes = place.liked ? likes + 1 : likes - 1;
        userBloc!.placeSelectedSink.add(place);
      });
    }

    return ListView(
        padding: const EdgeInsets.all(25.0),
        scrollDirection: Axis.horizontal,
        children: places.map((place){
          return GestureDetector(
            onTap: (){
              debugPrint("CLICK PLACE: ${place.name}");
              userBloc!.placeSelectedSink.add(place);
            },
            child: CardImageWithFabIcon(
              onPressedFabIcon: () => {
                setLiked(place)
              },
              image: XFile(place.urlImage != null ? place.urlImage! : ""),//Image.network(place.urlImage!),
              width: 300.0,
              height: 250.0,
              iconData: place.liked ? Icons.favorite: Icons.favorite_border,
              internet: true,
            )
          );}
        ).toList()
    );



  }



}