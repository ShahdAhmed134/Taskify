import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:to_do_app/model/task.dart';

class FirebaseUtils{

  static CollectionReference<Task> getTaskCollection(){
    return FirebaseFirestore.instance.collection(Task.collectionName).
    withConverter<Task>(
        fromFirestore: (snapshot,option)=> Task.fromJson(snapshot.data()!),
        toFirestore: (task,option)=> task.toJson()
    );
  }
  //add task
  static Future<void> addTaskToFireStore(Task task){
    var collection =getTaskCollection();
    var docRef=collection.doc();
    var autoId =docRef.id;
    task.id = autoId;
    return docRef.set(task);

  }

  static Future<List<Task>> getFilteredAndSortedTasks(DateTime date) async {
    DateTime startOfDay = DateTime(date.year, date.month, date.day);
    DateTime endOfDay = DateTime(date.year, date.month, date.day, 23, 59, 59);

    QuerySnapshot<Task> querySnapshot = await getTaskCollection()
        .where('dateTime', isGreaterThanOrEqualTo: Timestamp.fromDate(startOfDay))
        .where('dateTime', isLessThanOrEqualTo: Timestamp.fromDate(endOfDay))
        .orderBy('dateTime', descending: true) // الأحدث فوق
        .get();

    return querySnapshot.docs.map((doc) => doc.data()).toList();
  }

  static Future<void> deletedTask(Task task){
  return  getTaskCollection().doc(task.id).delete();
  }

/*
  static void getAllTasks(var taskList )async{
      QuerySnapshot<Task> querySnapshot = await getTaskCollection().get();
      // List<QueryDocumentSnapshot<Task>>  => List<Task>
       taskList=querySnapshot.docs.map((doc){
          return doc.data();
      }).toList();

  }*/
}