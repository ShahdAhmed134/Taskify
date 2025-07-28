import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app/firebase_utils.dart';
import 'package:to_do_app/list_tab/add_list_item.dart';
import 'package:to_do_app/model/task.dart';
import 'package:to_do_app/provider/app_config_provider.dart';
import 'package:to_do_app/provider/list_provider.dart';

import '../app_color.dart';
import '../provider/user_provider.dart';

class ListTab extends StatefulWidget {
   ListTab({super.key});

  @override
  State<ListTab> createState() => _ListTabState();
}

class _ListTabState extends State<ListTab> {


  @override
  Widget build(BuildContext context) {
    var listProvider=Provider.of<ListProvider>(context);
    var authProvider=Provider.of<UserAuthProvider>(context);
    var appProvider =Provider.of<AppProvider>(context);
    if(listProvider.listTasks.isEmpty){
    listProvider.getAllTasks(authProvider.currentUser?.id ?? "no-id");
    }
    return Column(
    children: [
      EasyDateTimeLine(
        locale: appProvider.language,
        initialDate: listProvider.selectedDate,
        onDateChange: (selectedDate) {
          listProvider.changeDate(selectedDate,authProvider.currentUser!.id!);
        },
        headerProps:  EasyHeaderProps(
          // padding: EdgeInsets.fromLTRB(15, 5, 5, 15),
          //showMonthPicker: false,
          monthPickerType: MonthPickerType.switcher,
          monthStyle: TextStyle(

            color:appProvider.modeApp==ThemeMode.light ?
          AppColors.whiteColor
            :
            AppColors.blackColor,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),

          selectedDateStyle: TextStyle(
            color:   appProvider.modeApp==ThemeMode.light ?
          AppColors.whiteColor
            :
            AppColors.blackColor,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
          dateFormatter: appProvider.language == 'ar'
              ? DateFormatter.custom('EEE، d MMMM yyyy')
              : DateFormatter.fullDateDayAsStrMY(),

        ),
        dayProps: EasyDayProps(
          borderColor: AppColors.blackColor,
          height: MediaQuery.of(context).size.height * 0.1,
          width: MediaQuery.of(context).size.width * 0.17,
          todayStyle: DayStyle(
            decoration: BoxDecoration(
              color:appProvider.modeApp==ThemeMode.light ?
            AppColors.whiteColor
              :
              AppColors.blackColor,
              border: Border.all(color: AppColors.primaryColor, width: 2),
              borderRadius: BorderRadius.circular(10),
            ),
            dayStrStyle: TextStyle(
              fontSize: 12.0,
              fontWeight: FontWeight.bold,
              color:AppColors.primaryColor
              // Change the text color if needed
            ),
            dayNumStyle: TextStyle(
                color:AppColors.primaryColor,
                fontWeight:
                FontWeight.bold // Change the text color if needed
            ),
          ),
        //  todayHighlightStyle: TodayHighlightStyle.withBorder,
          todayHighlightColor: AppColors.primaryColor,

          inactiveDayStyle: DayStyle(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: appProvider.modeApp==ThemeMode.light ?
            AppColors.whiteColor
              :
              AppColors.blackColor,
            ),
            dayStrStyle: TextStyle(
              locale: Locale(appProvider.language),
              fontSize: 12.0,
              fontWeight: FontWeight.bold,
              color:appProvider.modeApp==ThemeMode.light ?
            AppColors.blackColor
                :
                AppColors.whiteColor,
              // Change the text color if needed
            ),
            dayNumStyle: TextStyle( locale: Locale(appProvider.language),
                color:appProvider.modeApp==ThemeMode.light ?
                AppColors.blackColor
                    :
                AppColors.whiteColor,
                fontWeight:
                FontWeight.bold // Change the text color if needed
            ),
          ),
          dayStructure: DayStructure.dayStrDayNum,
          activeDayStyle: DayStyle(
            dayNumStyle: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color:appProvider.modeApp==ThemeMode.light ?
                AppColors.blackColor
                    :
                AppColors.whiteColor,),
            dayStrStyle: TextStyle(
                fontSize: 13.0,
                fontWeight: FontWeight.bold,
                color: appProvider.modeApp==ThemeMode.light ?
                AppColors.blackColor
                    :
                AppColors.whiteColor,),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(8)),
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: appProvider.modeApp==ThemeMode.light ?
                         [Color(0xffffffff), Color(0xffffffff),Color(0xff5D9CEC)]:
                [Color(0xff141922), Color(0xff262b33),Color(0xd25d9cec) ]
              ),
            ),
          ),
        ),
        timeLineProps: const EasyTimeLineProps(
          hPadding: 16.0, // padding from left and right
          separatorPadding: 16.0,
          // margin: EdgeInsets.all(10)// padding between days
        ),
      ),
      Expanded(
        child: ListView.builder(
            itemBuilder: (context,index)
        {
          return AddListItem(task: listProvider.listTasks[index]);
        },
          itemCount: listProvider.listTasks.length,

        ),
      )
    ],
    );
  }




}


