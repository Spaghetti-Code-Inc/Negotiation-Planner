///File download from FlutterViz- Drag and drop a tools. For more details visit https://flutterviz.io/

import 'package:flutter/material.dart';

import 'main.dart';

class EvaluateAggreement extends StatelessWidget {
  const EvaluateAggreement({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffffffff),
      appBar: const PrepareBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        const Padding(
                          padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              "ISSUE 1:",
                              textAlign: TextAlign.start,
                              overflow: TextOverflow.clip,
                              style: TextStyle(
                                fontWeight: FontWeight.w800,
                                fontStyle: FontStyle.normal,
                                fontSize: 12,
                                color: Color(0xff000000),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(170, 0, 0, 0),
                          child: IconButton(
                            icon: const Icon(Icons.expand_more),
                            onPressed: () {},
                            color: const Color(0xff212435),
                            iconSize: 20,
                          ),
                        ),
                      ],
                    ),
                    Slider(
                      onChanged: (value) {},
                      value: 0,
                      min: 0,
                      max: 10,
                      activeColor: const Color(0xff000000),
                      inactiveColor: const Color(0xff9e9e9e),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          const Padding(
                            padding: EdgeInsets.fromLTRB(15, 10, 0, 0),
                            child: Text(
                              "ISSUE 2:",
                              textAlign: TextAlign.start,
                              overflow: TextOverflow.clip,
                              style: TextStyle(
                                fontWeight: FontWeight.w800,
                                fontStyle: FontStyle.normal,
                                fontSize: 12,
                                color: Color(0xff000000),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(170, 0, 0, 0),
                            child: IconButton(
                              icon: const Icon(Icons.expand_more),
                              onPressed: () {},
                              color: const Color(0xff212435),
                              iconSize: 20,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Slider(
                      onChanged: (value) {},
                      value: 0,
                      min: 0,
                      max: 10,
                      activeColor: const Color(0xff000000),
                      inactiveColor: const Color(0xff9e9e9e),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        const Padding(
                          padding: EdgeInsets.fromLTRB(15, 5, 0, 0),
                          child: Text(
                            "ISSUE 3:",
                            textAlign: TextAlign.start,
                            overflow: TextOverflow.clip,
                            style: TextStyle(
                              fontWeight: FontWeight.w800,
                              fontStyle: FontStyle.normal,
                              fontSize: 12,
                              color: Color(0xff000000),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(170, 0, 0, 0),
                          child: IconButton(
                            icon: const Icon(Icons.expand_more),
                            onPressed: () {},
                            color: const Color(0xff212435),
                            iconSize: 20,
                          ),
                        ),
                      ],
                    ),
                    Slider(
                      onChanged: (value) {},
                      value: 0,
                      min: 0,
                      max: 10,
                      activeColor: const Color(0xff000000),
                      inactiveColor: const Color(0xff9e9e9e),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
                      child: MaterialButton(
                        onPressed: () {},
                        color: const Color(0xff4d4d4d),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        padding: const EdgeInsets.all(16),
                        textColor: const Color(0xffffffff),
                        height: 40,
                        minWidth: 140,
                        child: const Text(
                          "Flag",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            fontStyle: FontStyle.normal,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                      child: MaterialButton(
                        onPressed: () {},
                        color: const Color(0xffbfbfbf),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        padding: const EdgeInsets.all(16),
                        textColor: const Color(0xff000000),
                        height: 40,
                        minWidth: 140,
                        child: const Text(
                          "Calculate",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            fontStyle: FontStyle.normal,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                      child: MaterialButton(
                        onPressed: () {},
                        color: const Color(0xffbfbfbf),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        padding: const EdgeInsets.all(16),
                        textColor: const Color(0xff000000),
                        height: 40,
                        minWidth: 140,
                        child: const Text(
                          "Tradeoffs",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            fontStyle: FontStyle.normal,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 40, 0, 0),
                      child: MaterialButton(
                        onPressed: () {},
                        color: const Color(0xff4d4d4d),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        padding: const EdgeInsets.all(16),
                        textColor: const Color(0xffffffff),
                        height: 40,
                        minWidth: MediaQuery.of(context).size.width * 0.9,
                        child: const Text(
                          "Exit",
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
              const LinearProgressIndicator(
                  backgroundColor: Color(0xff808080),
                  valueColor:
                      AlwaysStoppedAnimation<Color>(Color(0xff3a57e8)),
                  value: 0.5,
                  minHeight: 3),
            ],
          ),
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {},
            color: const Color(0xff212435),
            iconSize: 24,
          ),
        ],
      ),
    );
  }
}
