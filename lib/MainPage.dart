
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'AuthPage.dart';
import 'Login.dart';
import 'Start.dart';
import 'VerifyEmailPage.dart';

class MainPage extends StatelessWidget{
  MainPage({super.key});

  Widget build(BuildContext context) => Scaffold(
    body: StreamBuilder<User?>(
      // The page shown is dependent on the users authorization
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        // If something is slowed a loading screen will show
        if(snapshot.connectionState == ConnectionState.waiting){
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError){
          return const Center(child: Text('Something went wrong!'));
        // If the snapshot has a user signed in, make sure the page is verified, if it is then show main screen
        } else if(snapshot.hasData){
          return VerifyEmailPage();
        // If not signed in, show sign in
        } else {
          return AuthPage();
        }
      }
    )
  );

}
