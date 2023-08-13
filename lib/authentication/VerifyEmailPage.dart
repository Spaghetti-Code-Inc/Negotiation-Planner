import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../Start.dart';
import '../Utils.dart';

class VerifyEmailPage extends StatefulWidget {
  const VerifyEmailPage({Key? key}) : super(key: key);

  @override
  State<VerifyEmailPage> createState() => _VerifyEmailPageState();
}

class _VerifyEmailPageState extends State<VerifyEmailPage> {
  bool isEmailVerified = false;
  bool canResendEmail = false;
  Timer? timer;

  void initState() {
    print("Made it to verify/start page");
    super.initState();

    isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;

    // If the email is not verified, check for it every 3 seconds
    if (!isEmailVerified) {
      sendVerificationEmail();

      timer = Timer.periodic(
        const Duration(seconds: 3),
        (_) => checkEmailVerified(),
      );
    }
  }

  Future checkEmailVerified() async {
    // Get a new value on the current user
    await FirebaseAuth.instance.currentUser!.reload();

    // Check if the user verified their email
    setState(() {
      isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    });

    // Stop checking if email is verified if it was verified
    if (isEmailVerified) {
      timer?.cancel();
    }
  }

  @override
  void dispose() {
    timer?.cancel();

    super.dispose();
  }

  Future sendVerificationEmail() async {
    try {
      final user = FirebaseAuth.instance.currentUser!;
      await user.sendEmailVerification();

      setState(() => canResendEmail = false);
      await Future.delayed(const Duration(seconds: 5));
      setState(() => canResendEmail = true);
    } catch (e) {
      Utils.showSnackBar(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) => isEmailVerified
      ? const Start()
      : Scaffold(
          appBar: AppBar(
            title: const Text('Verify Email to continue'),
            backgroundColor: Color(0xff0A0A5B),
            foregroundColor: Colors.white,
          ),
          body: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "A verification email has been sent to the email.",
                      style: TextStyle(fontSize: 20),
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size.fromHeight(50),
                        backgroundColor: Color(0xff0A0A5B),
                      ),
                      icon: const Icon(Icons.email, size: 32, color: Colors.white,),
                      label: const Text(
                        'Resend Email',
                        style: TextStyle(fontSize: 24, color: Colors.white),
                      ),
                      onPressed: (){
                        if(canResendEmail) sendVerificationEmail();
                      }

                    ),
                    TextButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size.fromHeight(50),
                      ),
                      child: const Text(
                        'Cancel',
                        style: TextStyle(fontSize: 24, color: Color(0xff0A0A5B)),
                      ),
                      onPressed: () => FirebaseAuth.instance.signOut(),
                    )
                  ]
              )
          )
  );
}
