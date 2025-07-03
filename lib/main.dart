import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app/home_screen.dart';
import 'package:to_do_app/provider/list_provider.dart';
import 'package:to_do_app/theme_app.dart';

import 'firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,

  );
  await FirebaseFirestore.instance.disableNetwork();
  runApp(ChangeNotifierProvider(
      create: (BuildContext context)=>ListProvider(),
      child: MyApp()));
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
