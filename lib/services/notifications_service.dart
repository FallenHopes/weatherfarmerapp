import 'package:weatherfarmer/domain/notification_class.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'toast_service.dart';
import 'package:flutter/material.dart';

class NotificationsService with ChangeNotifier{
  List<NotificationClass> notifications = [];
  bool loading = false;

  void getNotificationsFromServer() async{
    loading = true;
    notifyListeners();
    try {
      var response = await http.post(Uri.http('lit-refuge-90736.herokuapp.com', '/getnotify'));
      json.decode(response.body).forEach((field){
        notifications.add(NotificationClass.fromJson(field));
      });
    } catch (e) {
      ToastService.tst("Загрузка уведомлений не удалась: ${e}", Colors.red);
    }
    loading = false;
    notifyListeners();
  }
  void removeNotification(String id) async{
    // Async code
    notifications.removeWhere((nt) => nt.id == id);
    notifyListeners();
  }
}