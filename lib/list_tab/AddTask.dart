import 'package:flutter/material.dart';
import 'package:to_do_app/app_color.dart';

class AddTask extends StatefulWidget {
  const AddTask({super.key});

  @override
  State<AddTask> createState() => _AddTaskState();
}
var selectedDate =DateTime.now();
var formKey= GlobalKey<FormState>();
class _AddTaskState extends State<AddTask> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(20),
       child: Column(
         crossAxisAlignment: CrossAxisAlignment.stretch,
         children: [
           Text('Add New Task',
           textAlign: TextAlign.center,
             style: Theme.of(context).textTheme.titleSmall,
           ),
           SizedBox(
             height: MediaQuery.of(context).size.height*0.02,
           ),
           Form(
             key: formKey,
               child:Column(
                 children: [
                   TextFormField(
                     validator: (value){
                       if(value==null || value.isEmpty){
                         return 'Please enter title';}

                       return null;
                     },
                     style: Theme.of(context).textTheme.labelMedium!.copyWith(
                         color: AppColors.blackColor
                     ),
                     decoration: InputDecoration(
                       hintText: 'enter your task',
                       hintStyle:  Theme.of(context).textTheme.labelMedium,
                       focusedBorder: UnderlineInputBorder(
                         borderSide: BorderSide(
                           color: AppColors.primaryColor,
                         ),

                       ),
                       enabledBorder: UnderlineInputBorder(
                         borderSide: BorderSide(
                           color: AppColors.primaryColor,
                         ),

                       ),
                     ),

                   ),
                   SizedBox(
                     height: MediaQuery.of(context).size.height*0.02,
                   ),
                   TextFormField(
                     validator: (value){
                       if(value==null || value.isEmpty){
                         return 'Please enter description';}

                       return null;
                     },
                     style: Theme.of(context).textTheme.labelMedium!.copyWith(
                       color: AppColors.blackColor
                     ),
                     decoration: InputDecoration(
                       hintText: 'enter your description',
                       hintStyle:  Theme.of(context).textTheme.labelMedium,
                       focusedBorder: UnderlineInputBorder(
                         borderSide: BorderSide(
                           color: AppColors.primaryColor,
                         ),

                       ),
                       enabledBorder: UnderlineInputBorder(
                         borderSide: BorderSide(
                           color: AppColors.primaryColor,
                         ),

                       ),

                     ),
                   ),
                   SizedBox(
                     height: MediaQuery.of(context).size.height*0.02,
                   ),

                 ],
               ) ),
           Text('Select Date',
             //textAlign: TextAlign.start,
             style: Theme.of(context).textTheme.labelLarge,
           ),
           TextButton(
               onPressed: (){
                 ShowCalender();
               }, child:Text('${selectedDate.day}/ ${selectedDate.month}/${selectedDate.year}'
             , style: Theme.of(context).textTheme.labelLarge,)),
           ElevatedButton(
               onPressed: (){
                 addTaskBottomSheet();
               },
               child: Text('Add',
               style: TextStyle(
                 color: AppColors.whiteColor,
                 fontSize: 20
               ),),
             style:ElevatedButton.styleFrom(
               backgroundColor: AppColors.primaryColor
             )
           )
         ],
       ),
      ),
    );
  }

  void ShowCalender()async {
    var chooseDate = await showDatePicker(
        context: context,
        initialDate:  DateTime.now(),
        firstDate: DateTime.now(), 
        lastDate: DateTime.now().add(Duration(days: 365))
    );
    if(chooseDate != null) {
      selectedDate = chooseDate;
    }
    setState(() {

    });
  }

  void addTaskBottomSheet() {
    if(formKey.currentState!.validate())
      print('valid');
  }
}
