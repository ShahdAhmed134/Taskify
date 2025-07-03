import 'package:cloud_firestore/cloud_firestore.dart';

class Task{
  static const String collectionName ='tasks';
  String title;
  String desc;
  DateTime time;
  bool isDone;
  String id;
  Task({this.id='',this.isDone=false,required this.title,required this.desc,required this.time});

  Task.fromJson(Map<String,dynamic> data):this(
    title: data['title'] as String,
    desc:data['desc'] as String,
      time: data['dateTime'] is Timestamp
          ? (data['dateTime'] as Timestamp).toDate()
          : DateTime.fromMillisecondsSinceEpoch(data['dateTime'] as int),
   // time: DateTime.fromMillisecondsSinceEpoch(data['dateTime']),
    id: data['id'] as String,
    isDone: data['isDone']as bool
  );
  
  Map<String,dynamic> toJson(){
    return {
      'id':id,
      'title':title,
      'desc':desc,
      'dateTime': Timestamp.fromDate(time),
      //'dateTime':time.millisecondsSinceEpoch,
      'isDone':isDone
    };
  }



}