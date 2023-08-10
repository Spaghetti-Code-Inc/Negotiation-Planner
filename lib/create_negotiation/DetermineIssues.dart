import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:negotiation_tracker/create_negotiation/WeightIssues.dart';

import '../NegotiationDetails.dart';
import '../Utils.dart';
import '../main.dart';
import 'MAX_LENGTHS.dart';

class DetermineIssues extends StatefulWidget {
  const DetermineIssues({Key? key}) : super(key: key);

  @override
  State<DetermineIssues> createState() => _DetermineIssuesState();
}

class _DetermineIssuesState extends State<DetermineIssues> {
  bool iconColor = false;
  final _items = ['Issue 1'];
  final _controllers = [TextEditingController()];
  List<FocusNode> _focus = [FocusNode()];

  static final GlobalKey<AnimatedListState> _key = GlobalKey<AnimatedListState>();

  void _addIssues({String name=""}) {
    // Adds an issue and text editing controller for the list view
    _controllers.add(TextEditingController());
    _items.add('Issue ${_items.length + 1}');
    _focus.add(FocusNode());

    print(_controllers.length);
    _key.currentState!.insertItem(_controllers.length-1, duration: const Duration(milliseconds: 200));
    //meant to reset issue numbers inside text box in descending order
    for (int i = 0; i < _items.length; i++) {
      if (_items[i].contains("Issue")) {

        if(name != "") _items[i] = name;
        else _items[i] = 'Issue ${i + 1}';
      } //end if
    } //end for
  } //end add issues

  void _removeIssue(int index) {
    // Removes the Controller for the index removed
    _controllers.removeAt(index);
    _focus.removeAt(index);
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
        resizeToAvoidBottomInset: true,
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
                              focusNode: _focus[index],
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
                  onPressed: () {
                    setState(() {
                      _addIssues();
                    });

                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      FocusScope.of(context).requestFocus(_focus[_focus.length-1]);
                    });
                  },
                  child: const Text('Add Issue'),
                ),
              ),

              const Divider(
                height: 0,
                thickness: 1,
                indent: 0,
                endIndent: 0,
                color: Color(0xff0A0A5B),
              ),

              /// Next and back buttons
              PrepareNegotiationNextBar(Next: Next, NextPage: WeightIssues())

            ],
          )
        ]));
  }

  bool Next(){

    /// Searches for duplicate issues
    Set<String> check = Set();
    List<String> dupes = [];
    _controllers.forEach((TextEditingController t) => {
      if(check.contains(t.text)){
        dupes.add(t.text)
      } else check.add(t.text)
    });
    if (dupes.length != 0) {
      Utils.showSnackBar("No duplicate issue names are allowed: ${dupes[0]}");
      return false;
    }

    // List of indexes that already exist as determined issues
    List<int> exist = [];
    // Loops through issues backwards to delete the ones that do not have the same name
    for (int j = currentNegotiation.issues.length-1; j >= 0; j--){
      bool exists = false;
      // Loops through controllers to check if a controller text equals issue text
      for(int i = 0; i < _controllers.length; i++){
        if(currentNegotiation.issues[j].name == _controllers[i].text){
          exist.add(i);
          exists = true;
          break;
        }
      }
      // Deletes the issue if the name is no longer in the set of determined issues
      if(!exists) currentNegotiation.issues.removeAt(j);
    }

    /// For each issue add it to the currentNegotiation list
    for (int i = 0; i < _controllers.length; i++) {
      // Adds the issue if the name is not empty
      bool exists = false;
      for (int j = 0; j < exist.length; j++){
        if(i == exist[j]){
          exists = true;
        }
      }
      if (_controllers[i].text != "" && !exists) {
        currentNegotiation.issues.add(new Issue(name: _controllers[i].text));
      }
    }

    // If there are no named issues, return false
    if(currentNegotiation.issues.length == 0) {
      Utils.showSnackBar("Please enter in a name for at least one issue.");
      return false;
    }

    return true;
  }
}




