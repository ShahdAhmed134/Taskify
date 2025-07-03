import 'package:flutter/material.dart';
import 'package:to_do_app/app_color.dart';
import 'package:to_do_app/model/task.dart';

class AddListItem extends StatelessWidget {
  Task task;
  AddListItem({required this.task});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(15),
      padding: EdgeInsets.all(5),
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
            height: MediaQuery.of(context).size.height*0.08,
            width: MediaQuery.of(context).size.width*0.009,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(task.title,
                  style: Theme.of(context).textTheme.titleSmall!.copyWith(
                    color: AppColors.primaryColor
                  ),),
                Text(task.desc,
                  style: Theme.of(context).textTheme.titleSmall,)
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(
                vertical: MediaQuery.of(context).size.height*0.007,
                horizontal: MediaQuery.of(context).size.width*0.03,),
            decoration: BoxDecoration(
              color: AppColors.primaryColor,
              borderRadius:BorderRadius.circular(15) ),
            child: Icon(Icons.check,
            color:AppColors.whiteColor,
            size: 32,),
          )
        ],
      ),
    );
  }
}
