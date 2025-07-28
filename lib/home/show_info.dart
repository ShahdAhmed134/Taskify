import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app/app_color.dart';
import 'package:to_do_app/auth/login/login_screen.dart';
import 'package:to_do_app/provider/app_config_provider.dart';
import 'package:to_do_app/provider/list_provider.dart';
import 'package:to_do_app/provider/user_provider.dart';

class ShowInfo extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    var authProvider=Provider.of<UserAuthProvider>(context);
  var listProvider=Provider.of<ListProvider>(context);
  var appProvider =Provider.of<AppProvider>(context);
    return Container(
      width: 200,
      height: 150,
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: appProvider.modeApp==ThemeMode.light ?
      AppColors.whiteColor
          :
      AppColors.blackColor,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [Padding(
            padding: const EdgeInsets.only(right: 8.0,bottom: 5),
            child: Icon(Icons.person_2_outlined,
                color: AppColors.primaryColor,
                size: 25),
          ),
            Row(
              children: [
                Text('Hello,',style: TextStyle(
                    color: AppColors.primaryColor,
                    fontWeight: FontWeight.bold
                ),),
                Text(authProvider.currentUser?.name??'Guest',
                  style: TextStyle(
                      color: AppColors.primaryColor,
                      fontWeight: FontWeight.bold
                  ),),

              ],
            ),

            SizedBox(height: 20,),

            InkWell(
              onTap: (){
                listProvider.listTasks=[];
               authProvider.currentUser=null;
                Navigator.pushReplacementNamed(context, LoginScreen.routeName);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Logout',
                    style: TextStyle(
                        color: AppColors.primaryColor,
                        fontWeight: FontWeight.bold
                    ),),

                  Icon(Icons.logout,
                    color: AppColors.primaryColor,)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
