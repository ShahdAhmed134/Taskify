import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../firebase_utils.dart';
import '../model/task.dart';

class ListProvider extends ChangeNotifier{
  /// data - function
  List<Task> listTasks=[];

  void getAllTasks() async{
    QuerySnapshot<Task> querySnapshot = await FirebaseUtils.getTaskCollection().get();
    /// List<QueryDocumentSnapshot<Task>>  => List<Task>
    listTasks = querySnapshot.docs.map((doc){
      return doc.data();
    }).toList();
notifyListeners();

  }


}