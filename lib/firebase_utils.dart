import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:to_do_app/model/task.dart';
import 'package:to_do_app/model/user.dart';

class FirebaseUtils{

  static CollectionReference<Task> getTaskCollection(String uId){
    return getUserCollection().doc(uId)
        .collection(Task.collectionName).
    withConverter<Task>(
        fromFirestore: (snapshot,option)=> Task.fromJson(snapshot.data()!),
        toFirestore: (task,option)=> task.toJson()
    );
  }
  //add task
  static Future<void> addTaskToFireStore(Task task, String uId){
    var collection =getTaskCollection(uId);
    var docRef=collection.doc();
    var autoId =docRef.id;
    task.id = autoId;
    return docRef.set(task);

  }

  static Future<List<Task>> getFilteredAndSortedTasks(DateTime date,String uId) async {
    DateTime startOfDay = DateTime(date.year, date.month, date.day);
    DateTime endOfDay = DateTime(date.year, date.month, date.day, 23, 59, 59);

    QuerySnapshot<Task> querySnapshot = await getTaskCollection(uId)
        .where('dateTime', isGreaterThanOrEqualTo: Timestamp.fromDate(startOfDay))
        .where('dateTime', isLessThanOrEqualTo: Timestamp.fromDate(endOfDay))
        .orderBy('dateTime', descending: true) // الأحدث فوق
        .get();

    return querySnapshot.docs.map((doc) => doc.data()).toList();
  }

  static Future<void> deletedTask(Task task,String uId){
  return  getTaskCollection(uId).doc(task.id).delete();
  }


  static Future<void> editIsDone(String uId, Task task){
     return getTaskCollection(uId).doc(task.id).update({
       'isDone':task.isDone
     });

  }

  static Future<void> editTask(String uId, Task task){
    return getTaskCollection(uId).doc(task.id).update(task.toJson());

  }
/*
  static void getAllTasks(var taskList )async{
      QuerySnapshot<Task> querySnapshot = await getTaskCollection().get();
      // List<QueryDocumentSnapshot<Task>>  => List<Task>
       taskList=querySnapshot.docs.map((doc){
          return doc.data();
      }).toList();

  }*/

  static CollectionReference<MyUser> getUserCollection(){
    return FirebaseFirestore.instance.collection(MyUser.CollectionName).
    withConverter<MyUser>(
        fromFirestore: (snapshot,option)=>MyUser.fromFireStore(snapshot.data()),
        toFirestore: (myUser,option)=>myUser.toFireStore());
  }
  static Future<void> addUserToFireStore(MyUser myUser){
    return getUserCollection().doc(myUser.id).set(myUser);
  }
  static Future<MyUser?>getUserFromFireStore(String uId)async{
    var querySnapshot=await getUserCollection().doc(uId).get();
    return querySnapshot.data();
  }

}