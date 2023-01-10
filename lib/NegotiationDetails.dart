import 'dart:io';

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class Negotiation{
  final int? id;
  String title;
  String? summary;
  Map<String, int>? issues;
  Map<String, List<int>>? issueValues;
  int? target;
  int? resistance;
  int? BATNA;
  int? currentOffer;

  Negotiation({this.id, required this.title,required this.summary, required this.issues, required this.issueValues,
    required this.target, required this.resistance, required this.BATNA, required this.currentOffer});

  Negotiation.fromNegotiation({this.id, required this.title});


  factory Negotiation.fromMap(Map<String, dynamic> json) => Negotiation(
    id: json['id'],
    title: json['title'],
    summary: json['summary'],
    issues: json['issues'],
    issueValues: json['issueValues'],
    target: json['target'],
    resistance: json['resistance'],
    BATNA: json['BATNA'],
    currentOffer: json['currentOffer']
  );

  Map<String, dynamic> toMap(){
    return {
      'id': id,
      'title': title,
      'summary': summary,
      'issues': issues,
      'issueValues': issueValues,
      'target': target,
      'resistance': resistance,
      'BATNA': BATNA,
      'currentOffer': currentOffer
    };
  }
}

class DatabaseHelper{
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;
  Future<Database> get database async => _database ??= await _initDatabase();

  Future<Database> _initDatabase() async{
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, 'negotiations.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }
  // COULD BE WHERE EVERYTHING GOES WRONG
  Future _onCreate(Database db, int version) async{
    await db.execute('''
      CREATE TABLE negotiations(
        id INTEGER PRIMARY KEY,
        title TEXT,
        summary TEXT,
        issues TEXT,
        issueValues TEXT,
        target INTEGER,
        resistance INTEGER,
        BATNA INTEGER,
        currentOffer INTEGER
      )
    ''');
  }

  Future<List<Negotiation>> getNegotiations() async {
    Database db = await instance.database;
    var negotiations = await db.query('negotiations', orderBy: 'id');
    List<Negotiation> negotiationList = negotiations.isNotEmpty
        ? negotiations.map((c) => Negotiation.fromMap(c)).toList()
        : [];
    return negotiationList;
  }

  Future<int> add(Negotiation negotiation) async{
    Database db = await instance.database;
    return await db.insert('negotiations', negotiation.toMap());
  }

  Future<int> remove(int id) async {
    Database db = await instance.database;
    return await db.delete('negotiations', where: 'id = ?', whereArgs: [id]);
  }

  Future<int> update(Negotiation negotiation) async {
    Database db = await instance.database;
    return await db.update('negotiations', negotiation.toMap(), where: 'id = ?', whereArgs: [negotiation.id]);
  }
}