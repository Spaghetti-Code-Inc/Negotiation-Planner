
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
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if(snapshot.connectionState == ConnectionState.waiting){
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError){
          return const Center(child: Text('Something went wrong!'));
        } else if(snapshot.hasData){
          return VerifyEmailPage();
        } else {
          return AuthPage();
        }
      }
    )
  );

}
