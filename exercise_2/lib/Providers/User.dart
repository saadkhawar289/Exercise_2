import 'package:exercise_2/Models/User.dart';
import 'package:flutter/material.dart';

class UserActivityModel extends ChangeNotifier {
  String token='';
   bool isLoggedIn=false;
 final List<User> allUsers=[];






  bool get checkAuth{
    return isLoggedIn?true:false;
  }

  void loggedIn(){
    isLoggedIn=true;
    notifyListeners();
  }

  void addEmployee(User user){
    allUsers.add(user);
    notifyListeners();

  }

  void delEmployee(int index){
    allUsers.removeAt(index);
    notifyListeners();

  }
}

