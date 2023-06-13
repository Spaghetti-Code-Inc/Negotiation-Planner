///File download from FlutterViz- Drag and drop a tools. For more details visit https://flutterviz.io/

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:negotiation_tracker/create_negotiation/WeightIssues.dart';

import '../Utils.dart';
import '../main.dart';
import 'MAX_LENGTHS.dart';

class DetermineIssues extends StatelessWidget {
  bool iconColor = false;
  final _items = ['Issue 1', 'Issue 2'];
  final _controllers = [TextEditingController(), TextEditingController()];

  static final GlobalKey<AnimatedListState> _key = GlobalKey<AnimatedListState>();

  void _addIssues() {
    // Adds an issue and text editing controller for the list view
    _controllers.insert(0, TextEditingController());
    _items.insert(0, 'Issue ${_items.length + 1}');

    _key.currentState!.insertItem(0, duration: const Duration(milliseconds: 200));
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
        resizeToAvoidBottomInset: false,
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
                  Padding(
                    padding: EdgeInsets.fromLTRB(48, 8, 0, 0),
                    child: Text(
                      "Determine the Issues",
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
                ],
              )),
              Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: IconButton(
                    icon: const Icon(Icons.info_outline),
                    color: iconColor ? Colors.black : const Color(0xff0A0A5B),
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
          /// Contains list of issues
          Expanded(
            child: AnimatedList(
                key: _key,
                initialItemCount: 1,
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
                              inputFormatters: [
                                /// Determines max length of the Issue name
                                LengthLimitingTextInputFormatter(MAX_ISSUE_NAME)
                              ],
                              cursorColor: Color(0xff0A0A5B),
                              controller: _controllers[index],
                              decoration: InputDecoration(
                                enabledBorder: const OutlineInputBorder(
                                  borderSide:
                                      const BorderSide(color: Color(0xff0A0A5B), width: 0.0),
                                ),
                                focusedBorder: const OutlineInputBorder(
                                  borderSide: const BorderSide(color: Color(0xff0A0A5B)),
                                ),
                                labelText: _items[index],
                                labelStyle: TextStyle(color: Color(0xff0A0A5B)),
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
                color: Color(0xff0A0A5B),
              ),
              // "Add Issues" At bottom
              Container(
                  width: MediaQuery.of(context).size.height,
                  child: TextButton(
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.fromLTRB(8, 16, 8, 16),
                      textStyle: const TextStyle(fontSize: 18),
                      backgroundColor: const Color(0x9BFFFFFF),
                      foregroundColor: const Color(0xff0A0A5B),
                    ),
                    onPressed: _addIssues,
                    child: const Text('Add Issue'),
                  ),
              ),

              /// Next and back buttons
              PrepareNegotiationNextBar(Next: Next, NextPage: WeightIssues())
              
            ],
          )
        ]));
  }

  bool Next(){
    /// Code passed from parent widget
    if (_controllers.length != 0) {
      currentNegotiation.issues.clear();

      // For each issue add it to the currentNegotiation list
      for (int i = 0; i < _controllers.length - 1; i++) {
        // Give issue a place holder map
        if (_controllers[i].text != "") {
          currentNegotiation.issues.putIfAbsent(_controllers[i].text, () => {});

          currentNegotiation.cpIssues.putIfAbsent(_controllers[i].text, () => null);
        }
      }

      return true;
    } else {
      Utils.showSnackBar("You must have at least 1 issue");
      return false;
    }
  }
}