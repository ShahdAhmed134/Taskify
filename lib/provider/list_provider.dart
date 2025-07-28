import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../firebase_utils.dart';
import '../model/task.dart';

class ListProvider extends ChangeNotifier{
  /// data - function
  List<Task> listTasks=[];
  DateTime selectedDate=DateTime.now();

  void getAllTasks(String uId) async{
    listTasks = await FirebaseUtils.getFilteredAndSortedTasks(selectedDate,uId);

/*    /// filter all tasks
    listTasks= listTasks.where((task){
      if(selectedDate.year == task.time.year &&
         selectedDate.month == task.time.month &&
         selectedDate.day == task.time.day){
        return true;
      }
      return false;
    }).toList();

    /// sort all tasks
    listTasks.sort((Task task1 ,Task task2 ){
      return task2.time.compareTo(task1.time);
    });*/

 /*  for (var task in listTasks) {
      print('${task.title}: ${task.time}');
    }*/
notifyListeners();
  }
  void changeDate(DateTime newSelected,String uId){
    selectedDate=newSelected;
    getAllTasks(uId);
    //notifyListeners();
  }
}