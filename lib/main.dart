import 'package:flutter/material.dart';
import 'package:to_do_app/home_screen.dart';
import 'package:to_do_app/theme_app.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: HomeScreen.routeName,
      routes: {
        HomeScreen.routeName:(context)=>HomeScreen(),
      },
      theme: ThemeApp.lightTheme,
    );
  }

}
