import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:to_do_app/list_tab/add_list_item.dart';

import '../app_color.dart';

class ListTab extends StatelessWidget {
  const ListTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
    children: [
      EasyDateTimeLine(
        //locale: provider.AppLanguage,
        initialDate:  DateTime.now(),
        onDateChange: (selectedDate) {
        //  providerList.changeSelectDate(selectedDate,authUserProvider.currentUser!.id!);
        },
        headerProps: EasyHeaderProps(
          // padding: EdgeInsets.fromLTRB(15, 5, 5, 15),
         // showMonthPicker: false,
           monthPickerType: MonthPickerType.switcher,
          monthStyle: TextStyle(
            color: AppColors.whiteColor,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
          selectedDateStyle: TextStyle(
            color: AppColors.whiteColor,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
          dateFormatter: DateFormatter.fullDateDayAsStrMY(),
        ),
        dayProps: EasyDayProps(
          borderColor: AppColors.blackColor,
          height: MediaQuery.of(context).size.height * 0.1,
          width: MediaQuery.of(context).size.width * 0.17,
          todayStyle: DayStyle(
            decoration: BoxDecoration(
              color:  Colors.white,
              border: Border.all(color: AppColors.primaryColor, width: 2),
              borderRadius: BorderRadius.circular(10),
            ),
            dayStrStyle: TextStyle(
              fontSize: 12.0,
              fontWeight: FontWeight.bold,
              color:
              Colors.black,
              // Change the text color if needed
            ),
            dayNumStyle: TextStyle(
                color:
               Colors.black,
                fontWeight:
                FontWeight.bold // Change the text color if needed
            ),
          ),
          todayHighlightStyle: TodayHighlightStyle.withBorder,
          todayHighlightColor: AppColors.primaryColor,
          //   todayHighlightStyle: TodayHighlightStyle.withBackground,

          inactiveDayStyle: DayStyle(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color:  Colors.white,
            ),
            dayStrStyle: TextStyle(
              fontSize: 12.0,
              fontWeight: FontWeight.bold,
              color:
            Colors.black,
              // Change the text color if needed
            ),
            dayNumStyle: TextStyle(
                color:
                Colors.black,
                fontWeight:
                FontWeight.bold // Change the text color if needed
            ),
          ),
          dayStructure: DayStructure.dayStrDayNum,
          activeDayStyle: DayStyle(
            dayNumStyle: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: AppColors.primaryColor),
            dayStrStyle: TextStyle(
                fontSize: 13.0,
                fontWeight: FontWeight.bold,
                color: AppColors.primaryColor),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(8)),
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xffffffff), Color(0xffffffff)],
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
            itemBuilder: (context,int)
        {
          return AddListItem();
        },
          itemCount: 10,

        ),
      )
    ],
    );
  }
}
