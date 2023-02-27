///File download from FlutterViz- Drag and drop a tools. For more details visit https://flutterviz.io/

import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:negotiation_tracker/StartNewNegotiation.dart';
import 'package:negotiation_tracker/WeightIssues.dart';

import 'main.dart';

class DetermineIssues extends StatelessWidget {
  bool iconColor = false;
  final _items = ['Issue 1'];
  final _controllers = [TextEditingController()];

  static final GlobalKey<AnimatedListState> _key =
      GlobalKey<AnimatedListState>();

  void _addIssues() {
    // Adds an issue and text editing controller for the list view
    _controllers.insert(0, TextEditingController());
    _items.insert(0, 'Issue ${_items.length + 1}');

    _key.currentState!
        .insertItem(0, duration: const Duration(milliseconds: 200));
    //meant to reset issue numbers inside text box in descending order
    for (int i = 0; i < _items.length; i++) {
      if (_items[i].contains("Issue")) {
        _items[i] = 'Issue ${i + 1}';
      } //end if
    } //end for
  } //end add issues

  void _removeIssue(int index) {
    // Removes the Controller for the index removed
    _controllers.removeAt(index);

    _key.currentState!.removeItem(index, (_, animation) {
      return SizeTransition(
        sizeFactor: animation,
        child: const Card(
          margin: EdgeInsets.all(10),
          elevation: 0,
          color: Color(0xFFDB7877),
          child: ListTile(
            contentPadding: EdgeInsets.all(15),
          ),
        ),
      );
    }, duration: const Duration(milliseconds: 200));
    _items.removeAt(index);
    //meant to reset issue numbers inside textbox in descending order
    for (int i = 0; i < _items.length; i++) {
      if (_items[i].contains("Issue")) {
        _items[i] = 'Issue ${i + 1}';
      } //end if
    } //end for
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xffffffff),
        appBar: const PrepareBar(),
        body: Column(children: [
          // Top bar
          Container(
            margin: const EdgeInsets.all(0),
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: const Color(0x2000000),
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.zero,
              border: Border.all(color: const Color(0x7f000000), width: 1),
            ),
            child: Row(children: [
              Expanded(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: const [
                  Padding(
                    padding: EdgeInsets.fromLTRB(48, 10, 0, 0),
                    child: Expanded(
                      child: Text(
                        "Step 1/3",
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.clip,
                        style: TextStyle(
                          fontWeight: FontWeight.w800,
                          fontStyle: FontStyle.normal,
                          fontSize: 22,
                          color: Color(0xff000000),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(48, 8, 0, 0),
                    child: Text(
                      "Determine the Issues",
                      textAlign: TextAlign.start,
                      overflow: TextOverflow.clip,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontStyle: FontStyle.normal,
                        fontSize: 16,
                        color: Color(0xff000000),
                      ),
                    ),
                  ),
                ],
              )),
              Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: IconButton(
                    icon: const Icon(Icons.info_outline),
                    color: iconColor ? Colors.black : const Color(0xFF3B66B7),
                    onPressed: () {
                      iconColor = true;

                      showDialog(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                          title: const Text(
                            'How to Determine Issues',
                            textAlign: TextAlign.center,
                          ),
                          content: const Text(
                              'An issue is something the negotiators will try to reach an agreement on. '
                              'Consider all the issues relevant to their negotiation. '
                              'Be sure to include any issues that could make the deal better '
                              'for you and/or your counterpart.'),
                          actions: [
                            TextButton(
                              child: const Text('Okay'),
                              style: TextButton.styleFrom(
                                foregroundColor: Color(0xFF6DC090),
                              ),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                          ],
                        ),
                      );
                    },
                    iconSize: 40,
                  )),
            ]),
          ),
          Expanded(
            child: AnimatedList(
                key: _key,
                initialItemCount: 0,
                padding: const EdgeInsets.all(10),
                itemBuilder: (_, index, animation) {
                  return SizeTransition(
                      sizeFactor: animation,
                      child: Card(
                          margin: const EdgeInsets.all(10),
                          elevation: 4,
                          color: Color(0xffFFFFFF),
                          child: ListTile(
                            contentPadding: const EdgeInsets.all(15),
                            title: TextFormField(
                              controller: _controllers[index],
                              decoration: InputDecoration(
                                border: const OutlineInputBorder(),
                                labelText: _items[index],
                              ),
                            ),
                            trailing: IconButton(
                              icon: const Icon(
                                Icons.delete,
                                color: Color(0xFFDB7877),
                              ),
                              onPressed: () => _removeIssue(index),
                            ),
                          )));
                } // item builder
                ),
          ),
          Column(
            children: [
              const Divider(
                height: 0,
                thickness: 1,
                indent: 0,
                endIndent: 0,
                color: Color(0xff3e4b8c),
              ),
              // "Add Issues" At bottom
              Container(
                width: MediaQuery.of(context).size.height,
                  child: TextButton(
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.fromLTRB(8, 16, 8, 16),
                  textStyle: const TextStyle(fontSize: 18),
                  backgroundColor: const Color(0x9BFFFFFF),
                  foregroundColor: const Color(0xff3e4b8c),
                ),
                onPressed: _addIssues,
                child: const Text('Add Issue'),
              )),

              // Next and Back buttons
              Container(
                alignment: Alignment.bottomCenter,
                margin: const EdgeInsets.all(0),
                padding: const EdgeInsets.all(0),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: const Color(0x00ffffff),
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.zero,
                  border: Border.all(color: const Color(0x00ffffff), width: 0),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      flex: 1,
                      child: MaterialButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        color: const Color(0xff4d4d4d),
                        elevation: 0,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.zero,
                          side: BorderSide(color: Color(0xff808080), width: 1),
                        ),
                        padding: const EdgeInsets.all(16),
                        textColor: const Color(0xffffffff),
                        height: 40,
                        minWidth: 140,
                        child: const Text(
                          "Back",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            fontStyle: FontStyle.normal,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: MaterialButton(
                        onPressed: () {
                          currentNegotiation.issues
                              .putIfAbsent("issueNames", () => {});
                          currentNegotiation.issues["issueNames"]?.clear();

                          // For each issue add it to the currentNegotiation list
                          for (int i = 0; i < _controllers.length - 1; i++) {
                            // Give issue a place holder map
                            if (_controllers[i].text != "") {
                              currentNegotiation.issues["issueNames"]
                                  ?.putIfAbsent(_controllers[i].text, () => {});

                              currentNegotiation.cpIssues.putIfAbsent(_controllers[i].text, () => null);
                            }



                          }
                          print(currentNegotiation.toString());
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => WeightIssues()),
                          );
                        },
                        color: const Color(0xff4d4d4d),
                        elevation: 0,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.zero,
                          side: BorderSide(color: Color(0xff808080), width: 1),
                        ),
                        padding: const EdgeInsets.all(16),
                        textColor: const Color(0xffffffff),
                        height: 40,
                        minWidth: 140,
                        child: const Text(
                          "Next",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            fontStyle: FontStyle.normal,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )
        ]));
  }
}

abstract class ListItem {
  Widget TextField();
}
