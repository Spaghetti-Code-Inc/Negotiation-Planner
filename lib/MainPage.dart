
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'authentication/AuthPage.dart';
import 'authentication/VerifyEmailPage.dart';

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
          return const Center(child: Text('An error has occurred, please check your wifi status!'));
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
