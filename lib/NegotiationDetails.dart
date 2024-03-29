import 'package:cloud_firestore/cloud_firestore.dart';

class Negotiation {
  String title;
  String? summary;
  List<Issue> issues;
  double target;
  double resistance;
  int? BATNA;
  int? currentOffer;

  int? currentAgreement = 0;
  bool pinned = false;

  // int cpTarget;
  // int cpBATNA;
  // int cpResistance;

  Negotiation(
      {
      required this.title,
      required this.summary,
      required this.issues,
      required this.target,
      required this.resistance,
      required this.BATNA,

      this.currentAgreement,
      this.pinned=false,

      });

  Negotiation.fromNegotiation(
      {
      required this.title,
      required this.issues,
      // required this.cpTarget,
      // required this.cpResistance,
      // required this.cpBATNA,
      required this.target,
      required this.resistance,
      this.currentAgreement
    });

  String toString() {
    return "Title: $title, Summary: $summary, BATNA: $BATNA, Issues: ${issues.toString()}";
  }

  factory Negotiation.fromFirestore(
    DocumentSnapshot<Object?>? snapshot,
  ) {

    /// Convert JSONs requirements for only objects and arrays back into the issue list
    List<dynamic> issueList = snapshot!.get("issues");
    List<Issue> issuePlace = [];

    issueList.forEach((map) => {
      issuePlace.add(Issue.fromMap(map))
    });

    return Negotiation(
      title: snapshot.get("title"),
      summary: snapshot.get("summary"),
      issues: issuePlace,
      target: snapshot.get("target"),
      resistance: snapshot.get("resistance"),
      BATNA: snapshot.get("BATNA"),
      currentAgreement: snapshot.get("currentAgreement"),
      pinned: snapshot.get("pinned"),

      // cpTarget: snapshot.get("cpTarget"),
      // cpBATNA: snapshot.get("cpBATNA"),
      // cpResistance: snapshot.get("cpResistance"),
    );
  }

  Map<String, dynamic> toFirestore() {

    /// Must only give firestore an object or array, so turn issue list into
    /// a list of a map representation of an issue
    /// (object in JSON = Map)
    List<Map<String, dynamic>> issueList = [];
    issues.forEach((issue) => {
      issueList.add(issue.toFirestore())
    });

    return {
      if (title != null) "title": title,
      if (summary != null) "summary": summary,
      "issues": issueList,
      if (target != null) "target": target,
      if (resistance != null) "resistance": resistance,
      if (BATNA != null) "BATNA": BATNA,
      if (currentOffer != null) "currentOffer": currentOffer,
      "currentAgreement": currentAgreement,
      "pinned": pinned,
      // if (cpTarget != null) "cpTarget": cpTarget,
      // if (cpBATNA != null) "cpBATNA": cpBATNA,
      // if (cpResistance != null) "cpResistance": cpResistance,
    };
  }

  static Future<Negotiation?> getDocSnap(String id) async {
    FirebaseFirestore.instance
        .collection("users")
        .doc(id)
        .collection("Negotiations")
        .doc(id)
        .get()
        .then((DocumentSnapshot snapshot) {
      return Negotiation.fromFirestore(snapshot);
    });

    return null;
  }
}

class Issue{
  String name = "";
  int relativeValue = -1;
  int? currentValue;
  String datatype = "";

  // An entry in this should be - Letter Grade: (Points, Real Value)
  Map<String, dynamic> issueVals = {};

  Issue({required this.name});

  String toString(){
    return "$name: ${issueVals.toString()}, RV: $relativeValue, DT: $datatype, CV: $currentValue";
  }

  Map<String, dynamic> toFirestore(){
    return {
      "name": name,
      "relativeValue": relativeValue,
      "issueVals": issueVals,
      "currentValue": currentValue,
      "datatype": datatype,
    };
  }

  factory Issue.fromMap(Map<String, dynamic> ss){
    Issue here = new Issue(name: ss["name"]);

    here.relativeValue = ss["relativeValue"];
    here.issueVals = ss["issueVals"];
    here.currentValue = ss["currentValue"].truncate();
    here.datatype = ss["datatype"];
    return here;
  }
}
