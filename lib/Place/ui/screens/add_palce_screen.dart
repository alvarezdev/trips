
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:trips/Place/ui/widgets/card_image_with_fab_icon.dart';
import 'package:trips/Place/ui/widgets/title_input_location.dart';
import 'package:trips/User/bloc/bloc_user.dart';
import 'package:trips/widgets/button_purple.dart';
import 'package:trips/widgets/gradient_back.dart';
import 'package:trips/widgets/title_header.dart';

import '../../../widgets/text_input.dart';
import '../../model/place.dart';

class AddPlaceScreen extends StatefulWidget {

  XFile? file;

  AddPlaceScreen({this.file});

  @override
  State<StatefulWidget> createState() {
    return _AddPlaceScreen();
  }

}

class _AddPlaceScreen extends State<AddPlaceScreen> {

  UserBloc? userBloc;
  @override
  Widget build(BuildContext context) {

    userBloc = BlocProvider.of<UserBloc>(context);
    final _controllerTitlePlace = TextEditingController();
    final _controllerDescriptionPlace = TextEditingController();

    return Scaffold(
      body: Stack(
        children: [
          GradientBack(height: 300.0,),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.only(
                  top: 25.0,
                  left: 5.0
                ),
                child: SizedBox(
                  child: IconButton(
                    icon: const Icon(
                      Icons.keyboard_arrow_left,
                      color: Colors.white,
                      size: 45,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              ),
              Flexible(
                  child: Container(
                    padding: const EdgeInsets.only(
                      top: 45.0,
                      left: 20.0,
                      right: 10.0
                    ),
                    child:  const TitleHeader(title: "Add a new place",),
                    ),
                  )
            ],
          ),
          Container(
            padding: const EdgeInsets.only(top:120.0, bottom: 20.0),
            child: ListView(
              children: [
                Container(
                  margin: const EdgeInsets.only(bottom: 20.0 ),
                  alignment: Alignment.center,
                  child: CardImageWithFabIcon(
                    onPressedFabIcon: () => { },
                    image: widget.file,//Image.file(File(widget.file != null ? widget.file!.path : "")),
                    width: 350.0,
                    height: 250.0,
                    iconData: Icons.camera_alt,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 20.0 ),
                  child: TextInput(
                    hintText: "Title",
                    inputType: TextInputType.text,
                    editingController: _controllerTitlePlace,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 20.0 ),
                  child: TextInput(
                    hintText: "Descripción",
                    inputType: TextInputType.multiline,
                    editingController: _controllerDescriptionPlace,
                    maxLines: 4,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 20.0 ),
                  child: TitleInputLocation(
                    hintText: "Add Location",
                    iconData: Icons.location_on_outlined,
                  ),
                ),
                Container(
                  width: 10.0,
                  child: ButtonPurple(
                    buttonText: "Add Place",
                    onPreseed: () {

                      //ID user current login
                      User? user = userBloc!.currentUser;
                      if (user != null){
                        String uid = user.uid;
                        String path = "${uid}/${DateTime.now().toString()}.jpg";
                        //1.Firebase Storage
                        // url
                        userBloc!.uploadFile(path, File(widget.file!.path))
                            .then((uploadTask) {
                              uploadTask.ref.getDownloadURL().then((urlFile) {
                                  debugPrint("URLFILE: ${urlFile}");
                                  //2.Cloud Firestore
                                  //Place - title,description,url,userOwner,likes
                                  userBloc!.updatePlaceData(
                                      Place(
                                          name: _controllerTitlePlace.text,
                                          description: _controllerDescriptionPlace.text,
                                          urlImage: urlFile,
                                          likes: 0
                                      )
                                  ).whenComplete(() {
                                    debugPrint("Termino");
                                    Navigator.pop(context);
                                  });
                              });
                        });
                      }

                    },
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}