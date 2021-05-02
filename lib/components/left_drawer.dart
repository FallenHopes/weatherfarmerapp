import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weatherfarmer/services/auth_service.dart';
import 'package:weatherfarmer/services/notifications_service.dart';
import 'package:weatherfarmer/services/reports_service.dart';

class LeftPanel extends StatelessWidget {
  var screenChanger;
  LeftPanel({@required this.screenChanger});
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
          children: <Widget>[
            DrawerHeader(
              margin: EdgeInsets.zero,
              padding: EdgeInsets.zero,
              child: UserAccountsDrawerHeader(
                decoration: BoxDecoration(color: Theme.of(context).primaryColor),
                accountName: Text("${context.watch<AuthService>().userName}"),
                accountEmail: Text("${context.watch<AuthService>().userEmail}"),
              ),
            ),
            ListTile(
              leading: Icon(Icons.add_alert),
              title: Text("Уведомления"),
              onTap: (){
                screenChanger(0);
                Navigator.of(context).pop();
              },
              trailing: context.watch<NotificationsService>().notifications != null 
              &&
              context.watch<NotificationsService>().notifications.length != 0
              ? Container(
                width: 25,
                height: 25,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor
                ),
                child: Text(
                  "${context.watch<NotificationsService>().notifications.length}",
                  style: TextStyle(
                    color: Colors.white
                  ),
                ),
              )
              :
              null
            ),
            ListTile(
              leading: Icon(Icons.assignment),
              title: Text("Отчёты"),
              onTap: (){
                screenChanger(1);
                Navigator.of(context).pop();
              },
              trailing: Container(
                width: 25,
                height: 25,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor
                ),
                child: Text(
                  "${context.watch<ReportsService>().reports.length}",
                  style: TextStyle(
                    color: Colors.white
                  )
                ),
              )
            ),
            ListTile(
              leading: Icon(Icons.exit_to_app),
              title: Text("Выход"),
              onTap: () => context.read<AuthService>().logout(),
            )
          ],
        ),
    );
  }
}