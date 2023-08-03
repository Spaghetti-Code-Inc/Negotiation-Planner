import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'NegotiationDetails.dart';

class Utils {
  static final messengerKey = GlobalKey<ScaffoldMessengerState>();

  static showSnackBar(String? text) {
    if (text == null) return;

    final snackBar = SnackBar(content: Text(text), backgroundColor: CupertinoColors.activeBlue);

    messengerKey.currentState!
      ..removeCurrentSnackBar()
      ..showSnackBar(snackBar);
  }

  /// Same method from 'rubric summary' look there for documentation
  static List<String> findHighestValuedIssues(List<Issue> issues) {
    List<int> vals = [];
    List<String> names = [];
    issues.forEach((issue) => {
      vals.add(issue.relativeValue)
    });

    vals.sort();


    for(int i = 0; i < issues.length; i++){
      for(int j = 1; j < 4; j++){
        if(vals[vals.length-j] == issues[i].relativeValue){
          names.add(issues[i].name);
          break;
        }
      }
    }

    // Fill names list to 3 values
    if(names.length == 1)
      names.add("");
    if (names.length == 2)
      names.add("");
    return names.sublist(0, 3);
  }
}

class PrepareNegotiationNextBar extends StatelessWidget {
  Function Next;
  Widget NextPage;

  PrepareNegotiationNextBar({Key? key, required this.Next, required this.NextPage}) : super(key: key);

  late bool show = (WidgetsBinding.instance.window.viewInsets.bottom == 0);

  /// Next and back buttons for the prepare new negotiation pages
  @override
  Widget build(BuildContext context) {
    if(show){
      return Container(
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
                  color: const Color(0xffffffff),
                  elevation: 0,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.zero,
                    side: BorderSide(color: Color(0xff0A0A5B), width: 1),
                  ),
                  padding: const EdgeInsets.all(16),
                  textColor: const Color(0xff0A0A5B),
                  height: 40,
                  minWidth: 140,
                  child: const Icon(Icons.arrow_back)),
            ),
            Expanded(
              flex: 1,
              child: MaterialButton(
                  onPressed: () {
                    /// Code passed from parent widget
                    if(Next()){
                      Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => NextPage)
                      );
                    }
                  },
                  color: const Color(0xffffffff),
                  elevation: 0,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.zero,
                    side: BorderSide(color: Color(0xff0A0A5B), width: 1),
                  ),
                  padding: const EdgeInsets.all(16),
                  textColor: const Color(0xff0A0A5B),
                  height: 40,
                  minWidth: 140,
                  child: const Icon(Icons.arrow_forward)),
            ),
          ],
        ),
      );
    }
    else {
      return Text("");
    }

  }
}
