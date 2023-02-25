import 'package:flutter/material.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import '../../../User/bloc/bloc_user.dart';
import '../../../widgets/button_purple.dart';
import '../../model/place.dart';

class DescriptionPlace extends StatelessWidget {

  UserBloc? userBloc;

  @override
  Widget build(BuildContext context) {
    userBloc = BlocProvider.of<UserBloc>(context);
    final star_half = Container (
      margin: const EdgeInsets.only(
          top: 353.0,
          right: 3.0
      ),

      child: const Icon(
        Icons.star_half,
        color:  Color(0xFFf2C611),
      ),
    );
    final star_border = Container (
      margin: const EdgeInsets.only(
          top: 353.0,
          right: 3.0
      ),

      child: const Icon(
        Icons.star_border,
        color:  Color(0xFFf2C611),
      ),
    );
    final star = Container (
      margin: const EdgeInsets.only(
        top: 353.0,
        right: 3.0
      ),

      child: const Icon(
        Icons.star,
        color:  Color(0xFFf2C611),
      ),
    );

    return StreamBuilder<Place>(
        stream: userBloc!.placeSelectedStream.cast(),
        builder: (BuildContext context, AsyncSnapshot<Place> snapshot){
          if (snapshot.hasData) {
            debugPrint("PLACE SELECTED: ${snapshot.data!.name}");
            Place place = snapshot.data!;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                title(place),
                likes(place),
                descriptionWidget(place.description),
                ButtonPurple(buttonText: "Navigate", onPreseed: () {  },)
              ],
            );
          }else{
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container (
                  margin: const EdgeInsets.only(
                      top: 400.0,
                      left: 20.0,
                      right: 20.0
                  ),

                  child: const Text(
                    "Selecciona un lugar",
                    style: TextStyle(
                        fontFamily: "Lato",
                        fontSize: 30.0,
                        fontWeight: FontWeight.w900
                    ),
                    textAlign: TextAlign.left,
                  ),
                )
              ],
            );
          }
        },
    );
  }

  Widget title(Place place){
    return Container (
      margin: const EdgeInsets.only(
          top: 350.0,
          left: 20.0,
          right: 20.0
      ),
      child: Text(
        place.name,
        style: const TextStyle(
            fontFamily: "Lato",
            fontSize: 30.0,
            fontWeight: FontWeight.w900
        ),
        textAlign: TextAlign.left,
      ),
    );
  }

  Widget likes(Place place){
    return Container (
      margin: const EdgeInsets.only(top: 20.0,left: 20.0),
      child: Text(
        "Hearts: ${place.likes}",
        style: const TextStyle(
            fontFamily: "Lato",
            fontSize: 18.0,
            fontWeight: FontWeight.w900,
            color: Colors.amber
        ),
      ),
    );
  }

  Widget descriptionWidget(String descriptionPlace){
    return Container(
      margin: const EdgeInsets.only(
          top: 20.0,
          left: 20.0,
          right: 20.0

      ),
      child: Text(
        descriptionPlace,
        style: const TextStyle(
            fontFamily: "Lato",
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            color: Color(0xFF56575a)
        ),

      ),
    );
  }
}