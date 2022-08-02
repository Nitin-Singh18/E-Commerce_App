import 'package:e_commerce/authentication/login_screen/login_screen_view.dart';
import 'package:e_commerce/home_screen/home_screen_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import "package:flutter/material.dart";

class Authentication extends StatelessWidget {
  Authentication({Key? key}) : super(key: key);

  final FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    //Here we are first checking if there is any user logged in or not
    //And if the user is already logged in then it'll return the user
    //to the home Screen otherwise it'll retrun the user to Login Screen

    if (auth.currentUser != null) {
      return HomeScreenView();
    } else {
      return LoginScreen();
    }
  }
}
