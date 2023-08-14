
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'view_and_track_negotiations/MyNegotiations.dart';
import 'package:negotiation_tracker/create_negotiation/StartNewNegotiation.dart';
import 'main.dart';

List<String> images = [
  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQTIZccfNPnqalhrWev-Xo7uBhkor57_rKbkw&usqp=CAU",
  "https://wallpaperaccess.com/full/2637581.jpg",
  "assets/images/TrackProgress.png"
];


class Start extends StatelessWidget {
  const Start({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff1f1f1),
      appBar: const TitleBar(),
      body: SingleChildScrollView(
        child: Align( alignment: Alignment.topCenter,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [

              (kIsWeb) ? WebDisplay() : MobileDisplay(),

              Container(
                margin: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                padding: const EdgeInsets.only(),
                width: (MediaQuery.of(context).size.width >= SIZE) ? SIZE*.85: MediaQuery.of(context).size.width * .85,
                decoration: BoxDecoration(
                  color: const Color(0x1f000000),
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(15.0),
                  border: Border.all(color: const Color(0xff0A0A5B), width: 1),
                ),
                child: Align(
                  alignment: Alignment.center,
                  child: MaterialButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => StartNewNegotiation())
                      );
                    },
                    color: const Color(0xffffffff),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
                    textColor: const Color(0xff0A0A5B),
                    height: 40,
                    minWidth: MediaQuery.of(context).size.width,
                    child: const Text(
                      "Start New Negotiation",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        fontStyle: FontStyle.normal,
                      ),
                    ),
                  ),
                ),
              ),

              Container(
                margin: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                padding: const EdgeInsets.all(0),
                width: (MediaQuery.of(context).size.width >= SIZE) ? SIZE*.85: MediaQuery.of(context).size.width * .85,
                decoration: BoxDecoration(
                  color: const Color(0x1f000000),
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(15.0),
                  border: Border.all(color: const Color(0xff0A0A5B), width: 1),
                ),
                child: Align(
                  alignment: Alignment.center,
                  child: MaterialButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MyNegotiations())
                      );
                    },
                    color: const Color(0xffffffff),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
                    textColor: const Color(0xff0A0A5B),
                    height: 40,
                    minWidth: MediaQuery.of(context).size.width,
                    child: const Text(
                      "View Current Negotiations",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        fontStyle: FontStyle.normal,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
    ),
      ));
  }
}

class WebDisplay extends StatelessWidget {
  const WebDisplay({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: EdgeInsets.all(30),
      child: Padding(
        padding: EdgeInsets.all(30),
          child: Column(
              children: [
                Text("1. Prepare negotiation \n2. Track progress \n3. Evaluate agreement", style: TextStyle(fontSize: 40)),
            ],
          ),
      ),
    );
  }
}


class MobileDisplay extends StatelessWidget {
  const MobileDisplay({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return             SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: EdgeInsets.all(12),
      child: Row(
        children: [
          /// Prepare Negotiation
          Container(
            margin: EdgeInsets.fromLTRB(45, 15, 20, 5),
            padding: EdgeInsets.fromLTRB(20, 15, 20, 20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              border: Border.all(color: const Color(0xff0A0A5B), width: 1),
            ),
            child: Column(
              children: [
                Container(
                  child: Text("Prepare Negotiations"),
                  padding: EdgeInsets.all(10),
                ),
                Image.asset('assets/images/prepareNegotiation.png', height: 390, width: 200),
              ],
            ),
          ),
          /// Track Progress
          Container(
            margin: EdgeInsets.fromLTRB(20, 15, 20, 5),
            padding: EdgeInsets.fromLTRB(20, 15, 20, 20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              border: Border.all(color: const Color(0xff0A0A5B), width: 1),
            ),
            child: Column(
              children: [
                Container(
                  child: Text("Track Progress"),
                  padding: EdgeInsets.all(10),
                ),
                Image.asset('assets/images/TrackProgress.png', height: 390, width: 200),
              ],
            ),
          ),
          /// Evaluate Agreement
          Container(
            margin: EdgeInsets.fromLTRB(20, 15, 45, 5),
            padding: EdgeInsets.fromLTRB(20, 15, 20, 20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              border: Border.all(color: const Color(0xff0A0A5B), width: 1),
            ),
            child: Column(
              children: [
                Container(
                  child: Text("Evaluate Agreement"),
                  padding: EdgeInsets.all(10),
                ),
                Image.asset('assets/images/evaluateAgreement.png', height: 390, width: 200),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

