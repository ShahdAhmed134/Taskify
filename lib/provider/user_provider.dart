import 'package:flutter/material.dart';
import 'package:to_do_app/model/user.dart';

class UserAuthProvider extends ChangeNotifier{
  /// data
  MyUser? currentUser;

  void updateUser(MyUser newUser){
    currentUser=newUser;
    notifyListeners();
  }

}