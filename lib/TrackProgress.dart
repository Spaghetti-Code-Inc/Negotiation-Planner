///File download from FlutterViz- Drag and drop a tools. For more details visit https://flutterviz.io/

import 'package:flutter/material.dart';

import 'DetermineIssues.dart';
import 'main.dart';

class TrackProgress extends StatelessWidget {
  const TrackProgress({super.key});
  //override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PrepareBar(),
      backgroundColor: const Color(0xffffffff),
      body: Align(
        alignment: Alignment.center,
        child: Container(
          margin: EdgeInsets.zero,
          padding: EdgeInsets.zero,
          width: MediaQuery.of(context).size.width * 0.9,
          height: MediaQuery.of(context).size.height * 0.7000000000000001,
          decoration: const BoxDecoration(
            color: Color(0x00000000),
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.zero,
          ),
          child: Padding(
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
                    const Expanded(
                      flex: 1,
                      child: Text(
                        "Issue 1:",
                        textAlign: TextAlign.start,
                        overflow: TextOverflow.clip,
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontStyle: FontStyle.normal,
                          fontSize: 16,
                          color: Color(0xff000000),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: IconButton(
                        icon: const Icon(Icons.expand_more),
                        onPressed: () {},
                        color: const Color(0xff212435),
                        iconSize: 24,
                      ),
                    ),
                  ],
                ),
                Slider(
                  onChanged: (value) {},
                  value: 0,
                  min: 0,
                  max: 10,
                  activeColor: const Color(0xff3a57e8),
                  inactiveColor: const Color(0xff9e9e9e),
                  label: "0",
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    const Expanded(
                      flex: 1,
                      child: Text(
                        "Issue 2:",
                        textAlign: TextAlign.start,
                        overflow: TextOverflow.clip,
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontStyle: FontStyle.normal,
                          fontSize: 16,
                          color: Color(0xff000000),
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.expand_more),
                      onPressed: () {},
                      color: const Color(0xff212435),
                      iconSize: 24,
                    ),
                  ],
                ),
                Slider(
                  onChanged: (value) {},
                  value: 0,
                  min: 0,
                  max: 10,
                  activeColor: const Color(0xff3a57e8),
                  inactiveColor: const Color(0xff9e9e9e),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    const Expanded(
                      flex: 1,
                      child: Text(
                        "Issue 3:",
                        textAlign: TextAlign.start,
                        overflow: TextOverflow.clip,
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontStyle: FontStyle.normal,
                          fontSize: 16,
                          color: Color(0xff000000),
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.expand_more),
                      onPressed: () {},
                      color: const Color(0xff212435),
                      iconSize: 24,
                    ),
                  ],
                ),
                Slider(
                  onChanged: (value) {},
                  value: 0,
                  min: 0,
                  max: 10,
                  activeColor: const Color(0xff3a57e8),
                  inactiveColor: const Color(0xff9e9e9e),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
