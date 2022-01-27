import 'package:flutter/cupertino.dart';

class Auth with ChangeNotifier{
  bool _loggedIn = false;
  String _username = "";

  bool getLoggedIn () => _loggedIn;
  String getUsername () => _username;

  void login(user){
    _loggedIn=user['loggedIn'];
    _username=user['username'].toString();
    notifyListeners();
  }

  void logout(){
    _loggedIn=false;
    _username="";
    notifyListeners();
  }
}