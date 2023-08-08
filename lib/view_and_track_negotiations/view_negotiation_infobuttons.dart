import 'package:flutter/material.dart';
import '../NegotiationDetails.dart';

/// This functions display the info buttons on the rubric page in my negotiations
Future<void> showInfoRubric({context, target, resistance}) {
  return showDialog(
    context: context,
    builder: (BuildContext context) =>
        AlertDialog(
          title: Text("Overall Rubric"),
          content: Container(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("This slider shows the overall rubric of the negotiation.\n"),
                Text("Your Target is: $target"),
                Text("Your Resistance is: $resistance"),
                Text("Your Bargaining Range is: ${target-resistance}")
              ]
            ),
          ),
          actions: [
            TextButton(
              child: const Text('Okay'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
  );
}

/// This function displays the info for Negotiation Rubric Issues
Future<void> showInfoIssueRubric({context, required Map<String, dynamic> issueVals, required String datatype}){
  return showDialog(
    context: context,
    builder: (BuildContext context) =>
        AlertDialog(
          title: Text("Overall Rubric"),
          content: Container(
            child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("This slider shows the rubric for each negotiation issue.\n"),
                  Text("Your A points (target) is: ${issueVals["A"][0]}. This holds the value: ${issueVals["A"][1]} $datatype"),
                  Text("Your B points is: ${issueVals["B"][0]}. This holds the value: ${issueVals["B"][1]} $datatype"),
                  Text("Your C points is: ${issueVals["C"][0]}. This holds the value: ${issueVals["C"][1]} $datatype"),
                  Text("Your D points (resistance) is: ${issueVals["D"][0]}. This holds the value: ${issueVals["D"][1]} $datatype"),
                  Text("Your F points is: ${issueVals["F"][0]}.This holds the value: ${issueVals["F"][1]} $datatype"),


                  // Text("Your Target is: $target"),
                  // Text("Your Resistance is: $resistance"),
                  // Text("Your Bargaining Range is: ${target-resistance}")
                ]
            ),
          ),
          actions: [
            TextButton(
              child: const Text('Okay'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
  );
}

/// function display the issue info buttons for the issue slider on track progress page
Future<void> showInfoTrackProgress(context, String name, String letter, int points, bool aboveResistance){


  return showDialog(
    context: context,
    builder: (BuildContext context) =>
        AlertDialog(
          title: Text("Issue Info"),
          content: Container(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("This slider represents the values of this issue.\n"),
                Text("Your current value is $points points, or $name.\nThis is a $letter grade for this issue.\n"),
                if(aboveResistance) Text("You are currently above your resistance."),
                if(!aboveResistance) Text("You are current not above your resistance. This is an issue to focus on."),
              ],
            ),
          ),
          actions: [
            TextButton(
              child: const Text('Okay'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
  );
}

/// These two functions display the issue info buttons for the total value sliders on track progress page
Future<void> showTotalInfoTrackProgress(context, Negotiation negotiation){

  bool aboveTarget = (negotiation.currentAgreement! >= negotiation.target);
  bool belowResistance = (negotiation.currentAgreement! <= negotiation.resistance);
  int points = negotiation.currentAgreement!;

  return showDialog(
    context: context,
    builder: (BuildContext context) =>
        AlertDialog(
          title: Text("Total Value"),
          content: info_content_total_track_progress(aboveTarget: aboveTarget, belowResistance: belowResistance, points: points,),
          actions: [
            TextButton(
              child: const Text('Okay'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
  );
}
class info_content_total_track_progress extends StatelessWidget{

  final bool aboveTarget;
  final bool belowResistance;
  final int points;

  info_content_total_track_progress({required this.belowResistance, required this.aboveTarget, required this.points});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text("This slider represents the overall value of your negotiation so far and is automatically moved when your individual issues bars are moved.\n"),
          if(aboveTarget) Text("Your current point value is $points, which is above your target! \n(Why the bar is green)"),
          if(belowResistance) Text("Your current point value is $points, which is below your resistance. \n(Why the bar is red)"),
          if(!belowResistance && !aboveTarget) Text("Your current point value is $points, which is inside your bargaining range. \n(Why the bar is blue)")
        ],
      ),
    );
  }


}