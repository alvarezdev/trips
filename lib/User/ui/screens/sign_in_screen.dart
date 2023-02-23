import 'package:flutter/material.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:trips/User/bloc/bloc_user.dart';
import 'package:trips/platzi_trips_cupertino.dart';
import 'package:trips/widgets/button_green.dart';
import 'package:trips/widgets/gradient_back.dart';

import '../../model/user_model.dart';

class SignInScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SignInScreen();
  }
}

class _SignInScreen extends State<SignInScreen> {

  UserBloc? userBloc;
  double? screenWidth;

  @override
  Widget build(BuildContext context) {
    userBloc = BlocProvider.of(context);
    screenWidth = MediaQuery.of(context).size.width;
    return _handlerCurrentSession();
  }
  
  Widget _handlerCurrentSession(){
    return StreamBuilder(
      stream: userBloc!.authStatus,
      builder: (BuildContext context, AsyncSnapshot snapshot){
        if(!snapshot.hasData || snapshot.hasError){
          return signInGoogleUI();
        }else{
          return PlatziTripsCupertino();
        }
      }
    );
  }
  
  Widget signInGoogleUI(){
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          GradientBack(height: null),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                  child: Container(
                    width: screenWidth,
                    margin: const EdgeInsets.only(
                      left: 10.0
                    ),
                    child: const Text(
                      "Welcome \nThis is your Travel App",
                      style: TextStyle(
                          fontSize: 37.0,
                          fontFamily: "Lato",
                          color: Colors.white,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                 )
              ),
              ButtonGreen(
                text: "Login with Gmail" ,
                onPressed: () {
                  userBloc!.signOut();
                  userBloc!.signIn().then((user) {
                    userBloc!.updateUserData(
                        UserModel(
                          uid: user.uid,
                          name: user.displayName!,
                          email: user.email!,
                          photoURL: user.photoURL!
                    ));
                  });
                },
                width: 300.0,
                height: 50.0,
              )
            ],
          )
        ],
      ),
    );
  }
  
}