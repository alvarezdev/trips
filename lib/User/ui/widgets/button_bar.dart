import 'dart:io';
import 'package:flutter/material.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:trips/Place/ui/screens/add_palce_screen.dart';
import 'package:trips/User/bloc/bloc_user.dart';
import 'circle_button.dart';

class ButtonsBar extends StatelessWidget {
  
  UserBloc? userBloc;

  @override
  Widget build(BuildContext context) {
    userBloc = BlocProvider.of(context);
    return Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: 0.0,
            vertical: 10.0
        ),
        child: Row(
          children: <Widget>[
            CircleButton(true, "recover_pass", Icons.vpn_key, 20.0, const Color.fromRGBO(255, 255, 255, 0.6), () => {}),
            CircleButton(
                false,
                "add_place",
                Icons.add, 40.0,
                const Color.fromRGBO(255, 255, 255, 1),
                () => openCameraAndGotoAddPlace(context)
            ),
            CircleButton(true, "exit_app", Icons.exit_to_app, 20.0, const Color.fromRGBO(255, 255, 255, 0.6), () => userBloc!.signOut()),
          ],
        )
    );
  }

  openCameraAndGotoAddPlace(BuildContext context) async {
    await ImagePicker().pickImage(
        source: ImageSource.camera
      ).then((file) => gotoAddPlace(context, file)
    );
  }

  gotoAddPlace(BuildContext context, XFile? file){
    Navigator.push(context,
      MaterialPageRoute(
          builder: (BuildContext builder) => AddPlaceScreen(file: file)
      )
    );
  }
}