///File download from FlutterViz- Drag and drop a tools. For more details visit https://flutterviz.io/

import 'package:flutter/material.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffdedede),
      body: Align(
        alignment: Alignment.center,
        child: Container(
          margin: EdgeInsets.zero,
          padding: EdgeInsets.zero,
          width: MediaQuery.of(context).size.width * 0.8,
          height: MediaQuery.of(context).size.height * 0.6,
          decoration: BoxDecoration(
            color: const Color(0xffffffff),
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: const Color(0x4d9e9e9e), width: 1),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              const Text(
                "LOGIN",
                textAlign: TextAlign.start,
                overflow: TextOverflow.clip,
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontStyle: FontStyle.normal,
                  fontSize: 14,
                  color: Color(0xff000000),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 50, 0, 0),
                child: MaterialButton(
                  onPressed: () {},
                  color: const Color(0xffffffff),
                  elevation: 0,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.zero,
                    side: BorderSide(color: Color(0xff808080), width: 1),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  textColor: const Color(0xff000000),
                  height: 40,
                  minWidth: 140,
                  child: const Text(
                    "Back",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      fontStyle: FontStyle.normal,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
