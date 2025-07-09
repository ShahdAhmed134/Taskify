
import 'package:flutter/material.dart';
import 'package:to_do_app/app_color.dart';

class DialogUtils{
  static void showLoading(BuildContext context){
   showDialog(
     barrierDismissible: false,
       context: context,
       builder: (context){
         return AlertDialog(
           content: Row(
             children: [
               CircularProgressIndicator(
                 color: AppColors.primaryColor,
               ),
               Padding(
                 padding: const EdgeInsets.all(12.0),
                 child: Text('Loading...',
                 style: Theme.of(context).textTheme.labelLarge,),
               )
             ],
           ),
         );
       });
  }

  static void hideLoading(BuildContext context){
    Navigator.of(context).pop();
  }

  static void showMassage({required BuildContext context, required String title,
    required String content, String? posActionName,Function? posAction,
    String? negActionName,Function? negAction,
  }){
    List<Widget> actions =[];
    if(posActionName !=null){
      actions.add(
          TextButton(
        onPressed: () {
          Navigator.of(context).pop();
          posAction?.call();
        }, child:
      Text(posActionName,
        style: Theme
            .of(context)
            .textTheme
            .titleSmall!
            .copyWith(
          color: AppColors.primaryColor,

      ),)
      ));
    
    }
    if(negActionName !=null){
      actions.add(
          TextButton(
            onPressed: (){
        Navigator.of(context).pop();
        negAction?.call();
      },
            child: Text(negActionName),)
      );
     
    }
    showDialog(
      barrierDismissible: false,
        context: context,
        builder: (context){
          return AlertDialog(
            title:Text(title,
              style: Theme
                  .of(context)
              .textTheme
              .titleSmall!
              .copyWith(
            color: AppColors.primaryColor,)

            ),
            content:Text(content,
          style: Theme
              .of(context)
              .textTheme
              .labelLarge!
              ) ,
            actions: actions,

          );
        });
  }
}