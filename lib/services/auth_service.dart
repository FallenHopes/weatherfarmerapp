import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:weatherfarmer/services/toast_service.dart';
import 'package:flutter/material.dart';

class AuthService with ChangeNotifier{
  String authToken;
  String userName;
  String userEmail;
  SharedPreferences localStorage;

  void login(String email, String password) async{
    try{
      // Здесь по идее запрос к главному серверу для получения данных о пользователе
      Map<String, dynamic> userFromServer = {
        'userName': 'Владислав Серебров',
        'userEmail': email,
        'token': '$email:$password',
        'userId': 3
      };
      String fcmToken = await FirebaseMessaging.instance.getToken();
      print(fcmToken);
      var response = await http.post(
        Uri.http('lit-refuge-90736.herokuapp.com', '/createuser'),
        headers: {
          'Content-Type': 'application/json'
        },
        body: """{
          \"id\": ${userFromServer['userId']}, 
          \"token\": \"${userFromServer['token']}\", 
          \"app_id\": \"$fcmToken\"}
        """
      );
      ToastService.tst(json.decode(response.body)['msg'], Colors.green);
      String token = userFromServer['token'];
      localStorage.setString('authToken', token);
      this.userName = userFromServer['userName'];
      this.userEmail = userFromServer['userEmail'];
      this.authToken = token;
      notifyListeners();
    }catch(e){
      ToastService.tst("Авторизация провалена: $e", Colors.red);
    }
  }

  void logout() async {
    try{
      await http.post(
        Uri.http('lit-refuge-90736.herokuapp.com', '/removeuser'),
        headers: {
          'Content-Type': 'application/json'
        },
        body: """{
          \"token\": \"${localStorage.getString('authToken')}\"
        }"""
      );
      localStorage.remove('authToken');
      this.userName = null;
      this.userEmail = null;
      this.authToken = null;
      notifyListeners();
    }catch(e){
      ToastService.tst("Деавторизация провалена: $e", Colors.red);
    }
  }

  void checkLogin(){
    if (localStorage.getString('authToken') != null){
      // check token validation
      Map<String, dynamic> user = {
        'userName': 'Владислав Серебров',
        'userEmail': 'parob2014@gmail.com'
      };
      this.authToken = localStorage.getString('authToken');
      this.userName = user['userName'];
      this.userEmail = user['userEmail'];
    }
    notifyListeners();
  }
  AuthService({@required this.localStorage});
}