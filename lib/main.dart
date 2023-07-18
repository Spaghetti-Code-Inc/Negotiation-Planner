// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'MainPage.dart';
import 'NegotiationDetails.dart';
import 'Utils.dart';

final navigatorKey = GlobalKey<NavigatorState>();
Color navyBlue = Color(0xff0A0A5B);

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(
      MaterialApp(
        scaffoldMessengerKey: Utils.messengerKey,
        title: 'Negotiation Planner',
        home: MainPage(),
        navigatorKey: navigatorKey,
        theme: ThemeData(
          textSelectionTheme: TextSelectionThemeData(
            cursorColor: Color(0xFF6DC090),
            selectionColor: Color(0xFF6DC090),
            selectionHandleColor: Color(0xFF6DC090),
          ),
        ),
      )
  );
}

Negotiation currentNegotiation = Negotiation.fromNegotiation(title: '', issues: [], target: -1, resistance: -1);

// Header for all "Prepare A New Negotiation" pages
class PrepareBar extends StatelessWidget implements PreferredSizeWidget {
  const PrepareBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 4,
      centerTitle: true,
      automaticallyImplyLeading: false,
      backgroundColor: const Color(0xff0A0A5B),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.zero,
      ),

      title: const Text(
        "Prepare New Negotiation",
        style: TextStyle(
          fontWeight: FontWeight.w600,
          fontStyle: FontStyle.normal,
          fontSize: 18,
          color: Color(0xffffffff),
        ),
      ),
    );
  }//widget

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(60.0);
}

// Header for all "Negotiation Planner" pages
class TitleBar extends StatelessWidget implements PreferredSizeWidget{
  const TitleBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 4,
      centerTitle: true,
      automaticallyImplyLeading: false,
      backgroundColor: const Color(0xff0A0A5B),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.zero,
      ),
      title: const Text(
        "Negotiation Planner",
        style: TextStyle(
          fontWeight: FontWeight.w600,
          fontStyle: FontStyle.normal,
          fontSize: 18,
          color: Color(0xFFFFFFFF),
        ),
      ),
      actions: <Widget>[
        IconButton(
            onPressed: () {
              FirebaseAuth.instance.signOut();
            },
            icon: Icon(Icons.logout), color: Color(0xFFFFFFFF),
        )
      ],
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(60.0);

}
