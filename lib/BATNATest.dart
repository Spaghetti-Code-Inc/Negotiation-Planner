///File download from FlutterViz- Drag and drop a tools. For more details visit https://flutterviz.io/

import 'package:flutter/material.dart';

class BATNATest extends StatelessWidget {
  const BATNATest({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffffffff),
      appBar: AppBar(
        elevation: 4,
        centerTitle: false,
        automaticallyImplyLeading: false,
        backgroundColor: Color(0xff000000),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.zero,
        ),
        title: const Text(
          "Prepare A New Negotiation",
          style: TextStyle(
            fontWeight: FontWeight.w400,
            fontStyle: FontStyle.normal,
            fontSize: 14,
            color: Color(0xffffffff),
          ),
        ),
        leading: const Icon(
          Icons.arrow_back,
          color: Color(0xffffffff),
          size: 24,
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                alignment: Alignment.topLeft,
                margin: EdgeInsets.all(0),
                padding: EdgeInsets.all(10),
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                  color: Color(0x1f000000),
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.zero,
                ),
                child: Align(
                  alignment: Alignment.topCenter,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          children: const [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Test Drive #1: Your BATNA",
                                textAlign: TextAlign.start,
                                overflow: TextOverflow.clip,
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontStyle: FontStyle.normal,
                                  fontSize: 14,
                                  color: Color(0xff000000),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const Padding(
                          padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Think about your Best Alternative to a Negotiation Agreement (BATNA).",
                              textAlign: TextAlign.start,
                              overflow: TextOverflow.clip,
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontStyle: FontStyle.normal,
                                fontSize: 14,
                                color: Color(0xff000000),
                              ),
                            ),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "If your BATNA is another offer, use this rubric to value that offer.",
                              textAlign: TextAlign.start,
                              overflow: TextOverflow.clip,
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontStyle: FontStyle.normal,
                                fontSize: 14,
                                color: Color(0xff000000),
                              ),
                            ),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Your BATNA could also reflect a completely different opportunity.",
                              textAlign: TextAlign.start,
                              overflow: TextOverflow.clip,
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontStyle: FontStyle.normal,
                                fontSize: 14,
                                color: Color(0xff000000),
                              ),
                            ),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Pick a number (based on your scoring system if possible) that reflects the value of your BATNA to you.",
                              textAlign: TextAlign.start,
                              overflow: TextOverflow.clip,
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontStyle: FontStyle.normal,
                                fontSize: 14,
                                color: Color(0xff000000),
                              ),
                            ),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Out of 100 points, the value of your BATNA is ___.",
                              textAlign: TextAlign.start,
                              overflow: TextOverflow.clip,
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontStyle: FontStyle.normal,
                                fontSize: 14,
                                color: Color(0xff000000),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(0, 3, 0, 0),
                          child: TextField(
                            controller: TextEditingController(),
                            obscureText: false,
                            textAlign: TextAlign.start,
                            maxLines: 1,
                            style: const TextStyle(
                              fontWeight: FontWeight.w400,
                              fontStyle: FontStyle.normal,
                              fontSize: 14,
                              color: Color(0xff000000),
                            ),
                            decoration: InputDecoration(
                              disabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(4.0),
                                borderSide: const BorderSide(
                                    color: Color(0xff000000), width: 1),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(4.0),
                                borderSide: const BorderSide(
                                    color: Color(0xff000000), width: 1),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(4.0),
                                borderSide: const BorderSide(
                                    color: Color(0xff000000), width: 1),
                              ),
                              labelText: "Pts.",
                              labelStyle: const TextStyle(
                                fontWeight: FontWeight.w400,
                                fontStyle: FontStyle.normal,
                                fontSize: 14,
                                color: Color(0xff000000),
                              ),
                              filled: true,
                              fillColor: Color(0xfff2f2f3),
                              isDense: true,
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 12),
                            ),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Test Drive #2: Your current offer",
                              textAlign: TextAlign.start,
                              overflow: TextOverflow.clip,
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontStyle: FontStyle.normal,
                                fontSize: 14,
                                color: Color(0xff000000),
                              ),
                            ),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Now use the scoring rubric to score the value of your current of fer before negotiating! (Example: List price.)",
                              textAlign: TextAlign.start,
                              overflow: TextOverflow.clip,
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontStyle: FontStyle.normal,
                                fontSize: 14,
                                color: Color(0xff000000),
                              ),
                            ),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Out of 100 points, the value of your current offer is ___.",
                              textAlign: TextAlign.start,
                              overflow: TextOverflow.clip,
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontStyle: FontStyle.normal,
                                fontSize: 14,
                                color: Color(0xff000000),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(0, 3, 0, 0),
                          child: TextField(
                            controller: TextEditingController(),
                            obscureText: false,
                            textAlign: TextAlign.start,
                            maxLines: 1,
                            style: const TextStyle(
                              fontWeight: FontWeight.w400,
                              fontStyle: FontStyle.normal,
                              fontSize: 14,
                              color: Color(0xff000000),
                            ),
                            decoration: InputDecoration(
                              disabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(4.0),
                                borderSide: const BorderSide(
                                    color: Color(0xff000000), width: 1),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(4.0),
                                borderSide: const BorderSide(
                                    color: Color(0xff000000), width: 1),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(4.0),
                                borderSide: const BorderSide(
                                    color: Color(0xff000000), width: 1),
                              ),
                              labelText: "Pts.",
                              labelStyle: const TextStyle(
                                fontWeight: FontWeight.w400,
                                fontStyle: FontStyle.normal,
                                fontSize: 14,
                                color: Color(0xff000000),
                              ),
                              filled: true,
                              fillColor: Color(0xfff2f2f3),
                              isDense: true,
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 12),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            flex: 1,
            child: Container(
              alignment: Alignment.bottomCenter,
              margin: EdgeInsets.all(0),
              padding: EdgeInsets.all(0),
              width: MediaQuery.of(context).size.width,
              height: 100,
              decoration: const BoxDecoration(
                color: Color(0x1f000000),
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.zero,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    flex: 1,
                    child: MaterialButton(
                      onPressed: () {},
                      color: Color(0xff4d4d4d),
                      elevation: 0,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero,
                        side: BorderSide(color: Color(0xff808080), width: 1),
                      ),
                      padding: EdgeInsets.all(16),
                      textColor: Color(0xffffffff),
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
                  Expanded(
                    flex: 1,
                    child: MaterialButton(
                      onPressed: () {},
                      color: Color(0xff4d4d4d),
                      elevation: 0,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero,
                        side: BorderSide(color: Color(0xff808080), width: 1),
                      ),
                      padding: EdgeInsets.all(16),
                      textColor: Color(0xffffffff),
                      height: 40,
                      minWidth: 140,
                      child: const Text(
                        "Start",
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
        ],
      ),
    );
  }
}
