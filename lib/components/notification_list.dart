import 'package:flutter/material.dart';
import 'package:weatherfarmer/screens/field_screen.dart';
import 'package:provider/provider.dart';
import 'package:weatherfarmer/services/notifications_service.dart';

class NotificationList extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    if (context.watch<NotificationsService>().loading == true){
      return Scaffold(
        body: Container(
          alignment: Alignment.center,
          child: Text("Загрузка...")
        ),
      );
    }
    return Container(
      child: context.watch<NotificationsService>().notifications.length != 0 ? ListView.builder(
        physics: BouncingScrollPhysics(),
        itemCount: context.watch<NotificationsService>().notifications.length,
        itemBuilder: (context, i){
          return Card(
            elevation: 2.0,
            margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            child: Container(
              child: ListTile(
                leading: Icon(Icons.wb_sunny, size: 35.0, color: Colors.black),
                contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                title: Text(
                  context.watch<NotificationsService>().notifications[i].title, 
                  style: TextStyle(
                    fontWeight: FontWeight.bold
                  )
                ),
                trailing: Icon(Icons.keyboard_arrow_right),
                subtitle: Text("${context.watch<NotificationsService>().notifications[i].square} га"),
                onTap: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (ctx) => FieldScreen(
                        field: context.watch<NotificationsService>().notifications[i],
                        oldContext: context,
                      )
                    )
                  );
                },
              ),
            ),
          );
        },
      ) : Scaffold(
        body: Container(
          alignment: Alignment.center,
          child: Text(
            "Уведомлений пока нет",
            style: TextStyle(fontSize: 15),
          )
        ),
      )
    );
  }
}