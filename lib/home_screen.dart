import 'package:flutter/material.dart';
import 'package:to_do_app/app_color.dart';
import 'package:to_do_app/list_tab/list_tab.dart';
import 'package:to_do_app/setting_tab/setting_tab.dart';

import 'list_tab/AddTask.dart';

class HomeScreen extends StatefulWidget {
static const String routeName ='home';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text('To Do List',
          style: Theme
              .of(context)
              .textTheme
              .titleLarge,),
      ),
      bottomNavigationBar: BottomAppBar(
        color: AppColors.whiteColor,
        shape: CircularNotchedRectangle(),
        notchMargin: 8,

        child: Theme(
          data: Theme.of(context).copyWith(
              canvasColor: Colors.transparent
          ),

          child: SingleChildScrollView(
            child: BottomNavigationBar(
                currentIndex: selectedIndex,
                onTap: (index) {
                  selectedIndex = index;
                  setState(() {});
                },
                items: [
                  BottomNavigationBarItem(
                      icon: Icon(Icons.list),
                      label: 'list'),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.settings),
                      label: 'setting'),
                ]),
          ),

        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showAddTaskBottomSheet();
        },
        child: Icon(
          Icons.add,
          size: 32,
          color: AppColors.whiteColor,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: MediaQuery
                .of(context)
                .size
                .height * 0.12,
            color: AppColors.primaryColor,
          ),
          tabs[selectedIndex]
        ],
      ),


    );
  }

  List<Widget> tabs = [
    ListTab(), SettingTab()
  ];

  void showAddTaskBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return DraggableScrollableSheet(
          initialChildSize: 0.6,
          minChildSize: 0.3,
          maxChildSize: 0.9,
          expand: false,
          builder: (context, scrollController) {
            return SingleChildScrollView(
              controller: scrollController,
              child: AddTask(),
            );
          },
        );
      },
    );
  }
}
