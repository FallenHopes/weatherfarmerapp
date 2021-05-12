import 'package:weatherfarmer/domain/notification_class.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'toast_service.dart';
import 'package:flutter/material.dart';

class NotificationsService with ChangeNotifier{
  List<NotificationClass> notifications = [];
  bool loading = false;

  void getNotificationsFromServer(String token) async{
    loading = true;
    notifyListeners();
    try {
      var response = await http.post(
        Uri.http('lit-refuge-90736.herokuapp.com', '/getnotify'), 
        headers: { 'Content-Type': 'application/json' },
        body: "{ \"token\": \"$token\"}"
      );
      if (response.statusCode == 200){
        print(json.decode(response.body));
        json.decode(response.body).forEach((field){
          notifications.add(NotificationClass.fromJson(field));
        });
      }
      else{
        throw new Exception('Ошибка при запросе');
      }
    } catch (e) {
      print(e);
      ToastService.tst("Загрузка уведомлений не удалась: $e", Colors.red);
    }
    loading = false;
    notifyListeners();
  }
  void removeNotification(int id) async{
    try{
      await http.post(
        Uri.http('lit-refuge-90736.herokuapp.com', '/removenotify'), 
        headers: {'Content-Type': 'application/json'},
        body: "{\"notification_id\": \"$id\" }"
      );
      notifications.removeWhere((nt) => nt.id == id);
      notifyListeners();
    }catch(e){
      ToastService.tst("Запрос провален: $e", Colors.red);
    }
  }
}