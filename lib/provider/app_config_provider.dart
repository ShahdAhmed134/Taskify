import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppProvider extends ChangeNotifier{
  String language='en';
  ThemeMode modeApp =ThemeMode.light;
 SharedPreferences? prefs;

  AppProvider() {
    loadPreferences();
  }

  changeLanguage(String newLanguage)async{
    if(language == newLanguage)
      return;
    language=newLanguage;
    notifyListeners();
     prefs= await SharedPreferences.getInstance();
     await prefs?.setString('language', newLanguage);

  }
  changeTheme(ThemeMode newMode)async{
    if(modeApp == newMode)
      return;
    modeApp=newMode;
    notifyListeners();
    prefs=await SharedPreferences.getInstance();
    String nameTheme=newMode==ThemeMode.light?'light':'dark';
    prefs?.setString('theme', nameTheme);
  }

  loadPreferences()async{
    prefs = await SharedPreferences.getInstance();
    language=prefs!.getString('language') ?? 'en';
    String? nameTheme=prefs!.getString('theme');
    modeApp =  nameTheme=='light'?ThemeMode.light : ThemeMode.dark;
    notifyListeners();
  }

}