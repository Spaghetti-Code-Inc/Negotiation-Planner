import 'package:cloud_firestore/cloud_firestore.dart';

class Negotiation {
  String? id;
  String title;
  String? summary;
  Map<String, dynamic> issues;
  int target;
  int resistance;
  int? BATNA;
  int? currentOffer;

  int cpTarget;
  int cpBATNA;
  int cpResistance;

  Map<String, dynamic> cpIssues;

  Negotiation(
      {this.id,
      required this.title,
      required this.summary,
      required this.issues,
      required this.target,
      required this.resistance,
      required this.BATNA,
      required this.currentOffer,
      required this.cpIssues,
      required this.cpTarget,
      required this.cpResistance,
      required this.cpBATNA});

  Negotiation.fromNegotiation(
      {this.id,
      required this.title,
      required this.issues,
      required this.cpIssues,
      required this.cpTarget,
      required this.cpResistance,
      required this.cpBATNA,
      required this.target,
      required this.resistance});

  String toString() {
    return "Title: $title, Summary: $summary, Issues: ${issues.toString()}, Counter Part Issues: ${cpIssues.toString()}, CPTarget ${cpTarget}";
  }

  factory Negotiation.fromFirestore(
    DocumentSnapshot<Object?>? snapshot,
  ) {
    print(snapshot?.get("cpIssues").runtimeType);
    print(snapshot?.get("cpIssues"));
    return Negotiation(
      id: snapshot!.get("id"),
      title: snapshot.get("title"),
      summary: snapshot.get("summary"),
      issues: Map.of(snapshot.get("issues")),
      target: snapshot.get("target"),
      resistance: snapshot.get("resistance"),
      BATNA: snapshot.get("BATNA"),
      currentOffer: snapshot.get("currentOffer"),
      cpIssues: Map.of(snapshot.get("cpIssues")),
      cpTarget: snapshot.get("cpTarget"),
      cpBATNA: snapshot.get("cpBATNA"),
      cpResistance: snapshot.get("cpResistance"),
    );
  }

  Map<String, dynamic> toFirestore() {
    Map<String, dynamic> NestedData = {
      if (id != null) "id": id,
      if (title != null) "title": title,
      if (summary != null) "summary": summary,
      "issues": issues,
      if (target != null) "target": target,
      if (resistance != null) "resistance": resistance,
      if (BATNA != null) "BATNA": BATNA,
      if (currentOffer != null) "currentOffer": currentOffer,
      if (cpIssues != null) "cpIssues": cpIssues,
      if (cpTarget != null) "cpTarget": cpTarget,
      if (cpBATNA != null) "cpBATNA": cpBATNA,
      if (cpResistance != null) "cpResistance": cpResistance,
    };

    Map<String, dynamic> negotiationId = NestedData;
    return negotiationId;
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
