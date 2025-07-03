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
/*
  static void getAllTasks(var taskList )async{
      QuerySnapshot<Task> querySnapshot = await getTaskCollection().get();
      // List<QueryDocumentSnapshot<Task>>  => List<Task>
       taskList=querySnapshot.docs.map((doc){
          return doc.data();
      }).toList();

  }*/
}