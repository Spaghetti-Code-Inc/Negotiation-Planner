///File download from FlutterViz- Drag and drop a tools. For more details visit https://flutterviz.io/

import 'package:flutter/material.dart';
import 'package:negotiation_tracker/EvaluateAggreement.dart';
import 'package:negotiation_tracker/TrackProgress.dart';
import 'package:negotiation_tracker/login.dart';

import 'StartNewNegotia.dart';

class Start extends StatelessWidget {
  const Start({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff1f1f1),
      appBar: AppBar(
        elevation: 4,
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xFF3B66B7),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.zero,
        ),
        title: const Text(
          "Negotiation Planner",
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontStyle: FontStyle.normal,
            fontSize: 18,
            color: Color(0xffffffff),
          ),
        ),
      ),
      body: Align(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [

            Expanded(
              flex: 2,
              child: GestureDetector(
                onTap: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => StartNewNegotia()),
                  );
                },
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                padding: const EdgeInsets.all(0),
                width: MediaQuery.of(context).size.width * 0.8,
                decoration: BoxDecoration(
                  color: const Color(0xffd1d1d1),
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(15.0),
                  border: Border.all(color: const Color(0x4d9e9e9e), width: 1),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: const [
                    Icon(Icons.add_to_photos,
                      color: Color(0xff212435),
                      size: 24,
                    ),
                    Expanded(
                      flex: 1,
                        child: Text(
                          "Prepare Negotiation",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            fontStyle: FontStyle.normal,
                          ),
                        ),
                      ),

                  ],
                ),
              ),
            ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                padding: const EdgeInsets.all(0),
                width: MediaQuery.of(context).size.width * 0.8,
                height: 100,
                decoration: BoxDecoration(
                  color: const Color(0xffd1d1d1),
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(15.0),
                  border: Border.all(color: const Color(0x4d9e9e9e), width: 1),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.book),
                      onPressed: () {},
                      color: const Color(0xff212435),
                      iconSize: 24,
                    ),
                    Expanded(
                      flex: 1,
                      child: MaterialButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const TrackProgress()),
                          );
                        },
                        color: const Color(0xffd1d1d1),
                        elevation: 0,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(15.0),
                              bottomRight: Radius.circular(15.0)),
                        ),
                        padding: const EdgeInsets.all(16),
                        textColor: const Color(0xff000000),
                        height: MediaQuery.of(context).size.height,
                        minWidth: 140,
                        child: const Text(
                          "Track Progress",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            fontStyle: FontStyle.normal,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                padding: const EdgeInsets.all(0),
                width: MediaQuery.of(context).size.width * 0.8,
                height: 100,
                decoration: BoxDecoration(
                  color: const Color(0xffd1d1d1),
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(15.0),
                  border: Border.all(color: const Color(0x4d9e9e9e), width: 1),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.verified),
                      onPressed: () {},
                      color: const Color(0xff212435),
                      iconSize: 24,
                    ),
                    Expanded(
                      flex: 1,
                      child: MaterialButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const EvaluateAggreement()),
                          );
                        },
                        color: const Color(0xffd1d1d1),
                        elevation: 0,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(15.0),
                              bottomRight: Radius.circular(15.0)),
                        ),
                        padding: const EdgeInsets.all(16),
                        textColor: const Color(0xff000000),
                        height: MediaQuery.of(context).size.height,
                        minWidth: 100,
                        child: const Text(
                          "Evaluate Agreement",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            fontStyle: FontStyle.normal,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.all(0),
              padding: const EdgeInsets.all(0),
              width: MediaQuery.of(context).size.width * 0.8,
              decoration: BoxDecoration(
                color: const Color(0x1f000000),
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(15.0),
                border: Border.all(color: const Color(0x4d9e9e9e), width: 1),
              ),
              child: Align(
                alignment: Alignment.center,
                child: MaterialButton(
                  onPressed: () {

                  },
                  color: const Color(0xffd1d1d1),
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                    side: const BorderSide(color: Color(0xff808080), width: 1),
                  ),
                  padding: const EdgeInsets.all(16),
                  textColor: const Color(0xff000000),
                  height: 40,
                  minWidth: MediaQuery.of(context).size.width,
                  child: const Text(
                    "Get Started",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      fontStyle: FontStyle.normal,
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                margin: const EdgeInsets.all(0),
                padding: const EdgeInsets.all(0),
                width: MediaQuery.of(context).size.width * 0.8,
                height: 100,
                decoration: const BoxDecoration(
                  color: Color(0x00ffffff),
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.zero,
                ),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: MaterialButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const Login()),
                      );
                    },
                    color: const Color(0xfff1f1f1),
                    elevation: 0,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.zero,
                      side: BorderSide(color: Color(0xffd1d1d1), width: 1),
                    ),
                    padding: const EdgeInsets.all(16),
                    textColor: const Color(0xff000000),
                    height: 40,
                    minWidth: 140,
                    child: const Text(
                      "Already have an Account? Login. ",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        fontStyle: FontStyle.normal,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
