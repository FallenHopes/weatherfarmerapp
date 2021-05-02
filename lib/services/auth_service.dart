import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService with ChangeNotifier{
  String authToken;
  String userName;
  String userEmail;
  SharedPreferences localStorage;

  void login(String email, String password){
    // Async code
    Map<String, String> user = {
      'userName': 'Владислав Серебров',
      'userEmail': email,
      'token': '$email:$password'
    };
    String token = user['token'];
    localStorage.setString('authToken', token);
    this.userName = user['userName'];
    this.userEmail = user['userEmail'];
    this.authToken = token;
    notifyListeners();
  }

  void logout(){
    localStorage.remove('authToken');
    this.userName = null;
    this.userEmail = null;
    this.authToken = null;
    notifyListeners();
  }

  void checkLogin(){
    if (localStorage.getString('authToken') != null){
      this.authToken = localStorage.getString('authToken');
      this.userName = 'Владислав Серебров';
      this.userEmail = 'parob2014@gmail.com';
    }
    notifyListeners();
  }

  AuthService({@required this.localStorage});
}