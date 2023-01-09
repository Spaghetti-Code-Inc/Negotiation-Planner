///File download from FlutterViz- Drag and drop a tools. For more details visit https://flutterviz.io/

import 'package:flutter/material.dart';
import 'package:negotiation_tracker/EvaluateAggreement.dart';
import 'package:negotiation_tracker/login.dart';

import 'StartNewNegotiation.dart';
import 'TrackProgress.dart';
import 'main.dart';

class Start extends StatelessWidget {
  const Start({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff1f1f1),
      appBar: const TitleBar(),
      body: Align(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              margin: const EdgeInsets.only(top: 30, bottom: 10),
              padding: const EdgeInsets.all(20),
              height: 150,
              width: MediaQuery.of(context).size.width * 0.8,

              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const StartNewNegotiation()),
                  );
                },
                icon: const Icon(
                  Icons.add_to_photos,
                  size: 24.0,
                ),
                label: const Center(
                    child: Text(
                  'Prepare Negotiation',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    fontStyle: FontStyle.normal,
                  ),
                )),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: const Color(0xFF4681f4),

                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              padding: const EdgeInsets.all(20),
              height: 150,
              width: MediaQuery.of(context).size.width * 0.8,

              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const TrackProgress()),
                  );
                },
                icon: const Icon(
                  Icons.book,
                  size: 24.0,
                ),
                label: const Center(
                    child: Text(
                      'Track Progress',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        fontStyle: FontStyle.normal,
                      ),
                    )),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: const Color(0xFF4681f4),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              padding: const EdgeInsets.all(20),
              height: 150,
              width: MediaQuery.of(context).size.width * 0.8,

              child: ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(
                  Icons.verified,
                  size: 24.0,
                ),
                label: const Center(
                    child: Text(
                      'Evaluate Agreement',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        fontStyle: FontStyle.normal,
                      ),
                    )),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: const Color(0xFF4681f4),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(0, 20, 0, 0),
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
                  onPressed: () {},
                  color: const Color(0xffd1d1d1),
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                    side: const BorderSide(color: Color(0xff808080), width: 1),
                  ),
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
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
