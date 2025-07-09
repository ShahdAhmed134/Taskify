import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app/app_color.dart';
import 'package:to_do_app/firebase_utils.dart';
import 'package:to_do_app/model/task.dart';

import '../provider/list_provider.dart';

class AddListItem extends StatelessWidget {
  Task task;
  AddListItem({required this.task});

  @override
  Widget build(BuildContext context) {
    var listProvider=Provider.of<ListProvider>(context);
    return Container(
      margin: EdgeInsets.all(13),
      decoration: BoxDecoration(
        borderRadius:BorderRadius.circular(15),
        color: AppColors.redColor,
      ),
      child: Slidable(
       // key: const ValueKey(0),  // dismissible: DismissiblePane(onDismissed: () {}),
        startActionPane: ActionPane(
          extentRatio: 0.24,
          motion: BehindMotion(),
          children:  [
            SlidableAction(
             padding: EdgeInsets.zero,
              borderRadius: const BorderRadius.only(topLeft: Radius.circular(10),
              bottomLeft:Radius.circular(10)
              ),
              onPressed: (context){
                /// delete the task
                FirebaseUtils.deletedTask(task).timeout(
                  const Duration(seconds: 1),
                   onTimeout: (){
                    print('Task Deleted Successfully');
                    listProvider.getAllTasks();
                   }
                );
              },
              backgroundColor: AppColors.redColor,
              foregroundColor: AppColors.whiteColor,
              icon: Icons.delete,
              label: 'Delete',


            ),
          ],
        ),
        child: Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            borderRadius:BorderRadius.circular(15),
          color: AppColors.whiteColor,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                margin: EdgeInsets.all(10),
                color: AppColors.primaryColor,
                height: MediaQuery.of(context).size.height*0.1,
                width: MediaQuery.of(context).size.width*0.009,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(task.title,
                        style: Theme.of(context).textTheme.titleSmall!.copyWith(
                          color: AppColors.primaryColor
                        ),),
                      Text(task.desc,
                        style: Theme.of(context).textTheme.labelLarge,),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Row(
                          children: [
                          const Icon(Icons.access_time,
                          size: 15,),
                            const SizedBox( width: 7,),
                            Text(
                              '${(task.time.hour % 12 == 0 ? 12 : task.time.hour % 12).toString().padLeft(2, '0')}:${task.time.minute.toString().padLeft(2, '0')} ${task.time.hour >= 12 ? 'PM' : 'AM'}',
                              style: Theme.of(context).textTheme.labelSmall,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(
                    vertical: MediaQuery.of(context).size.height*0.005,
                    horizontal: MediaQuery.of(context).size.width*0.047,),
                decoration: BoxDecoration(
                  color: AppColors.primaryColor,
                  borderRadius:BorderRadius.circular(13) ),
                child: const Icon(Icons.check,
                color:AppColors.whiteColor,
                size: 34,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
