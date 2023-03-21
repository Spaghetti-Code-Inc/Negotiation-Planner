

import 'package:cloud_firestore/cloud_firestore.dart';

class Negotiation {
  String? id;
  String title;
  String? summary;
  Map<String, Map<String, dynamic>> issues;
  int? target;
  int? resistance;
  int? BATNA;
  int? currentOffer;

  int? cpTarget;
  int? cpBATNA;
  int? cpResistance;

  Map<String?, int?> cpIssues;

  Negotiation(
      {this.id, required this.title, required this.summary, required this.issues,
        required this.target, required this.resistance, required this.BATNA, required this.currentOffer, required this.cpIssues, required cpTarget, required cpResistance, required cpBATNA});

  Negotiation.fromNegotiation({this.id, required this.title, required this.issues, required this.cpIssues});

  String toString(){
    return "Title: $title, Summary: $summary, Issues: ${issues.toString()}, Counter Part Issues: ${cpIssues.toString()}";
  }

  factory Negotiation.fromFirestore(
      DocumentSnapshot<Object?>? snapshot,

      ){
    return Negotiation(
      id: snapshot?.get("id"),
      title: snapshot?.get("title"),
      summary: snapshot?.get(""),
      issues: snapshot?.get(""),
      target: snapshot?.get(""),
      resistance: snapshot?.get(""),
      BATNA: snapshot?.get(""),
      currentOffer: snapshot?.get(""),
      cpIssues: snapshot?.get(""),
      cpTarget: snapshot?.get(""),
      cpBATNA: snapshot?.get(""),
      cpResistance: snapshot?.get(""),
    );
  }
  

  Map<String, dynamic> toFirestore() {
    Map<String, dynamic> NestedData = {
      if (id != null) "id": id,
      if (title != null) "title": title,
      if (summary != null) "summary": summary,
      if (issues != null) "issues": issues,
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

}