
import 'package:firebase_database/firebase_database.dart';

class Post {
  static const DATE  = "date";
  static const KEY   = "key";
  static const TITLE = "title";
  static const BODY  = "body";

  int date;
  String key;
  String title;
  String body;

  Post(this.date, this.title, this.body);

/*  String get date => _date;
  String get key => _key;
  String get title => _title;
  String get body => _body;*/

  Post.fromSnapshot(DataSnapshot snap):
        this.key = snap.key,
        this.date = snap.value[DATE],
        this.title = snap.value[TITLE],
        this.body = snap.value[BODY];

  toMap () {
    return {BODY:body,DATE:date,TITLE:title,KEY:key};
  }

}