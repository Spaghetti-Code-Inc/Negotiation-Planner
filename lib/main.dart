import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'firebase_options.dart';
import 'package:flutter/material.dart';

import 'MainPage.dart';
import 'NegotiationDetails.dart';
import 'Utils.dart';

final navigatorKey = GlobalKey<NavigatorState>();
Color navyBlue = Color(0xff0A0A5B);

final double SIZE = 900;

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);


  if(!kIsWeb){
    runApp(
        MaterialApp(
          scaffoldMessengerKey: Utils.messengerKey,
          title: 'Negotiation Planner',
          home: MainPage(),
          navigatorKey: navigatorKey,
          theme: ThemeData(
            primaryColor: Color(0xff0A0A5B),
            primarySwatch: Colors.lightGreen,
            textSelectionTheme: TextSelectionThemeData(
              cursorColor: Color(0xFF6DC090),
              selectionColor: Color(0xFF6DC090),
              selectionHandleColor: Color(0xFF6DC090),
            ),
          ),
        )
    );
  } else {
    runApp(Center(
      child: ClipRect(
        child: SizedBox(
          width: SIZE,
          child: MaterialApp(
            scaffoldMessengerKey: Utils.messengerKey,
            title: 'Negotiation Planner',
            home: MainPage(),
            navigatorKey: navigatorKey,
            theme: ThemeData(
              primaryColor: Color(0xff0A0A5B),
              primarySwatch: Colors.lightGreen,
              textSelectionTheme: TextSelectionThemeData(
                cursorColor: Color(0xFF6DC090),
                selectionColor: Color(0xFF6DC090),
                selectionHandleColor: Color(0xFF6DC090),
              ),
            ),
          )
        )
      )
    ));
  }

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
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60.0);

}
