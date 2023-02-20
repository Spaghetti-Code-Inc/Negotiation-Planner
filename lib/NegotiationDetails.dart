

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

  Negotiation(
      {this.id, required this.title, required this.summary, required this.issues,
        required this.target, required this.resistance, required this.BATNA, required this.currentOffer, required cpTarget, required cpResistance, required cpBATNA});

  Negotiation.fromNegotiation({this.id, required this.title, required this.issues});

  factory Negotiation.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options,
      ){
    final data = snapshot.data();
    return Negotiation(
      id: data?['id'],
      title: data?['title'],
      summary: data?['summary'],
      issues: data?['issues'],
      target: data?['target'],
      resistance: data?['resistance'],
      BATNA: data?['BATNA'],
      currentOffer: data?['currentOffer'],
      cpTarget: data?['cpTarget'],
      cpBATNA: data?['cpBATNA'],
      cpResistance: data?['cpResistance'],
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
      if (cpTarget != null) "cpTarget": cpTarget,
      if (cpBATNA != null) "cpBATNA": cpBATNA,
      if (cpResistance != null) "cpResistance": cpResistance,

    };


    Map<String, dynamic> negotiationId = NestedData;
    return negotiationId;
  }

}